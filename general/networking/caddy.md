---
uid: network-reverse-proxy-caddy
title: Caddy Reverse Proxy
---

## Caddy

"[Caddy](https://caddyserver.com/), sometimes clarified as the Caddy web server, is an open source, HTTP/2-enabled web server written in Go. It uses the Go standard library for its HTTP functionality." - [Wikipedia](https://en.wikipedia.org/wiki/Caddy_(web_server))

### Caddyfile

```
DOMAIN_NAME/jellyfin/ {
    proxy / localhost:8096 {
        transparent
        websocket
    }
}
```

DuckDNS Config

```
domain.duckdns.org {
 
    tls user@example.com
   
    timeouts none
 
    proxy / localhost:8096 {
        websocket
        transparent
    }
 
    # optional security headers
    header / {
        -Server
        Strict-Transport-Security "max-age=31536000;"
        Referrer-Policy "strict-origin"
        X-XSS-Protection "1; mode=block"
        X-Content-Type-Options "nosniff"
        X-Frame-Options "DENY"
    }
 
    # optional logging
    log JellyfinProxy.log
}
```

Using DOMAIN_NAME or sub.DOMAIN_NAME would also work, as would using multiple at once.

Caddy will automatically attempt to obtain a free HTTPS certificate and handle renewals, making the section below unnecessary.

If using a subpath, note that `DOMAIN_NAME/jellyfin` will not resolve, the ending slash is needed. To get around this, you can add the following to your `Caddyfile`. This is only helpful for the web client, just one less character to type in the browser.

```
DOMAIN_NAME {
    redir {
        /jellyfin /jellyfin/
    }
}
```

Community Links:

https://www.reddit.com/r/jellyfin/comments/ek8ugr/windows_reverse_proxy_guide/
