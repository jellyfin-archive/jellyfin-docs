# Server port bindings

This document aims to provide an admin with knowledge on what ports Jellyfin binds and what purpose they serve.

### Static ports

* 8096/tcp is used by default for HTTP traffic. This is admin configurable.
* 8920/tcp is used by default for HTTPS traffic. This is admin configurable.
* 1900/udp is used for service autodiscovery. This is _not_ admin configurable as it would break client autodiscover.

### Dynamic ports

* Completely random UDP port bind. It picks any UDP port that is unused on startup. It is used for specific LiveTV setups involving HD Homerun devices.
