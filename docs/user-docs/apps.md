# Jellyfin Apps

Apps connect your devices to your Jellyfin server and let you view your content on any supported device. You can find a list of apps, as well as their status, below.

**Note**: Many apps were direct forks of the latest available codebases of Emby apps, and some are not functional yet or are deprecated. If you interested in helping out, please see our [contribution guide](/contributor-docs/contributing).

Do you have an app that interfaces with Jellyfin and would like to see it listed here? Please [submit a PR](https://github.com/jellyfin/jellyfin-docs)!

## Android

### Jellyfin for Android

The official Jellyfin Android app supporting Android 4+.

**Status:** ⭐ In Beta release

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-android)
* [Binary repository](https://repo.jellyfin.org/releases/client/android)

### Jellyfin for Android TV

The official Jellyfin Android TV app.

**Status:** ⭐ In Beta release

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-androidtv)
* [Binary repository](https://repo.jellyfin.org/releases/client/androidtv)

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

**Status:** ⭕ No Maintainers - [volunteer](/contributor-docs/contributing)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-theater-pi)

### Windows

A desktop media interface for Windows.

**Status:** ⭕ No Maintainers - [volunteer](/contributor-docs/contributing)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-theater-windows)

## Chrome

### Jellyfin for Google Chrome

The official Jellyfin Google Chrome extension.

**Status:** ⭕ No Maintainers - [volunteer](/contributor-docs/contributing)

**Links:**

[GitHub](https://github.com/jellyfin/jellyfin-chrome)


## Apple

### Jellyfin for Apple iOS

The official Jellyfin iOS app.

**Status:** ❎ Deprecated and unreleasable - [rewrite required](/contributor-docs/contributing)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-ios)

## Kodi

### Jellyfin for Kodi

The official Jellyfin Kodi plugin.

**Status:** ⭕ No Maintainers - [volunteer](/contributor-docs/contributing)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-kodi)

#### Installing

1. Download the add-on as a [zip file](https://github.com/jellyfin/jellyfin-kodi/archive/master.zip)
    * It will be saved as `jellyfin-kodi-master.zip`
2. Install Jellyfin for Kodi
    * Navigate to "Add-on Browser"
    * Select "Install from zip file"
        * If prompted, enter settings and enable "Unknown Sources", then go back
    * Select the newly downloaded file and it will be installed
3. Within a few seconds you should be prompted for your server-details.
    * If a Jellyfin server is detected on your local network, it will displayed in the popup
    * If a Jellyfin server is not detected on your local network, select "Manually add server"
        * Enter the server name or IP address and the port number (default is 8096)
        * If using SSL and a reverse proxy, enter the full URL scheme in the "Host" field
            * Host: https://jellyfin.example.com
            * Port: 443
    * Select user account and input password
4. Once you're succesfully authenticated with the Jellyfin server, you'll be asked about your preferences for this device
    * Select "Proceed" to continue setup now
    * Choose your preferences for each option
    * Select "Proceed" to configure libraries
    * Select the libraries you would like to keep synced with this device
5. The first sync of the Jellyfin server to the local Kodi database may take some time depending on your device and library size
6. Once the full sync is done, you can browse your media in Kodi, and syncs will be done periodically in the background

**Note: It's recommended to install the `Kodi Sync Queue` plugin into the Jellyfin server as well**

This will help keep your media libraries up to date without waiting for a periodic resync from Kodi.


## Roku

### Jellyfin for Roku

The official Jellyfin Roku app.

**Status:** ❎ Deprecated but salvageable - [major updates required](/contributor-docs/contributing)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-roku)

## Samsung TV

### Jellyfin for Samsung TV

The official Jellyfin Samsung TV app.

**Status:** ⭕ No Maintainers - [volunteer](/contributor-docs/contributing)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-samsungtv)

## Windows Phone

### Jellyfin for Windows Phone

The official Jellyfin Windows Phone app.

**Status:** ❎ Deprecated - [dead platform but salvageable](/contributor-docs/contributing)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-windowsphone)
