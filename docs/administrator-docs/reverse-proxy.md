# Running Jellyfin Behind a Reverse Proxy

It's possible to run Jellyfin behind another server acting as a reverse proxy.  With a reverse proxy setup, this alternative server handles all network traffic and proxies it back to Jellyfin.  This has the benefit of having nice DNS names and not having to remember port numbers, as well as easier integration with SSL certificates.

Three popular options for reverse proxy systems are [Apache](https://httpd.apache.org/), [Haproxy](https://www.haproxy.com/), and [Nginx](https://www.nginx.com/).

## Apache

```
<VirtualHost *:80>
    ServerAdmin master@jellyfin.example.com
    ServerName jellyfin.example.com
    
    Redirect permanent / https://jellyfin.example.com
    
    ErrorLog /var/log/apache2/jellyfin.example.com-error.log
    CustomLog /var/log/apache2/jellyfin.example.com-access.log combined
</VirtualHost>

<IfModule mod_ssl.c>
<VirtualHost *:443>
    ServerAdmin master@jellyfin.example.com
    ServerName jellyfin.example.com

    ProxyPreserveHost On

    ProxyPass "/embywebsocket" "ws://127.0.0.1:8096/embywebsocket"
    ProxyPassReverse "/embywebsocket" "ws://127.0.0.1:8096/embywebsocket"

    ProxyPass "/" "http://127.0.0.1:8096/"
    ProxyPassReverse "/" "http://127.0.0.1:8096/"

    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/jellyfin.example.com/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/jellyfin.example.com/privkey.pem
    Protocols h2 http/1.1

    ErrorLog /var/log/apache2/jellyfin.example.com-error.log
    CustomLog /var/log/apache2/jellyfin.example.com-access.log combined
</VirtualHost>
</IfModule>
```

If you encouter errors, you may have to enable `mod_proxy` or `mod_ssl` support manually.
```
$ sudo a2enmod proxy proxy_http
$ sudo a2enmod ssl
```

## Haproxy

```
frontend jellyfin_proxy
    bind *:80
# Note that haproxy requires you to concatenate the certificate and key into a single file
## Note that if you're using haproxy 1.8+, you can enable http2 by swapping these lines
##   bind *:443 ssl crt /etc/letsencrypt/live/jellyfin.example.com/complete.pem alpn h2,http/1.1
    bind *:443 ssl crt /etc/letsencrypt/live/jellyfin.example.com/complete.pem
    redirect scheme https if !{ ssl_fc }

    acl jellyfin_server hdr(host) -i jellyfin.example.com
    use_backend jellyfin if jellyfin_server

backend jellyfin
    http-request set-header X-Forwarded-Port %[dst_port]
    http-request add-header X-Forwarded-Proto https if { ssl_fc }
    server jellyfin 127.0.0.1:8096
```

## Nginx

```
server {
    listen 80;
    server_name jellyfin.example.com;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    server_name jellyfin.example.com;
    ssl_certificate /etc/letsencrypt/live/jellyfin.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/jellyfin.example.com/privkey.pem;

    location / {
        proxy_pass http://127.0.0.1:8096;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-for $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto $remote_addr;
        proxy_set_header X-Forwarded-Protocol $scheme;
        proxy_redirect off;
    
        # Send websocket data to the backend aswell
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```
