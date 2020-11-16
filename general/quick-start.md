---
uid: quick-start
title: Quick Start
---

# Quick Start

1. Install Jellyfin on [your system](xref:admin-installing) with the installation method for your platform.

1. [OPTIONAL from 10.7.0 onwards] Edit the Jellyfin web configuration (`/usr/share/jellyfin/web/config.json` on Debuntu, or `/jellyfin/jellyfin-web/config.json` in Docker) and adjust the options to fit your desired privacy level; our defaults sacrifice some absolute self-hosting for well-requested features.

    * If you wish to disable Chromecast support and callouts to Google, remove the line `"plugins/chromecastPlayer/plugin",` from the `plugins` section.
    * If you wish to disable YouTube Trailer support and callouts to YouTube, remove the line `"plugins/youtubePlayer/plugin",` from the `plugins` section.
    * If you wish to disable our custom `jellyfin-noto` font and callouts to our repository server, and fall back to system-local fonts only, remove the `.css` file lines under the `fonts` section.

1. Browse to `http://127.0.0.1:8096` to access the included web client.

1. Follow the initial setup wizard.

    * Libraries and users can always be added later from the dashboard.
    * Remember the username and password so you can login after the setup.

1. Secure the server with a method of your choice.

    * Create an SSL certificate and add it on the **Networking** page.
    * Put your server behind a [reverse proxy](networking/index.md#running-jellyfin-behind-a-reverse-proxy).
    * Only allow local connections and refrain from forwarding any ports.

1. Enjoy your media!
