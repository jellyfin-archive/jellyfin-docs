---
uid: network-reverse-proxy-nginx
title: Nginx Reverse Proxy
---

## Nginx

"[Nginx](https://www.nginx.com/) (pronounced "engine X") is a web server which can also be used as a reverse proxy, load balancer, mail proxy and HTTP cache. The software was created by Igor Sysoev and first publicly released in 2004.[9] A company of the same name was founded in 2011 to provide support and Nginx plus paid software." - [Wikipedia](https://en.wikipedia.org/wiki/Nginx)

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
#        proxy_pass http://SERVER_IP_ADDRESS:8096/;
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
#        proxy_pass http://SERVER_IP_ADDRESS:8096/socket;
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

When connecting to server from a client application, enter ``http(s)://DOMAIN_NAME/jellyfin`` in the address field.

Set the base URL field in the Jellyfin server.  This can be done by navigating to the Admin Dashboard -> Networking -> Base URL in the Jellyfin Web UI.  Fill in this box with `/jellyfin` and click Save.  The server will need to be restarted before this change takes effect.

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
        # https://www.acunetix.com/blog/articles/a-fresh-look-on-reverse-proxy-related-attacks/

        proxy_pass http://SERVER_IP_ADDRESS:8096/jellyfin/;

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
