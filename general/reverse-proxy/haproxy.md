---
uid: network-reverse-proxy-haproxy
title: HAProxy Reverse Proxy
---

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
