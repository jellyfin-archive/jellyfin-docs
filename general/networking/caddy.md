---
uid: network-reverse-proxy-caddy
title: Caddy Reverse Proxy
---

## Caddy

"[Caddy 2](https://caddyserver.com/) is a powerful, enterprise-ready, open source web server with automatic HTTPS written in Go" - Caddy Home Page

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
