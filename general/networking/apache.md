---
uid: network-reverse-proxy-apache
title: Apache Reverse Proxy
---

## Apache HTTP Server Project

"The [Apache HTTP Server Project](https://httpd.apache.org/) is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows. The goal of this project is to provide a secure, efficient and extensible server that provides HTTP services in sync with the current HTTP standards." 

- Apache Home Page

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
#    Enable only strong encryption ciphers and prefer versions with Forward Secrecy
#    SSLCipherSuite HIGH:RC4-SHA:AES128-SHA:!aNULL:!MD5
#    SSLHonorCipherOrder on
#
#    Disable insecure SSL and TLS versions
#    SSLProtocol all -SSLv2 -SSLv3 -TLSv1 -TLSv1.1
#
#    ErrorLog /var/log/apache2/DOMAIN_NAME-error.log
#    CustomLog /var/log/apache2/DOMAIN_NAME-access.log combined
#</VirtualHost>
#</IfModule>
```

If you encouter errors, you may have to enable `mod_proxy`, `mod_ssl`, or `proxy_wstunnel` support manually.

```bash
$ sudo a2enmod proxy proxy_http ssl proxy_wstunnel
```
