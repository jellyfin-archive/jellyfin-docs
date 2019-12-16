---
uid: admin-connectivity
title: Connectivity
---


# Connectivity

## Connect

Many clients will automatically discover servers running on the same LAN and display them on login. If you are outside the network when you connect you can type in the complete IP address or domain name in the server field with the correct port to continue to the login page. You can find the default ports below to access the web frontend.

## Troubleshooting

If you can access the web interface over HTTP but not HTTPS, then you likely have an error with the certificate. Jellyfin uses a PFX file to handle HTTPS traffic. If you created the file with a password, then you will have to enter that value on the **Networking** page in the settings.

If you can access the server locally but not outside of your LAN, then you likely have an issue with the router configuration. Please see the [port forwarding](xref:admin-port-forwarding) for more information.

The easiest way to check for issues is by checking the logs, which can be accessed through the settings on the web frontend or in the log directory on your server. If there are no logs at all relating to web traffic, even over a LAN connection, then the server hasn't been reached at all yet. This would indicate either an incorrect address or an issue somewhere else on the network.

## Debug (more verbose) Logging

To enable debug (much more verbose) logging for Jellyfin, it is currently required to manually edit config files - no UI options exist yet. Go to Jellyfin-directory/config, in the `logging.json` file, change:

`"MinimumLevel": "Information",`

to

`"MinimumLevel": "Debug",`

Jellyfin 10.4.1 and above will auto-reload the new configuration. The debug messages show up in the log with the tag DBG.

## DLNA

DLNA is based on uPnP. DLNA will send a broadcast signal from Jellyfin. This broadcast is limited to Jellyfin's current subnet. If using Docker, the network should use Host Mode, otherwise the broadcast signal will only be sent in the bridged network inside of docker. 

If DLNA fails to bind properly, `[ERR] Failed to bind to port 1900: "Address already in use". DLNA will be unavailable` should appear in the logs.

Setting `Alive message interval (seconds)` to 30 seconds also appears to help discovery for some clients.

## Static Ports

**HTTP Traffic:** 8096

The web frontend can be accessed here for debugging SSL certificate issues on your local network. You can modify this setting from the **Networking** page in the settings.

**HTTPS Traffic:** 8920

This setting can also be modified from the **Networking** page to use a different port.

**Service Discovery:** 1900

Since client auto-discover would break if this option were configurable, you cannot change this in the settings at this time.

## Dynamic Ports

Live TV devices will often use a random UDP port for HD Homerun devices. The server will select an unused port on startup to connect to these tuner devices.

## Base URL

The Base URL setting in the **Networking** page is an advanced setting used to specify the URL prefix that your Jellyfin instance can be accessed at. In effect, it adds this URL fragment to the start of any URL path. For instance, if you have a Jellyfin server at `http://myserver` and access its main page `http://myserver/web/index.html`, setting a Base URL of `/jellyfin` will alter this main page to `http://myserver/jellyfin/web/index.html`. This can be useful if administrators want to access multiple Jellyfin instances under a single domain name, or if the Jellyfin instance lives only at a subpath to another domain with other services listening on `/`.

The entered value on the configuration page will be normalized to include a leading`/` if this is missing.

This setting requires a server restart to change, in order to avoid invalidating existing paths until the administrator is ready to.

There are three main caveats to this setting:

1. When setting a new Base URL (i.e. from `/` to `/baseurl`) or changing a Base URL (i.e. from `/baseurl` to `/newbaseurl`), the Jellyfin web server will automatically handle redirects to avoid displaying users invalid pages. For instance, accessing a server with a Base URL of `/jellyfin` on the `/` path will automatically append the `/jellyfin` Base URL. However, entirely removing a Base URL (i.e. from `/baseurl` to `/`, an empty value in the configuration) will not - all URLs with the old Base URL path will become invalid and throw 404 errors. This should be kept in mind when removing an existing Base URL.

2. Client applications generally, for now, do not handle the Base URL redirects implicitly. Therefore, for instance in the Android app, the `Host` setting *must* include the BaseURL as well (e.g. `http://myserver:8096/baseurl`), or the connection will fail.

3. Any reverse proxy configurations must be updated to handle a new Base URL. Generally, passing `/` back to the Jellyfin instance will work fine in all cases and the paths will be normalized, and this is the standard configuration in our examples. Keep this in mind however when doing more advanced routing.
