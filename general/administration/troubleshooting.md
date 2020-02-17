---
uid: admin-troubleshoot
title: Troubleshooting
---

## Troubleshooting

If you can access the web interface over HTTP but not HTTPS, then you likely have an error with the certificate. Jellyfin uses a PFX file to handle HTTPS traffic. If you created the file with a password, then you will have to enter that value on the **Networking** page in the settings.

If you can access the server locally but not outside of your LAN, then you likely have an issue with the router configuration. Please see the [port forwarding](xref:admin-port-forwarding) for more information.

The easiest way to check for issues is by checking the logs, which can be accessed through the settings on the web frontend or in the log directory on your server. If there are no logs at all relating to web traffic, even over a LAN connection, then the server hasn't been reached at all yet. This would indicate either an incorrect address or an issue somewhere else on the network.

## Debug Logging

To enable debug (much more verbose) logging, it is currently required to manually edit config files - no UI options exist yet. Go to Jellyfin-directory/config, in the `logging.json` file, change the minimum level to debug as seen below.

`"MinimumLevel": "Debug"`

Jellyfin 10.4.1 and above will automatically reload the new configuration. The debug messages show up in the log with the `DBG` tag.
