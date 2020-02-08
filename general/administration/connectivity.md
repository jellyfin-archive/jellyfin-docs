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

## Debug Logging

To enable debug (much more verbose) logging, it is currently required to manually edit config files - no UI options exist yet. Go to Jellyfin-directory/config, in the `logging.json` file, change the minimum level to debug as seen below.

`"MinimumLevel": "Debug"`

Jellyfin 10.4.1 and above will automatically reload the new configuration. The debug messages show up in the log with the `DBG` tag.

## DLNA

DLNA is based on uPnP. DLNA will send a broadcast signal from Jellyfin. This broadcast is limited to Jellyfin's current subnet. If using Docker, the network should use Host Mode, otherwise the broadcast signal will only be sent in the bridged network inside of docker. 

If DLNA fails to bind properly, `[ERR] Failed to bind to port 1900: "Address already in use". DLNA will be unavailable` should appear in the logs.

Setting `Alive message interval (seconds)` to 30 seconds also appears to help discovery for some clients.

If a base URL is set, try removing the base Url and restarting the Jellyfin service. 
