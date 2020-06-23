---
uid: network-reverse-proxy-traefik2
title: Traefik2
---

## Traefik v2.x

[Traefik](https://traefik.io/) is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Traefik integrates with your existing infrastructure components (ie: Docker) and generally configures itself dynamically as services are added or removed.

This document provides a complete configuration of Traefik v2.x and Jellyfin. It uses a number of files including a `docker-compose.yml` file, `traefik.toml` (your Traefik static configuration), `traefik-provider.toml` (a file-based provider for Traefik), `traefik.log` (an optional log file), `.env` (the environment which may be needed for your ACME/LetsEncrypt providers), and `acme.json` (the state data for your ACME/LetsEncrypt certificate). The files should all be created in the **same** directory. Alternately, alter the paths in the volume section of the `traefik` service in `docker-compose.yml`. You can optionally jam some of the traefik.toml file into labels for the traefik service in `docker-compose.yml`, however this is much clearer and easier to comment.

> [!NOTE]
> Ensure you enable some basic firewall or auth protection for Traefik or disable its dashboard. If you do not, your dashboard may be accessible from the internet. Pay attention to accessibility via IPv6, as even systems on an internal home network may be directly accessible over IPv6.  See [api-insecure](https://docs.traefik.io/operations/api/#insecure) for more details on securing the dashboard.

> [!NOTE]
> Traefik has many options for the configuration of LetsEncrypt using your choice of challenges. If your server is accessible via port 80 or 443, you can use the HTTP-01 or the TLS-ALPN-01 challenges. If so, the certificatesresolvers.leresolver.acme.httpchallenge.entrypoint must be reachable by Let's Encrypt through port 80/443. You can also use a DNS-01 challenge via one of the available [providers](https://docs.traefik.io/https/acme/#providers). Configuration is beyond the scope of this guide. This guide can be used for both HTTP-01 and DNS-01 by commenting or uncommenting the various blocks. You are most likely to use HTTP-01 unless you have full acess to your DNS configuration. The configuration below uses RFC2136 (as set by certificatesresolvers.leresolver.acme.dnsChallenge of `traefik.toml`) and the variables for that provider are shown in the `.env` file as a formatting guide. See notes about configuration of your ACME provider of choice, or change the configuration to HTTP-01 in `traefik.toml`'s comments.

The configuration below creates a Traefik v2.x installation with access at entryPoint ports 80 (labelled 'http'), 443 (labeled 'https'), and 9999 (labeled 'secure'). It makes Jellyfin accessible at /jellyfin on the secure entry point.  It also redirects all traffic from http (port 80) to https (port 443) to ensure all data is encrypted. This configuration is intended to be used as a starting point and some adaptation is likely required for your specific configuration. If you want Jellyfin to be accessible on port 443, simply change 'secure' to 'https' in `docker-compose.yml` where indicated. If you want Jellyfin to be accessible without a path, simply change '/jellyfin' to '/'. You can also restrict the configuration by hostname by using the commented line in `docker-compose.yml`.

### docker-compose.yml
```yml
version: '2.4'
services:
  traefik:
    container_name: traefik
    image: traefik:chevrotin # the chevrotin tag refers to v2.2.x
    restart: unless-stopped
    volumes:
      # So that Traefik can listen to the Docker events (read-only)
      - /var/run/docker.sock:/var/run/docker.sock:ro
      # TOML Configuration with global options
      - /srv/traefik.toml:/traefik.toml
      # Configuration for the file provider (needed for host networking)
      - /srv/traefik-provider.toml:/traefik-provider.toml
      # LetsEncrypt ACME Configuration
      - /srv/acme.json:/acme.json
      # Log File (optional)
      - /srv/traefik.log:/traefik.log
    ports:
     # The Web UI (enabled by --api.insecure=true in traefik.toml)
      - 8080:8080
     # The Available Ports (forward your router's incoming ports to the ports on the host)
      - 80:80
      - 443:443
      - 9999:9999
    env_file: .env
    
  jellyfin:
    image: jellyfin/jellyfin
    container_name: "jellyfin"
    user: 1000:1000
    group_add: # by id as these may not exist within the container. Needed to provide permissions to the VAAPI Devices
      - "107" #render
      - "44"  #video
    # Network mode of 'host' exposes the ports on the host. This is needed for DLNA access.
    network_mode: "host"
    volumes:
      - /path/to/config:/config
      - /path/to/cache:/cache
      # Update this configuration as desired
      - /path/to/media:/media
    restart: always
    devices:
      # VAAPI Devices
      - /dev/dri/renderD128:/dev/dri/renderD128
      - /dev/dri/card0:/dev/dri/card0
    labels:
      - "traefik.enable=true"
      ## HTTP Routers
      #### Change secure to https in the line below to have accessible without needing to specify a port
      - "traefik.http.routers.jellyfin.entryPoints=secure"
      #### Remove (or change) this rule if you'd rather have Jellyfin accessible at the root (or at another URI)
      - "traefik.http.routers.jellyfin.rule=PathPrefix(`/jellyfin`)"
      #- "traefik.http.routers.whoami.rule=Host(`DOMAIN_NAME`) && PathPrefix(`/jellyfin`)"
      - "traefik.http.routers.jellyfin.tls=true"
      - "traefik.http.routers.jellyfin.tls.certResolver=leresolver"
      ## Middlewares
      - "traefik.http.routers.jellyfin.middlewares=jellyfin-mw"
      #### The customResponseHeaders option lists the Header names and values to apply to the response.
      - "traefik.http.middlewares.jellyfin-mw.headers.customResponseHeaders.X-Robots-Tag=noindex,nofollow,nosnippet,noarchive,notranslate,noimageindex"
      #### The sslRedirect is set to true, then only allow https requests.
      - "traefik.http.middlewares.jellyfin-mw.headers.SSLRedirect=true"
      #### The sslHost option is the host name that is used to redirect http requests to https.
      - "traefik.http.middlewares.jellyfin-mw.headers.SSLHost=DOMAIN_NAME"
      #### Set sslForceHost to true and set SSLHost to forced requests to use SSLHost even the ones that are already using SSL.
      - "traefik.http.middlewares.jellyfin-mw.headers.SSLForceHost=true"
      #### The stsSeconds is the max-age of the Strict-Transport-Security header. If set to 0, would NOT include the header.
      - "traefik.http.middlewares.jellyfin-mw.headers.STSSeconds=315360000"
      #### The stsIncludeSubdomains is set to true, the includeSubDomains directive will be
      #### appended to the Strict-Transport-Security header.
      - "traefik.http.middlewares.jellyfin-mw.headers.STSIncludeSubdomains=true"
      #### Set stsPreload to true to have the preload flag appended to the Strict-Transport-Security header.
      - "traefik.http.middlewares.jellyfin-mw.headers.STSPreload=true"
      #### Set forceSTSHeader to true, to add the STS header even when the connection is HTTP.
      - "traefik.http.middlewares.jellyfin-mw.headers.forceSTSHeader=true"
      #### Set frameDeny to true to add the X-Frame-Options header with the value of DENY.
      - "traefik.http.middlewares.jellyfin-mw.headers.frameDeny=true"
      #### Set contentTypeNosniff to true to add the X-Content-Type-Options header with the value nosniff.
      - "traefik.http.middlewares.jellyfin-mw.headers.contentTypeNosniff=true"
      #### Set browserXssFilter to true to add the X-XSS-Protection header with the value 1; mode=block.
      - "traefik.http.middlewares.jellyfin-mw.headers.browserXSSFilter=true"
      #### The customFrameOptionsValue allows the X-Frame-Options header value to be set with a custom value. This
      #### overrides the FrameDeny option.
      - "traefik.http.middlewares.jellyfin-mw.headers.customFrameOptionsValue='allow-from https://DOMAIN_NAME'"
      ## HTTP Services
      # We define the port here as it is required, but note that the service is pointing to the service defined in @file
      - "traefik.http.routers.jellyfin.service=jellyfin-svc@file"
      - "traefik.http.services.jellyfin-svc.loadBalancer.server.port=8096"
      - "traefik.http.services.jellyfin-svc.loadBalancer.passHostHeader=true"
```
> [!WARNING]
> TOML files can't support environment variables, so all values must be hard coded.

### traefik.toml
```toml
[log]
  # By default, the level is set to ERROR. Alternative logging levels
  # are DEBUG, PANIC, FATAL, ERROR, WARN, and INFO.
  level = "DEBUG"
  filePath = "/traefik.log"

[docker]
  # Defines a default docker network to use for connections to all
  # containers.  This option can be overridden on a container basis
  # with the traefik.docker.network label.
  network = "traefik"

  # Expose containers by default through Traefik. If set to false,
  # containers that don't have a traefik.enable=true label will be
  # ignored from the resulting routing configuration.
  exposedbydefault = false

[api]
  # Enable the API in insecure mode, which means that the API will be
  # available directly on the entryPoint named traefik. If the entryPoint
  # named traefik is not configured, it will be automatically created on
  # port 8080.
  insecure = true

[providers]
  # Connection to docker host system (docker.sock)
  # Attach labels to your containers and let Traefik do the rest!
  # Traefik works with both Docker (standalone) Engine and Docker Swarm Mode.
  # See: https://docs.traefik.io/providers/docker/
  [providers.docker]
    # Traefik requires access to the docker socket to get its dynamic
    # configuration.
    endpoint = "unix:///var/run/docker.sock"
  [providers.file]
    filename = "/traefik-provider.toml"


# EntryPoints are the network entry points into Traefik. They define
# the port which will receive the packets, and whether to listen for
# TCP or UDP.
# See: https://docs.traefik.io/routing/entrypoints/
[entryPoints]
  # Standard HTTP redirects to HTTPS
  [entryPoints.http]
    address = ":80"
    [entryPoints.http.http]
      [entryPoints.http.http.redirections]
        [entryPoints.http.http.redirections.entrypoint]
          to = "https"
          scheme = "https"
  # Standard HTTPS
  [entryPoints.https]
    address = ":443"
    [entryPoints.https.http.tls]
      certResolver = "leresolver"
      [[entryPoints.https.http.tls.domains]]
        main = "DOMAIN_NAME"
        # SANS are any other hostnames which Traefik should obtain a certificate for.
        # If you are using DNS for LetsEncrypt, you can set a wildcard.
        # Include all possible hostnames of this server.
        #sans = ["*.DOMAIN_NAME"]
  # Alternate HTTPS Port (for services)
  [entryPoints.secure]
    address = ":9999"
    [entryPoints.secure.http.tls]
      certResolver = "leresolver"
      [[entryPoints.secure.http.tls.domains]]
        main = "DOMAIN_NAME"
        # SANS are any other hostnames which Traefik should obtain a certificate for.
        # If you are using DNS for LetsEncrypt, you can set a wildcard.
        # Include all possible hostnames of this server.
        #sans = ["*.DOMAIN_NAME"]

# Enable ACME (Let's Encrypt): automatic SSL.
[certificatesresolvers.leresolver.acme]
  email = "YOU@DOMAIN_NAME"
  storage = "acme.json"
  # Use HTTP-01 ACME challenge
  #[certificatresolvers.leresolver.acme.httpChallenge]
  #  entryPoint = "http"
  # Use a DNS-01 ACME challenge rather than HTTP-01 challenge.
  # Mandatory for wildcard certificate generation.
  [certificatesresolvers.leresolver.acme.dnsChallenge]
    # Update this to your provider of choice and then ensure necessary variables are in the .env file to support it.
    provider = "rfc2136"
    delayBeforeCheck = 0
    # A DNS server used to check whether the DNS is set up correctly before
    # making the ACME request. Ideally a DNS server that isn't going to cache an old entry.
    resolvers = ["8.8.8.8:53"]

[tls.options]
  [tls.options.default]
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
```

Due to a [bug](https://github.com/containous/traefik/issues/5559) in Traefik, you cannot dynamically route to containers when network_mode=host. We have created a static route to the docker host (192.168.1.xx:8096) in `traefik-provider.toml`. The use of host networking (as in this doc) or macvlan are required to use DLNA or an HdHomeRun so it can utilize the multicast network. `traefik-provider.toml` defines the jellyfin-svc@file service which we are pointing the router to in the `docker-compose.yml` file. You can not set a URL in `docker-compose.yml` which is why we set up this service externally. Be sure to update the IP address below to the IP address of the host on the local network (in this case, 192.168.1.xx).

### traefik-provider.toml
```toml
[http]
  [http.services]
    [http.services.jellyfin-svc]
      [[http.services.jellyfin-svc.loadBalancer.servers]]
        url = "http://192.168.1.xx:8096"
```

### .env
```
RFC2136_NAMESERVER=...
RFC2136_TSIG_ALGORITHM=hmac-sha512.
RFC2136_TSIG_KEY=...
RFC2136_TSIG_SECRET=...
```

Finally, create an empty acme.json and traefik.log file to handle the certificate and log file for any logging

```bash
touch acme.json traefik.log
chmod 600 acme.json traefik.log
```

> [!WARNING]
> Change DOMAIN_NAME to your domain name (ie: example.com) and update `traefik.toml`'s YOU@DOMAIN_NAME with your email address. Let's Encrypt does not require a valid email but invalid e-mails may be flagged as fake.

Launch the Traefik and Jellyfin services.

```bash
docker-compose up -d
```

After starting the service, access Jellyfin directly (via the host's IP at port 8096) and change the 'Base URL' in Dashboard / Advanced / Networking to match the '/jellyfin' path (if you used one in this configuration). Afterward, you may wish to create a firewall rule to prevent direct access to Jellyfin at port 8096 on the host, or simply ensure the port is not accessible via the Internet.

Congratulations, your stack with Traefik 2.x and Jellyfin is (hopefully) running!  Check the log file or run without the '-d' parameter to review any errors that may come up, particularly with respect to the LetsEncrypt configuration.
