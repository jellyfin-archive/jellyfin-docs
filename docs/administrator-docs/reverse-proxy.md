# Running Jellyfin Behind a Reverse Proxy

It's possible to run Jellyfin behind another server acting as a reverse proxy.  With a reverse proxy setup, this server handles all network traffic and proxies it back to Jellyfin. This provides the benefits of using DNS names and not having to remember port numbers, as well as easier integration and management of SSL certificates.

Three popular options for reverse proxy systems are [Apache](https://httpd.apache.org/), [Haproxy](https://www.haproxy.com/), and [Nginx](https://www.nginx.com/).

**Important:** In order for a reverse proxy to have the maximum benefit, you should have a publically routable IP address and a domain with DNS set up correctly.  These examples assume you want to run Jellyfin under a sub-domain (ie: jellyfin.example.com), but are easily adapted for the root domain if desired.

When following this guide, be sure to replace the following variables with your information:

  * `DOMAIN_NAME` - Your public domain name to access Jellyfin on (e.g. jellyfin.example.com)
  * `SERVER_IP_ADDRESS` - The IP address of your Jellyfin server (if the reverse proxy is on the same server use 127.0.0.1)

In addition, the examples are configured for use with LetsEncrypt certificates.  If you have a certificate from another source, change the ssl configuration from `/etc/letsencrypt/DOMAIN_NAME/` to the location of your certificate and key.
Ports 80 and 443 (pointing to the proxy server) need to be opened on your Firewall/Router.

## Apache

```
<VirtualHost *:80>
    ServerName DOMAIN_NAME

    # Uncomment for HTTP to HTTPS redirect
    # Redirect permanent / https://DOMAIN_NAME

    ErrorLog /var/log/apache2/DOMAIN_NAME-error.log
    CustomLog /var/log/apache2/DOMAIN_NAME-access.log combined
</VirtualHost>

# Uncomment this section after you have acquired a SSL Certificate
# If you are not using a SSL certificate, replace the 'redirect'
# line above with all lines below starting with 'Proxy'
#<IfModule mod_ssl.c>
#<VirtualHost *:443>
#    ServerName DOMAIN_NAME
#
#    ProxyPreserveHost On
#
#    ProxyPass "/embywebsocket" "ws://SERVER_IP_ADDRESS:8096/embywebsocket"
#    ProxyPassReverse "/embywebsocket" "ws://SERVER_IP_ADDRESS:8096/embywebsocket"
#
#    ProxyPass "/" "http://SERVER_IP_ADDRESS:8096/"
#    ProxyPassReverse "/" "http://SERVER_IP_ADDRESS:8096/"
#
#    SSLEngine on
#    SSLCertificateFile /etc/letsencrypt/DOMAIN_NAME/fullchain.pem
#    SSLCertificateKeyFile /etc/letsencrypt/DOMAIN_NAME/privkey.pem
#    Protocols h2 http/1.1
#
#    ErrorLog /var/log/apache2/DOMAIN_NAME-error.log
#    CustomLog /var/log/apache2/DOMAIN_NAME-access.log combined
#</VirtualHost>
#</IfModule>
```

If you encouter errors, you may have to enable `mod_proxy` or `mod_ssl` support manually.
```
$ sudo a2enmod proxy proxy_http ssl
```

## HAProxy

```
frontend jellyfin_proxy
    bind *:80

# Note that haproxy requires you to concatenate the certificate and key into a single file
# Uncomment the appropriate lines after you have acquired a SSL Certificate
## HAProxy <1.7
#    bind *:443 ssl crt /etc/ssl/DOMAIN_NAME.pem
## HAProxy >1.8
#    bind *:443 ssl crt /etc/ssl/DOMAIN_NAME.pem alpn h2,http/1.1
#    redirect scheme https if !{ ssl_fc }

# Uncomment these lines to allow LetsEncrypt authentication
#    acl letsencrypt_auth path_beg /.well-known/acme-challenge/
#    use_backend letsencrypt if letsencrypt_auth

    acl jellyfin_server hdr(host) -i DOMAIN_NAME
    use_backend jellyfin if jellyfin_server

backend jellyfin
    http-request set-header X-Forwarded-Port %[dst_port]
    http-request add-header X-Forwarded-Proto https if { ssl_fc }
    server jellyfin SERVER_IP_ADDRESS:8096

# Uncomment these lines to allow LetsEncrypt authentication
#backend letsencrypt
#    server letsencrypt 127.0.0.1:8888
```

## Nginx

Create the following file ``/etc/nginx/conf.d/jellyfin.conf``

```
server {
    listen 80;
    server_name DOMAIN_NAME;

    # Uncomment to redirect HTTP to HTTPS
    # return 301 https://$host$request_uri;
}

# Uncomment this section after you have acquired a SSL Certificate
#server {
#    listen 443 ssl http2;
#    server_name DOMAIN_NAME;
#    ssl_certificate /etc/letsencrypt/live/DOMAIN_NAME/fullchain.pem;
#    ssl_certificate_key /etc/letsencrypt/live/DOMAIN_NAME/privkey.pem;
#    include /etc/letsencrypt/options-ssl-nginx.conf;
#    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
#    add_header Strict-Transport-Security "max-age=31536000" always;
#    ssl_trusted_certificate /etc/letsencrypt/live/DOMAIN_NAME/chain.pem;
#    ssl_stapling on;
#    ssl_stapling_verify on;
#
#    location / {
#        # Proxy main Jellyfin traffic
#        proxy_pass http://SERVER_IP_ADDRESS:8096;
#        proxy_set_header Host $host;
#        proxy_set_header X-Real-IP $remote_addr;
#        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#        proxy_set_header X-Forwarded-Proto $scheme;
#        proxy_set_header X-Forwarded-Protocol $scheme;
#        proxy_set_header X-Forwarded-Host $http_host;
#
#        # Disable buffering when the nginx proxy gets very resource heavy upon streaming
#        proxy_buffering off;
#    }
#    location /embywebsocket {
#        # Proxy Jellyfin Websockets traffic
#        proxy_pass http://SERVER_IP_ADDRESS:8096;
#        proxy_http_version 1.1;
#        proxy_set_header Upgrade $http_upgrade;
#        proxy_set_header Connection "upgrade";
#        proxy_set_header Host $host;
#        proxy_set_header X-Real-IP $remote_addr;
#        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#        proxy_set_header X-Forwarded-Proto $scheme;
#        proxy_set_header X-Forwarded-Protocol $scheme;
#        proxy_set_header X-Forwarded-Host $http_host;
#    }
#}
```

## Nginx with subpath

When connecting to server from a client application, enter ``http(s)://DOMAIN_NAME/jellyfin`` in the address field, and **clear the port field**.
Not all clients may handle this properly, but this is currently working for the web and Android clients.

```
# Jellyfin hosted on http(s)://DOMAIN_NAME/jellyfin

server {
    listen 80;
    listen [::]:80;

    server_name DOMAIN_NAME;
    # You can specify multiple domain names if you want
    #server_name jellyfin.local;

    # Uncomment and create directory to also host static content
    #root /srv/http/media;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    # Jellyfin
    location /jellyfin {
        return 302 $scheme://$host/jellyfin/;
    }

    location /jellyfin/ {
        # Proxy main Jellyfin traffic
        # The / at the end is significant.
        proxy_pass http://SERVER_IP_ADDRESS:8096/;

        proxy_pass_request_headers on;

        proxy_set_header Host $host;

        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
    }
}
```


## LetsEncrypt with Certbot

LetsEncrypt is a service that provides free SSL/TLS certificates to users.  Certbot is a client that makes this easy to accomplish and automate.  In addition, it has plugins for Apache and Nginx that make automating certificate generation even easier.

Installation instructions for most Linux distributions can be found on the [Certbot website](https://certbot.eff.org/docs/install.html#operating-system-packages).

Once the packages are installed, you're ready to generate a new certificate.

### Apache

After installing certbot and the Apache plugin, certificate generation is accomplished by:

``certbot certonly --apache --noninteractive --agree-tos --email YOUR_EMAIL -d DOMAIN_NAME``

Update the 'SSLCertificateFile' and 'SSLCertificateKeyFile' sections, then restart the service.

Add a job to cron so the certificate will be renwed automatically:

``echo "0 0 * * *  root  certbot renew --quiet --no-self-upgrade --post-hook 'systemctl reload apache2'" | sudo tee -a /etc/cron.d/renew_certbot``

### HAProxy

HAProxy doesn't currently have a certbot plugin.  To get around this, run certbot in standalone mode and proxy traffic back to it.  

Enable the frontend and backend in the config above, and then run:

``certbot certonly --standalone --preferred-challenges http-01 --http-01-port 8888 --noninteractive --agree-tos --email YOUR_EMAIL -d DOMAIN_NAME``

The port can be changed to anything you like, but be sure that the HAProxy config and your certbot command match.

Haproxy needs to have the certificate and key files concatenated into the same file to read it correctly.  This can be accomplished with the following command.

``cat /etc/letsencrypt/live/DOMAIN_NAME/fullchain.pem /etc/letsencrypt/live/DOMAIN_NAME/privkey.pem > /etc/ssl/DOMAIN_NAME.pem``

Uncomment `bind *:443` and the redirect section in the configuration, then reload the service.

#### Automatic Certificate Renewal

Place the following script in `/usr/local/bin/` to automatically update your SSL certificate:

```
SITE=DOMAIN_NAME

# move to the correct let's encrypt directory
cd /etc/letsencrypt/live/$SITE

# cat files to make combined .pem for haproxy
cat fullchain.pem privkey.pem > /etc/ssl/$SITE.pem

# reload haproxy
service haproxy reload
```

Make sure the script is executable

 ``chmod u+x /usr/local/bin/letsencrypt-renew.sh``

Add a job to cron so the certificate will be renewed automatically:

 ``@monthly /usr/bin/certbot renew --renew-hook "/usr/local/bin/letsencrypt-renew.sh" >> /var/log/letsencrypt-renewal.log``

### Nginx

After installing certbot and the Nginx plugin with ``sudo apt install certbot python3-certbot-nginx``, certificate generation is accomplished by:

`sudo certbot --nginx --agree-tos --redirect --hsts --staple-ocsp --email YOUR_EMAIL -d YOUR_DOMAIN`
(Add the ``--rsa-key-size 4096`` parameter if you want a 4096 bit key instead)

Copy and paste the whole Nginx sample configuration file from above, changing the parameters according to your setup and uncommenting the lines.

Add a job to cron so the certificate will be renewed automatically:

`echo "0 0 * * *  root  certbot renew --quiet --no-self-upgrade --post-hook 'systemctl reload nginx'" | sudo tee -a /etc/cron.d/renew_certbot`

## Traefik (with docker-compose)

Traefik is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Traefik integrates with your existing infrastructure components (Docker, Swarm mode, Kubernetes, Marathon, Consul, Etcd, Rancher, Amazon ECS, ...) and configures itself automatically and dynamically. Pointing Traefik at your orchestrator should be the only configuration step you need. (https://traefik.io/)

Traefik needs 3 files in the SAME directory (or you must change pathes in the volume section) : docker-compose.yml, traefik.toml and acme.json.

This configuration is A+ (SSLlabs)

docker-compose.yml :

```
version: '3'

services:
  proxy:
    container_name: Traefik
    image: traefik:alpine
    command: --web --docker --docker.domain=${DOMAIN} --logLevel="INFO"
    networks:
      - traefik
    ports:
      - 80:80
      - 443:443
    expose:
      - 8080
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./traefik.toml:/traefik.toml
      - ./acme.json:/acme.json
    restart: unless-stopped
    labels:
      - "traefik.frontend.rule=Host:${DOMAIN_OF_THE_WEB_ADMIN_INTERFACE}"
      - "traefik.port=8080"
      - "traefik.backend=Traefik-Admin"
      - "traefik.frontend.entryPoints=https"
      - "traefik.frontend.headers.forceSTSHeader=true"
      - "traefik.frontend.headers.STSSeconds=315360000"
      - "traefik.frontend.headers.STSIncludeSubdomains=true"
      - "traefik.frontend.headers.STSPreload=true"
networks:
  traefik:
    external: true
```

 For security, add a password to the traefik interface (DOMAIN_OF_THE_WEB_ADMIN_INTERFACE, traefik.mysite.com for exemple) :
 
 `echo $(htpasswd -nbB <USER> "<PASS>") | sed -e s/\\$/\\$\\$/g`
 
 The output will be for example (it will be a different result for each time you run the command above):

 `<USER>:$$apr1$$ryHGa8yK$$5lRELezhgkUtJxiJ.XTfZ.`

This output needs to be placed in our docker-compose.yml now as a (traefik) label and add this label :

` - "traefik.frontend.auth.basic=<USER-PASSWORD-OUTPUT>"`

 
 traefik.toml : 
 
```


logLevel = "DEBUG"
defaultEntryPoints = ["http", "https"]

[docker]
domain = "${DOMAIN}"
watch = true

[entryPoints]
  [entryPoints.http]
  address = ":80"
    [entryPoints.http.redirect]
    entryPoint = "https"
  [entryPoints.https]
  address = ":443"
    [entryPoints.https.tls]
    minVersion = "VersionTLS12"
    cipherSuites = [
      "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
      "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
      "TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305",
      "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305",
      "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
      "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
      "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",
      "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256"
    ]

[acme]
  email="yourmail@mail.com"
  storage="acme.json"
  entryPoint="https"
  acmeLogging=true
  onDemand=false
  OnHostRule=true
[acme.httpChallenge]
  entryPoint = "http"


```

Finally, create an empty acme.json : `touch acme.json` `chmod 600 acme.json` 

IMPORTANT ! Change ${DOMAIN} by your domain / subdomain name, and change the mail of the acme (yourmail@mail.com in traefik.toml)

Launch Traefik : `docker-compose up -d`

Congratulation, your RP is UP !

For Jellyfin, just launch your Jellyfin server with this docker-compose `docker-compose up -d`.

Note you must change the ${JELLYFIN_DOMAIN} for your domain, like jellyfin.mydomain.xyz for exemple.

```

version: '2'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: Jellyfin
    restart: always
    labels:
      - "traefik.frontend.rule=Host:${JELLYFIN_DOMAIN}"
      - "traefik.port=8096"
      - "traefik.backend=JellyFin"
      - "traefik.frontend.entryPoints=https"
      - "traefik.frontend.headers.forceSTSHeader=true"
      - "traefik.frontend.headers.STSSeconds=315360000"
      - "traefik.frontend.headers.STSIncludeSubdomains=true"
      - "traefik.frontend.headers.STSPreload=true"
    expose:
      - 8096
    volumes:
      - /path/to/data:/share:rw
      - ./conf:/config:rw
      - /etc/localtime:/etc/localtime:ro
    environment:
      - APP_UID=1000
      - APP_GID=100
      - GIDLIST=100 #A comma-separated list of additional GIDs to run emby as (default 2)#
      - TZ=Europe/Paris
    networks:
      - traefik

networks:
  traefik:
    external: true


```

Go to jellyfin.mysite.xyz (in this case), and your Jellyfin is UP and HTTPS (AES 256).

# Final steps

It's strongly recommend that you check your SSL strength and server security at [SSLLabs](https://www.ssllabs.com/ssltest/analyze.html)
