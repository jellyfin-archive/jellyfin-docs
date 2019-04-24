# Plugins

Jellyfin has a collection of optional plugins that can be installed to provide additional features.

## Installing

### Catalog

Many plugins are available in a repository hosted on our servers, which can be easily installed using the plugin catalog in the settings. At the moment many of these are still being updated frequently so the version number may not be accurate. There are several different categories that can indicate what kind of functionality the plugins may provide.

**Channels:** Allow streaming remote audio or video content.

**Metadata:** Scrape metadata from a new source or modify existing metadata.

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

Takes your tuners in Tvheadend and emulates a HDHomeRun in order to connect to Jellyfin's DVR feature. That means any tuner whether dvb-t, dvb-c, dvb-s or ATSC can work with Jellyfin providing Tvheadend supports it (i.e you've installed the drivers for your tuner). It can be installed via binaries, Node or Docker. Set-up requires an anonymous user in Tvheadend with rights and streaming profiles as well as your channel list having the correct numbers. Configuration parameters are a URL that will show the status of Antennas, the URL of your Tvheadend installation with your username and password as well as the number of tuners you have. Then just setup your tuner in Jellyfin by selecting a HD Homerun then enter your Antennas URL. For setting up guide data, you have to use XMLTV. Either a link or .xml file will work. In the UK, I use the free xmltv.co.uk which gives me a link for 7 days guide data.

#### [gotify](https://github.com/crobibero/Jellyfin.Plugins.Gotify)

Sends notifications to your self-hosted [Gotify](https://gotify.net/) server.

#### [LazyMan](https://github.com/crobibero/Jellyfin.Channels.LazyMan)

A channel to watch content from LazyMan on Jellyfin.

#### [serverwmc](https://github.com/PrplHaz4/jellyfin-plugin-serverwmc)

Jellyfin plugin for Windows MediaCenter with [ServerWMC](https://github.com/PrplHaz4/jellyfin-plugin-serverwmc) as the backend on the target machine.
