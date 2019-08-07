# Plugins

Jellyfin has a collection of optional plugins that can be installed to provide additional features.

## Installing

### Catalog

Many plugins are available in a repository hosted on our servers, which can be easily installed using the plugin catalog in the settings. At the moment many of these are still being updated frequently so the version number may not be accurate. There are several different categories that can indicate what kind of functionality the plugins may provide.

**Authentication:** Add new authentication providers, such as LDAP.

**Channels:** Allow streaming remote audio or video content.

**General:** Plugins that serve general purposes, such as sync with Trakt.tv, or Kodi.

**Live TV:** Plugins that help with connecting to tuners, such as NextPVR, or TVHeadend.

**Metadata:** Scrape metadata from a new source or modify existing metadata.

**Notifications:** Allow notifications to connect to many different services, including Gotify and Slack.

### Manual

All plugins hosted on the repository can be built from source and manually added to your server as well. They just need to be placed in the plugin directory, which is something like `var/lib/jellyfin/plugins` on most Linux distributions. Once the server is restarted any additions should automatically show up in your list of installed plugins. If you can't see the new plugin there may be a file permission issue.

## List

### Official Plugins

#### anime

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-anime.svg)](https://github.com/jellyfin/jellyfin-plugin-anime)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-anime.svg)](https://github.com/jellyfin/jellyfin-plugin-anime)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-anime.svg)](https://github.com/jellyfin/jellyfin-plugin-anime)

#### autoorganize

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-autoorganize.svg)](https://github.com/jellyfin/jellyfin-plugin-autoorganize)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-autoorganize.svg)](https://github.com/jellyfin/jellyfin-plugin-autoorganize)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-autoorganize.svg)](https://github.com/jellyfin/jellyfin-plugin-autoorganize)

#### emailnotifications

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-emailnotifications.svg)](https://github.com/jellyfin/jellyfin-plugin-emailnotifications)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-emailnotifications.svg)](https://github.com/jellyfin/jellyfin-plugin-emailnotifications)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-emailnotifications.svg)](https://github.com/jellyfin/jellyfin-plugin-emailnotifications)

#### iptv

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-iptv.svg)](https://github.com/jellyfin/jellyfin-plugin-iptv)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-iptv.svg)](https://github.com/jellyfin/jellyfin-plugin-iptv)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-iptv.svg)](https://github.com/jellyfin/jellyfin-plugin-iptv)

#### ldapauth

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-ldapauth.svg)](https://github.com/jellyfin/jellyfin-plugin-ldapauth)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-ldapauth.svg)](https://github.com/jellyfin/jellyfin-plugin-ldapauth)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-ldapauth.svg)](https://github.com/jellyfin/jellyfin-plugin-ldapauth)

#### reports

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-reports.svg)](https://github.com/jellyfin/jellyfin-plugin-reports)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-reports.svg)](https://github.com/jellyfin/jellyfin-plugin-reports)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-reports.svg)](https://github.com/jellyfin/jellyfin-plugin-reports)

#### serverwmc
[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-serverwmc.svg)](https://github.com/jellyfin/jellyfin-plugin-serverwmc)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-serverwmc.svg)](https://github.com/jellyfin/jellyfin-plugin-serverwmc)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-serverwmc.svg)](https://github.com/jellyfin/jellyfin-plugin-serverwmc)

Jellyfin LiveTV plugin for Windows MediaCenter with [ServerWMC](https://github.com/jellyfin/jellyfin-plugin-serverwmc).

#### trakt

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-trakt.svg)](https://github.com/jellyfin/jellyfin-plugin-trakt)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-trakt.svg)](https://github.com/jellyfin/jellyfin-plugin-trakt)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-trakt.svg)](https://github.com/jellyfin/jellyfin-plugin-trakt)

#### tvheadend

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-tvheadend.svg)](https://github.com/jellyfin/jellyfin-plugin-tvheadend)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-tvheadend.svg)](https://github.com/jellyfin/jellyfin-plugin-tvheadend)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-tvheadend.svg)](https://github.com/jellyfin/jellyfin-plugin-tvheadend)

### 3rd Party Plugins

#### [antennas](https://github.com/TheJF/antennas)

Takes your tuners in TVHeadend and emulates a HDHomeRun, in order to connect to Jellyfin's Live TV and DVR features. It requires additional setup and configuration, but is a useful alternative to the TVHeadend plug-in.

#### [gotify](https://github.com/jellyfin/jellyfin-plugin-gotify)		

  Sends notifications to your self-hosted [Gotify](https://gotify.net/) server.
