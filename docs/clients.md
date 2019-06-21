# Clients

Clients connect your devices to your Jellyfin server and let you view your content on any supported device. You can find a list of clients below with their current development status.

**Note**: Many clients were direct forks of the latest available codebases from Emby, and some are not functional yet. If you interested in helping out, please see our [contribution guide](/contributor-docs/contributing).

Do you have a client that interfaces with Jellyfin and want to see it listed here? Please [submit a PR](https://github.com/jellyfin/jellyfin-docs)!

## Android

### Jellyfin for Android

The official Jellyfin Android app supporting Android 5+.

**Status:** ⭐ In Beta release

**Links:**

<a href='https://play.google.com/store/apps/details?id=org.jellyfin.mobile&utm_source=docs&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' width="200"/></a>

* [GitHub](https://github.com/jellyfin/jellyfin-android)
* [Binary repository](https://repo.jellyfin.org/releases/client/android)

### Jellyfin for Android TV

The official Jellyfin Android TV app.

**Status:** ⭐ In Beta release

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-androidtv)
* [Binary repository](https://repo.jellyfin.org/releases/client/androidtv)

#### Installation on Amazon Fire TV Stick

Currently the Jellyfin app isn't listed on the Fire TV's app store. In order to install it, you need to use a process known as "side loading". 

1. Install the [Android SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools.html) on your workstation
2. [Enable debugging on your Fire TV](https://developer.amazon.com/docs/fire-tv/connecting-adb-to-device.html#turnondebugging)
    * Make sure to turn on ADB debugging
    * Make sure to allow apps from unknown sources
3. Download a binary version of the Android TV app from the repository above. Make sure to download one marked `amazon-release`
4. [Connect to your Fire TV over ADB](https://developer.amazon.com/docs/fire-tv/connecting-adb-to-device.html#connectingadboptions)
    * You can either connect over USB or over a network connection. To connect over the local network, find out your Fire TV's IP address
    * You'll need to confirm the connection over ADB on your Fire TV. A prompt will appear when your workstation attempts to connect
5. You're now ready to install the Jellyfin app. Run the following command once connected to your Fire TV over ADB: `adb install <PATH-TO-JELLYFIN-BINARY-YOU-DOWNLOADED>`. After 30-60 seconds you should receive a message telling you the installation was successful
6. You can now disconnect from ADB: `adb disconnect`

The Jellyfin app should now appear on your Fire TV device. Because the app isn't listed on the Fire TV store, you will have to repeat this process whenever you want to update the app. 

While the steps above look a little complex, they should only take 15-30 minutes to complete, depending on your proficiency with the Android SDK. No knowledge of Android development outside of the steps above is required.

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

## Web

### Web Scrobbler

Extension for browsers based on Chromium and Firefox that allows scrobble services like libre.fm and last.fm.

**Status:** ⭐ Active, 3rd-party

**Links:**

* [Web](https://web-scrobbler.github.io/)
* [GitHub](https://github.com/web-scrobbler/web-scrobbler)

### Jellyfin for Google Chrome

The official Jellyfin Google Chrome extension.

**Status:** ⭕ No Maintainers - [volunteer](/contributor-docs/contributing)

**Links:**

* [GitHub](https://github.com/jellyfin/jellyfin-chrome)

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

1. Download the repository installer as a [zip file](https://repo.jellyfin.org/releases/client/kodi/repository.jellyfin.kodi.zip)
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

## Mopidy

### Mopidy-Jellyfin

A third party plugin for Mopidy that uses Jellyfin as a backend.

**Status:** ⭐ Active, 3rd-party

**Links:**

* [GitHub](https://github.com/mcarlton00/mopidy-jellyfin)

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
