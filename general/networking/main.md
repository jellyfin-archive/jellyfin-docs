---
uid: network-main
title: Networking
---

# Port Bindings

This document aims to provide an admin with knowledge on what ports Jellyfin binds and what purpose they serve.

## Static Ports

* 8096/tcp is used by default for HTTP traffic. This is admin configurable.
* 8920/tcp is used by default for HTTPS traffic. This is admin configurable.
* 1900/udp is used for service autodiscovery. This is _not_ admin configurable as it would break client autodiscover.

**HTTP Traffic:** 8096

The web frontend can be accessed here for debugging SSL certificate issues on your local network. You can modify this setting from the **Networking** page in the settings.

**HTTPS Traffic:** 8920

This setting can also be modified from the **Networking** page to use a different port.

**Service Discovery:** 1900

Since client auto-discover would break if this option were configurable, you cannot change this in the settings at this time.

**Client Discovery:** 7359 UDP

Allows clients to discover the Jellyfin Server on the local network.  A broadcast message to this port with `Who is JellyfinServer?` will get a json response that includes the server Address, ID and Name.

### Dynamic Ports

* Completely random UDP port bind. It picks any UDP port that is unused on startup. It is used for Live TV setups involving HDHomeRun devices.

# Running Jellyfin Behind a Reverse Proxy

It's possible to run Jellyfin behind another server acting as a reverse proxy.  With a reverse proxy setup, this server handles all network traffic and proxies it back to Jellyfin. This provides the benefits of using DNS names and not having to remember port numbers, as well as easier integration and management of SSL certificates.

Some popular options for reverse proxy systems are [Apache](https://httpd.apache.org/), [Haproxy](https://www.haproxy.com/), [Nginx](https://www.nginx.com/), [Caddy](https://caddyserver.com/) and [Traefik](https://traefik.io/).

> [!WARNING]
> In order for a reverse proxy to have the maximum benefit, you should have a publically routable IP address and a domain with DNS set up correctly.  These examples assume you want to run Jellyfin under a sub-domain (ie: jellyfin.example.com), but are easily adapted for the root domain if desired. 

When following this guide, be sure to replace the following variables with your information:

* `DOMAIN_NAME` - Your public domain name to access Jellyfin on (e.g. jellyfin.example.com)
* `example.com` - The domain name Jellyfin services will run under (e.g. example.com)
* `SERVER_IP_ADDRESS` - The IP address of your Jellyfin server (if the reverse proxy is on the same server use 127.0.0.1)

In addition, the examples are configured for use with LetsEncrypt certificates.  If you have a certificate from another source, change the ssl configuration from `/etc/letsencrypt/DOMAIN_NAME/` to the location of your certificate and key.

Ports 80 and 443 (pointing to the proxy server) need to be opened on your router and firewall.

## Subdomains vs Paths

Running Jellyfin in a Path (example.com/jellyfin/) is supported by the Android and web clients. Sonarr and Radarr currently do not support Paths and their APIs will fail to communicate with Jellyfin. DLNA and Chromecasting are known to break when using Paths.

## Final steps

It's strongly recommend that you check your SSL strength and server security at [SSLLabs](https://www.ssllabs.com/ssltest/analyze.html) if you are exposing these service to the internet.
