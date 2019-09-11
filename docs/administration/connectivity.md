# Connectivity

### Connect

Many clients will automatically discover servers running on the same LAN and display them on login. If you are outside the network when you connect you can type in the complete IP address or domain name in the server field with the correct port to continue to the login page. You can find the default ports below to access the web frontend.

### Troubleshooting

If you can access the web interface over HTTP but not HTTPS, then you likely have an error with the certificate. Jellyfin uses a PFX file to handle HTTPS traffic. If you created the file with a password, then you will have to enter that value on the **Networking** page in the settings.

If you can access the server locally but not outside of your LAN, then you likely have an issue with the router configuration. Please see the [port forwarding](/docs/administration/port-forwarding.md) for more information.

The easiest way to check for issues is by checking the logs, which can be accessed through the settings on the web frontend or in the log directory on your server. If there are no logs at all relating to web traffic, even over a LAN connection, then the server hasn't been reached at all yet. This would indicate either an incorrect address or an issue somewhere else on the network.

### Static Ports

**HTTP Traffic:** 8096

The web frontend can be accessed here for debugging SSL certificate issues on your local network. You can modify this setting from the **Networking** page in the settings.

**HTTPS Traffic:** 8920

This setting can also be modified from the **Networking** page to use a different port.

**Service Discovery:** 1900

Since client auto-discover would break if this option were configurable, you cannot change this in the settings at this time.

### Dynamic Ports

Live TV devices will often use a random UDP port for HD Homerun devices. The server will select an unused port on startup to connect to these tuner devices.
