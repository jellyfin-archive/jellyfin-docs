---
uid: clients-index
title: Clients
---

# Clients

Clients connect your devices to your Jellyfin server and let you view your content on any supported device. You can find a list of clients below with their current development status.

**Note**: Many clients were direct forks of the latest available codebases from Emby, and some are not functional yet. If you interested in helping out, please see our [contribution guide](xref:contrib-index).

Do you have a client that interfaces with Jellyfin and want to see it listed here? Please [submit a PR](https://github.com/jellyfin/jellyfin-docs)!

## Android

### Jellyfin for Android

The official Jellyfin Android app supporting Android 5+.

**Status:** ⭐ In Beta release

**Links:**

<a href='https://play.google.com/store/apps/details?id=org.jellyfin.mobile&utm_source=docs&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' width="200"/></a>

* [GitHub](https://github.com/jellyfin/jellyfin-android)
* [Binary repository](https://jellyfin.org/downloads/clients/#android)

### Jellyfin for Android TV

The official Jellyfin Android TV app.

**Status:** ⭐ In Beta release

**Links:**

<a href='https://play.google.com/store/apps/details?id=org.jellyfin.androidtv'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' width="200"/></a>

* [GitHub](https://github.com/jellyfin/jellyfin-androidtv)
* [Binary repository](https://jellyfin.org/downloads/clients/#androidtv)

### Jellyfin for Amazon Fire TV

The official Jellyfin Fire TV app.

**Status:** ⭐ In Beta release

**Links:**

<a href='https://www.amazon.com/gp/aw/d/B07TX7Z725'><img alt='Get it on the Amazon Appstore' src='https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/devportal2/res/images/amazon-appstore-badge-english-black.png' width="200"/></a>

* [GitHub](https://github.com/jellyfin/jellyfin-androidtv)
* [Binary repository](https://jellyfin.org/downloads/clients/#androidtv)

### Yatse

A third party remote control for Jellyfin with support for Chromecast playback.

**Status:** ⭐ Active, 3rd-party

**Links:**

* [Yatse homepage](https://yatse.tv/)

## Jellyfin Theater (Desktop)

### Electron

A cross-platform desktop media interface using Electron supporting Windows, MacOS and Linux.

**Status:** ✅ In development

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-theater-electron)

### Raspberry Pi

A desktop media interface for the Raspberry Pi.

**Status:** ⭕ No Maintainers - [volunteer](xref:contrib-index)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-theater-pi)

### Windows

A desktop media interface for Windows.

**Status:** ⭕ No Maintainers - [volunteer](xref:contrib-index)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-theater-windows)

## Web

### Web Scrobbler

Extension for browsers based on Chromium and Firefox that allows scrobble services like libre.fm and last.fm.

**Status:** ⭐ Active, 3rd-party

**Links:**

* [Web](https://web-scrobbler.github.io/)
* [GitHub](https://github.com/web-scrobbler/web-scrobbler)

### Jellyfin for Google Chrome

The official Jellyfin Google Chrome extension.

**Status:** ⭕ No Maintainers - [volunteer](xref:contrib-index)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-chrome)

## Apple

### Jellyfin for Apple iOS

The official Jellyfin iOS app.

**Status:** ✅ In development

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-expo)

## Kodi

### Jellyfin for Kodi

The official Jellyfin Kodi plugin.

**Status:** ⭐ Receiving patches

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-kodi)

#### Installing

1. Download the repository installer [here](https://jellyfin.org/downloads/clients/#kodi-repository)
    * It will be saved as `repository.jellyfin.kodi.zip`
2. Install the Jellyfin repository
    * Open Kodi and navigate to "Add-on Browser"
    * Select "Install from zip file"
        * If prompted, enter settings and enable "Unknown Sources", then go back
    * Select the newly downloaded file and it will be installed
3. Install Jellyfin for Kodi
    * From within Kodi, navigate back to "Add-on Browser"
    * Select "Install from repository"
    * Choose "Kodi Jellyfin Addons"
    * "Video Add-ons"
    * Select the Jellyfin add-on and choose install
4. Within a few seconds you should be prompted for your server-details.
    * If a Jellyfin server is detected on your local network, it will displayed in the popup
    * If a Jellyfin server is not detected on your local network, select "Manually add server"
        * Enter the server name or IP address and the port number (default is 8096)
        * If using SSL and a reverse proxy, enter the full URL scheme in the "Host" field
            * Host: https://jellyfin.example.com
            * Port: 443
    * Select user account and input password
5. Once you're succesfully authenticated with the Jellyfin server, you'll be asked about your preferences for this device
    * Choose your preferences for each option
    * Select "Proceed" to configure libraries
    * Select the libraries you would like to keep synced with this device
6. The first sync of the Jellyfin server to the local Kodi database may take some time depending on your device speed and library size
7. Once the full sync is done, you can browse and play your media through Kodi, and syncs will be done periodically in the background

**Note: It's recommended to install the `Kodi Sync Queue` plugin into the Jellyfin server as well**

This will help keep your media libraries up to date without waiting for a periodic resync from Kodi.

**Note: Kodi's default skin does not display all unicode characters. To display unicode characters the skins font must be changed**

## Mopidy

### Mopidy-Jellyfin

A third party plugin for Mopidy that uses Jellyfin as a backend.

**Status:** ⭐ Active, 3rd-party

**Links:**

* [GitHub](https://github.com/mcarlton00/mopidy-jellyfin)

## Roku

### Jellyfin for Roku

The official Jellyfin Roku app.

**Status:** ❎ Deprecated but salvageable - [major updates required](xref:contrib-index)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-roku)

## Samsung TV

### Jellyfin for Samsung TV

The official Jellyfin Samsung TV app.

**Status:** ⭕ No Maintainers - [volunteer](xref:contrib-index)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-samsungtv)

## Windows Phone

### Jellyfin for Windows Phone

The official Jellyfin Windows Phone app.

**Status:** ❎ Deprecated - [dead platform but salvageable](xref:contrib-index)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-windowsphone)
