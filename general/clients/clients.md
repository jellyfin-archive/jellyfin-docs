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

**Status:** ⭐ Active

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-kodi)

#### Installing

1. Download the repository installer [here](https://repo.jellyfin.org/releases/client/kodi/repository.jellyfin.kodi.zip)
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
        * Note that if you have a baseurl set, you should append that value to the end of the host field.  ie: `192.168.0.10:8096/jellyfin`
        * Enter the server name or IP address and the port number (default is 8096)
            * Host: `192.168.1.10:8096`
        * If using SSL and a reverse proxy, enter the full URL scheme in the "Host" field
            * Host: `https://jellyfin.example.com`
    * Select user account and input password
5. Once you're succesfully authenticated with the Jellyfin server, you'll be asked about your preferences for this device
    * Choose your preferences for each options
      * Add-On mode requires no additional configuration
      * To get Native mode to work, a few things must be done before the files are accessible, so skipping the initial import is necessary, skip the below steps and continue with the **Native Mode Configuration** steps
    * Select "Proceed" to configure libraries
    * Select the libraries you would like to keep synced with this device
6. The first sync of the Jellyfin server to the local Kodi database may take some time depending on your device speed and library size
7. Once the full sync is done, you can browse and play your media through Kodi, and syncs will be done periodically in the background

##### Native Mode Configuration

The benefit of Native mode over Add-On mode is that nothing will be transcoded, currently Add-On mode doesn't support audio with more than 5.1 channels, which means no Dolby Atmos or DTS-X. Since no transcoding happens, files play instantly.

1. You need to delete and re-add your libraries on your Jellyfin server in order to set the **Optional Network Path** to your share locations if you haven't already done so previously, SMB/Samba is preferred, and **must be in the Windows format** using backslashes, *even if both the client and server are using Unix-like OSes*, for example **\\\192.168.1.7\movies**, wait for the import to finish on the server.
2. If using a Unix-like OS you must create a local user and Samba user named **guest** (with no password) on your server and allow guest only access to your shares, if using Windows this may already be done for you by default, the **guest** user is hardcoded into the plugin.
3. Add in your SMB/Samba shares into Kodi like you normally would when not using the Jellyfin plugin, setting the content type, but it is not necessary to import that data since this will be handled by the Jellyfin plugin.
4. Select your libraries to add in using the Jellyfin plugin's menu, proceed to import your library.
5. Your files should now be accessible in Kodi and function the same way as Add-On mode, if not, enable debug logging in the Jellyfin plugin in Kodi and if in a Unix-like OS, set the **log level** of Samba to 2 to see if there are issues authenticating.

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
