---
uid: network-letsencrypt
title: Let's Encrypt
---

## LetsEncrypt with Certbot

LetsEncrypt is a service that provides free SSL/TLS certificates to users. Certbot is a client that makes this easy to accomplish and automate. In addition, it has plugins for Apache and Nginx that make automating certificate generation even easier.

Installation instructions for most Linux distributions can be found on the [Certbot](https://certbot.eff.org/docs/install.html#operating-system-packages) website.

Once the packages are installed, you're ready to generate a new certificate.

### Apache

#### Certbot Apache Plugin

After installing Certbot and the Apache plugin, certificate generation is accomplished by with the following command.

```sh
certbot certonly --apache --noninteractive --agree-tos --email YOUR_EMAIL -d DOMAIN_NAME
```

Update the 'SSLCertificateFile' and 'SSLCertificateKeyFile' sections, then restart the service.

Add a job to cron so the certificate will be renewed automatically.

```sh
echo "0 0 * * *  root  certbot renew --quiet --no-self-upgrade --post-hook 'systemctl reload apache2'" | sudo tee -a /etc/cron.d/renew_certbot
```

#### Certbot Webroot

##### Debian

If the certbot apache plugin doesn't work with your config, use webroot instead.

Add the following to your <VirtualHost> section after configuring it a reverse proxy:

```conf
DocumentRoot /var/www/html/
#Do not pass the .well-known directory when using certbot and webroot
ProxyPass /.well-known !
```

Run the certbot command as root:

```sh
sudo certbot certonly --webroot -w /var/www/html --agree-tos --email YOUR_EMAIL -d DOMAIN_NAME
```

### HAProxy

HAProxy doesn't currently have a Certbot plugin. To get around this, run Certbot in standalone mode and proxy traffic through your network.

Enable the frontend and backend in the config above, and then run Certbot.

```sh
certbot certonly --standalone --preferred-challenges http-01 --http-01-port 8888 --noninteractive --agree-tos --email YOUR_EMAIL -d DOMAIN_NAME
```

The port can be changed to anything you like, but be sure that the HAProxy config and your Certbot command match.

HAProxy needs to have the certificate and key files concatenated into the same file to read it correctly. This can be accomplished with the following command.

```sh
cat /etc/letsencrypt/live/DOMAIN_NAME/fullchain.pem /etc/letsencrypt/live/DOMAIN_NAME/privkey.pem > /etc/ssl/DOMAIN_NAME.pem
```

Uncomment `bind *:443` and the redirect section in the configuration, then reload the service.

#### Automatic Certificate Renewal

Place the following script in `/usr/local/bin/` to automatically update your SSL certificate.

```sh
SITE=DOMAIN_NAME

# move to the correct let's encrypt directory
cd /etc/letsencrypt/live/$SITE

# cat files to make combined .pem for haproxy
cat fullchain.pem privkey.pem > /etc/ssl/$SITE.pem

# reload haproxy
service haproxy reload
```

Make sure the script is executable.

```sh
chmod u+x /usr/local/bin/letsencrypt-renew.sh
```

Add a job to cron so the certificate will be renewed automatically.

```data
@monthly /usr/bin/certbot renew --renew-hook "/usr/local/bin/letsencrypt-renew.sh" >> /var/log/letsencrypt-renewal.log
```

### Nginx

After installing Certbot and the Nginx plugin with `sudo apt install certbot python3-certbot-nginx`, generate the certificate.

```sh
sudo certbot --nginx --agree-tos --redirect --hsts --staple-ocsp --email YOUR_EMAIL -d YOUR_DOMAIN
```

Add the `--rsa-key-size 4096` parameter if you want a 4096 bit key instead.

Copy and paste the whole Nginx sample configuration file from above, changing the parameters according to your setup and uncommenting the lines.

Add a job to cron so the certificate will be renewed automatically.

```sh
echo "0 0 * * *  root  certbot renew --quiet --no-self-upgrade --post-hook 'systemctl reload nginx'" | sudo tee -a /etc/cron.d/renew_certbot
```
