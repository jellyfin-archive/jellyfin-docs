---
uid: admin-reverse-proxy
title: Reverse Proxy
---

# Running Jellyfin Behind a Reverse Proxy

It's possible to run Jellyfin behind another server acting as a reverse proxy.  With a reverse proxy setup, this server handles all network traffic and proxies it back to Jellyfin. This provides the benefits of using DNS names and not having to remember port numbers, as well as easier integration and management of SSL certificates.

Some popular options for reverse proxy systems are [Apache](https://httpd.apache.org/), [Haproxy](https://www.haproxy.com/), [Nginx](https://www.nginx.com/), [Caddy](https://caddyserver.com/) and [Traefik](https://traefik.io/).

> [!WARNING]
> In order for a reverse proxy to have the maximum benefit, you should have a publically routable IP address and a domain with DNS set up correctly.  These examples assume you want to run Jellyfin under a sub-domain (ie: jellyfin.example.com), but are easily adapted for the root domain if desired. Running Jellyfin in a Path (example.com/jellyfin/) is supported by the Android and web clients. Sonarr and Radarr currently do not support Paths and their APIs will fail to communicate with Jellyfin.

When following this guide, be sure to replace the following variables with your information:

* `DOMAIN_NAME` - Your public domain name to access Jellyfin on (e.g. jellyfin.example.com)
* `example.com` - The domain name Jellyfin services will run under (e.g. example.com)
* `SERVER_IP_ADDRESS` - The IP address of your Jellyfin server (if the reverse proxy is on the same server use 127.0.0.1)

In addition, the examples are configured for use with LetsEncrypt certificates.  If you have a certificate from another source, change the ssl configuration from `/etc/letsencrypt/DOMAIN_NAME/` to the location of your certificate and key.

Ports 80 and 443 (pointing to the proxy server) need to be opened on your router and firewall.

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
#    ProxyPass "/socket" "ws://SERVER_IP_ADDRESS:8096/socket"
#    ProxyPassReverse "/socket" "ws://SERVER_IP_ADDRESS:8096/socket"
#
#    ProxyPass "/" "http://SERVER_IP_ADDRESS:8096/"
#    ProxyPassReverse "/" "http://SERVER_IP_ADDRESS:8096/"
#
#    SSLEngine on
#    SSLCertificateFile /etc/letsencrypt/live/DOMAIN_NAME/fullchain.pem
#    SSLCertificateKeyFile /etc/letsencrypt/live/DOMAIN_NAME/privkey.pem
#    Protocols h2 http/1.1
#
#    ErrorLog /var/log/apache2/DOMAIN_NAME-error.log
#    CustomLog /var/log/apache2/DOMAIN_NAME-access.log combined
#</VirtualHost>
#</IfModule>
```

If you encouter errors, you may have to enable `mod_proxy`, `mod_ssl` or `proxy_wstunnel` support manually.

```bash
$ sudo a2enmod proxy proxy_http ssl proxy_wstunnel
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

Create the file `/etc/nginx/conf.d/jellyfin.conf`.

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
#    # Security / XSS Mitigation Headers
#    add_header X-Frame-Options "SAMEORIGIN";
#    add_header X-XSS-Protection "1; mode=block";
#    add_header X-Content-Type-Options "nosniff";
#
#    # Content Security Policy
#    # See: https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP
#    # Enforces https content and restricts JS/CSS to origin
#    # External Javascript (such as cast_sender.js for Chromecast) must be whitelisted.
#    add_header Content-Security-Policy "default-src https: data: blob:; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline' https://www.gstatic.com/cv/js/sender/v1/cast_sender.js; worker-src 'self' blob:; connect-src 'self'; object-src 'none'; frame-ancestors 'self'";
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
#    location /socket {
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

        # Disable buffering when the nginx proxy gets very resource heavy upon streaming
        proxy_buffering off;
    }
}
```

## Caddy

Add this to your `Caddyfile`:

```
DOMAIN_NAME/jellyfin/ {
    proxy / localhost:8096 {
        transparent
        websocket
    }
}
```

Using DOMAIN_NAME only, or sub.DOMAIN_NAME would also work, as would using multiple at once.

Caddy will automatically attempt to obtain a free HTTPS certificate if possible, and handle renewal, making the below section unecessary.

If using a subpath, note that `DOMAIN_NAME/jellyfin` will not resolve, the ending slash is needed. To get around this, you can add the following to your `Caddyfile`. This is only helpful for the web client, just one less character to type in the browser.

```
DOMAIN_NAME {
    redir {
        /jellyfin /jellyfin/
    }
}
```

## Traefik (with docker-compose)

Traefik is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Traefik integrates with your existing infrastructure components (Docker, Swarm mode, Kubernetes, Marathon, Consul, Etcd, Rancher, Amazon ECS, ...) and configures itself automatically and dynamically. Pointing Traefik at your orchestrator should be the only configuration step you need. (https://traefik.io/). 

Create these 3 files in the SAME directory (or change their paths in the volume section) : docker-compose.yml, traefik.toml and acme.json.

This configuration is A+ (SSLlabs)

docker-compose.yml:

```
version: '3.5'

services:
  traefik:
    container_name: traefik
    image: traefik:v1.7
    networks:
      - traefik
    ports:
      - 80:80
      - 443:443
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./traefik.toml:/traefik.toml
      - ./acme.json:/acme.json
    labels:
      traefik.enable: "true"
      traefik.backend: traefik
      traefik.docker.network: traefik
      traefik.port: 8080
      traefik.frontend.rule: Host:traefik.example.com,
      traefik.frontend.entryPoints: https
      traefik.frontend.passHostHeader: "true"
      traefik.frontend.headers.SSLForceHost: "true"
      traefik.frontend.headers.SSLHost: traefik.example.com
      traefik.frontend.headers.SSLRedirect: "true"
      traefik.frontend.headers.browserXSSFilter: "true"
      traefik.frontend.headers.contentTypeNosniff: "true"
      traefik.frontend.headers.forceSTSHeader: "true"
      traefik.frontend.headers.STSSeconds: 315360000
      traefik.frontend.headers.STSIncludeSubdomains: "true"
      traefik.frontend.headers.STSPreload: "true"
      traefik.frontend.headers.customResponseHeaders: X-Robots-Tag:noindex,nofollow,nosnippet,noarchive,notranslate,noimageindex
      traefik.frontend.headers.frameDeny: "true"
      traefik.frontend.headers.customFrameOptionsValue: 'allow-from https://example.com'
    restart: unless-stopped

  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    network_mode: "host"
    volumes:
      - /path/to/config:/config
      - /path/to/cache:/cache
      - /path/to/media:/media
    restart: unless-stopped

networks:
  traefik:
    name: traefik
```

This toml file can't support environment variables, ensure you don't attempt to use variables.

traefik.toml:
 
```
logLevel = "WARN"
defaultEntryPoints = ["http", "https"]

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

[retry]

[api]

[acme]
acmeLogging = true
email = "user@example.com"
storage = "acme.json"
entryPoint = "https"
  [acme.dnsChallenge]
    provider = "provider"
    delayBeforeCheck = "60"

[[acme.domains]]
  main = "*.example.com"
  
[docker]
domain = "example.com"
network = "traefik"
exposedbydefault = false

[backends]
  [backends.backend-jellyfin]
    [backends.backend-jellyfin.servers]
      [backends.backend-jellyfin.servers.server-1]
        url = "http://172.17.0.1:8096"
[frontends]
  [frontends.jellyfin]
    backend = "backend-jellyfin"
    passHostHeader = true
    [frontends.jellyfin.routes]
      [frontends.jellyfin.routes.route-jellyfin-ext]
        rule = "Host:jellyfin.example.com"
    [frontends.jellyfin.headers]
      SSLRedirect = true
      SSLHost = "jellyfin.example.com"
      SSLForceHost = true
      STSSeconds = 315360000
      STSIncludeSubdomains = true
      STSPreload = true
      forceSTSHeader = true
      frameDeny = true
      contentTypeNosniff = true
      browserXSSFilter = true
      customResponseHeaders = "X-Robots-Tag:noindex,nofollow,nosnippet,noarchive,notranslate,noimageindex"
      customFrameOptionsValue = "allow-from https://example.com"
```

Finally, create an empty acme.json.

```bash
touch acme.json
chmod 600 acme.json
```

IMPORTANT ! Change example.com to your domain / subdomain name, and change the mail of the acme (user@example.com in traefik.toml). Let's Encrypt does not require a valid email address however example.com will be flagged as not being a proper email address.

Launch your Traefik/Jellyfin services : `docker-compose up -d`

Congratulations, your stack with Traefik and Jellyfin is running!

> [!NOTE]
> Due to a [bug](https://github.com/containous/traefik/issues/5559) in Traefik, you cannot dynamically route to containers when network_mode=host, so we have created a static route to the docker host (172.17.0.1:8096) in `traefik.toml`. Using host networking (or macvlan) is required to use DLNA or an HdHomeRun as it supports multicast networking.

Go to jellyfin.example.com (in this case), and your jellyfin is running with HTTPS (AES 256).

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

# Final steps

It's strongly recommend that you check your SSL strength and server security at [SSLLabs](https://www.ssllabs.com/ssltest/analyze.html) if you are exposing these service to the internet.
