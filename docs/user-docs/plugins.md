# Jellyfin Plugins

Jellyfin has a collection of optional plugins that can be installed to provide additional features.

## Installing Plugins

The plugin repo is currently still being reimplemented, but until then we do have a few plugins working manually such as the Anime and Trakt plugins. If you can build them yourself, simply move them to `var/lib/jellyfin/plugins` and restart your server to include them with your server. The folder itself will probably need to be created and the permissions need to be properly set so Jellyfin can access the files. Please note, we are still working on plugin support and cannot guarantee a painless install process.

## Plugins List

### Official Plugins

#### anime

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-anime.svg)](https://github.com/jellyfin/jellyfin-plugin-anime)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-anime.svg)](https://github.com/jellyfin/jellyfin-plugin-anime)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-anime.svg)](https://github.com/jellyfin/jellyfin-plugin-anime)

#### autoorganize

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-autoorganize.svg)](https://github.com/jellyfin/jellyfin-plugin-autoorganize)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-autoorganize.svg)](https://github.com/jellyfin/jellyfin-plugin-autoorganize)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-autoorganize.svg)](https://github.com/jellyfin/jellyfin-plugin-autoorganize)

#### bookshelf

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-bookshelf.svg)](https://github.com/jellyfin/jellyfin-plugin-bookshelf)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-bookshelf.svg)](https://github.com/jellyfin/jellyfin-plugin-bookshelf)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-bookshelf.svg)](https://github.com/jellyfin/jellyfin-plugin-bookshelf)

#### channels

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-channels.svg)](https://github.com/jellyfin/jellyfin-plugin-channels)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-channels.svg)](https://github.com/jellyfin/jellyfin-plugin-channels)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-channels.svg)](https://github.com/jellyfin/jellyfin-plugin-channels)

#### emailnotifications

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-emailnotifications.svg)](https://github.com/jellyfin/jellyfin-plugin-emailnotifications)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-emailnotifications.svg)](https://github.com/jellyfin/jellyfin-plugin-emailnotifications)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-emailnotifications.svg)](https://github.com/jellyfin/jellyfin-plugin-emailnotifications)

#### gamebrowser

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-gamebrowser.svg)](https://github.com/jellyfin/jellyfin-plugin-gamebrowser)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-gamebrowser.svg)](https://github.com/jellyfin/jellyfin-plugin-gamebrowser)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-gamebrowser.svg)](https://github.com/jellyfin/jellyfin-plugin-gamebrowser)

#### iptv

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-iptv.svg)](https://github.com/jellyfin/jellyfin-plugin-iptv)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-iptv.svg)](https://github.com/jellyfin/jellyfin-plugin-iptv)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-iptv.svg)](https://github.com/jellyfin/jellyfin-plugin-iptv)

#### nextpvr

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-nextpvr.svg)](https://github.com/jellyfin/jellyfin-plugin-nextpvr)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-nextpvr.svg)](https://github.com/jellyfin/jellyfin-plugin-nextpvr)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-nextpvr.svg)](https://github.com/jellyfin/jellyfin-plugin-nextpvr)

#### notifymyandroid

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-notifymyandroid.svg)](https://github.com/jellyfin/jellyfin-plugin-notifymyandroid)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-notifymyandroid.svg)](https://github.com/jellyfin/jellyfin-plugin-notifymyandroid)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-notifymyandroid.svg)](https://github.com/jellyfin/jellyfin-plugin-notifymyandroid)

#### onedrive

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-onedrive.svg)](https://github.com/jellyfin/jellyfin-plugin-onedrive)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-onedrive.svg)](https://github.com/jellyfin/jellyfin-plugin-onedrive)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-onedrive.svg)](https://github.com/jellyfin/jellyfin-plugin-onedrive)

#### prowl

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-prowl.svg)](https://github.com/jellyfin/jellyfin-plugin-prowl)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-prowl.svg)](https://github.com/jellyfin/jellyfin-plugin-prowl)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-prowl.svg)](https://github.com/jellyfin/jellyfin-plugin-prowl)

#### pushalot

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-pushalot.svg)](https://github.com/jellyfin/jellyfin-plugin-pushalot)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-pushalot.svg)](https://github.com/jellyfin/jellyfin-plugin-pushalot)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-pushalot.svg)](https://github.com/jellyfin/jellyfin-plugin-pushalot)

#### pushbullet

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-pushbullet.svg)](https://github.com/jellyfin/jellyfin-plugin-pushbullet)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-pushbullet.svg)](https://github.com/jellyfin/jellyfin-plugin-pushbullet)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-pushbullet.svg)](https://github.com/jellyfin/jellyfin-plugin-pushbullet)

#### pushover

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-pushover.svg)](https://github.com/jellyfin/jellyfin-plugin-pushover)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-pushover.svg)](https://github.com/jellyfin/jellyfin-plugin-pushover)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-pushover.svg)](https://github.com/jellyfin/jellyfin-plugin-pushover)

#### reports

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-reports.svg)](https://github.com/jellyfin/jellyfin-plugin-reports)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-reports.svg)](https://github.com/jellyfin/jellyfin-plugin-reports)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-reports.svg)](https://github.com/jellyfin/jellyfin-plugin-reports)

#### rokubif

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-rokubif.svg)](https://github.com/jellyfin/jellyfin-plugin-rokubif)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-rokubif.svg)](https://github.com/jellyfin/jellyfin-plugin-rokubif)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-rokubif.svg)](https://github.com/jellyfin/jellyfin-plugin-rokubif)

#### rottentomatoes

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-rottentomatoes.svg)](https://github.com/jellyfin/jellyfin-plugin-rottentomatoes)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-rottentomatoes.svg)](https://github.com/jellyfin/jellyfin-plugin-rottentomatoes)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-rottentomatoes.svg)](https://github.com/jellyfin/jellyfin-plugin-rottentomatoes)

#### toutv

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-toutv.svg)](https://github.com/jellyfin/jellyfin-plugin-toutv)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-toutv.svg)](https://github.com/jellyfin/jellyfin-plugin-toutv)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-toutv.svg)](https://github.com/jellyfin/jellyfin-plugin-toutv)

#### trakt

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-trakt.svg)](https://github.com/jellyfin/jellyfin-plugin-trakt)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-trakt.svg)](https://github.com/jellyfin/jellyfin-plugin-trakt)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-trakt.svg)](https://github.com/jellyfin/jellyfin-plugin-trakt)

#### tunein

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-tunein.svg)](https://github.com/jellyfin/jellyfin-plugin-tunein)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-tunein.svg)](https://github.com/jellyfin/jellyfin-plugin-tunein)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-tunein.svg)](https://github.com/jellyfin/jellyfin-plugin-tunein)

#### tvheadend

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-tvheadend.svg)](https://github.com/jellyfin/jellyfin-plugin-tvheadend)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-tvheadend.svg)](https://github.com/jellyfin/jellyfin-plugin-tvheadend)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-tvheadend.svg)](https://github.com/jellyfin/jellyfin-plugin-tvheadend)

#### tvmaze

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-tvmaze.svg)](https://github.com/jellyfin/jellyfin-plugin-tvmaze)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-tvmaze.svg)](https://github.com/jellyfin/jellyfin-plugin-tvmaze)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-tvmaze.svg)](https://github.com/jellyfin/jellyfin-plugin-tvmaze)

### 3rd Party Plugins

#### [antennas](https://github.com/TheJF/antennas)

Takes your tuners in Tvheadend and emulates a HDHomeRun in order to connect to Jellyfin's DVR feature. That means any tuner whether dvb-t, dvb-c, dvb-s or ATSC can work with Jellyfin providing Tvheadend supports it (i.e you've installed the drivers for your tuner). It can be installed via binaries, Node or Docker. Set-up requires an anonymous user in Tvheadend with rights and streaming profiles as well as your channel list having the correct numbers. Configuration parameters are a URL that will show the status of Antennas, the URL of your Tvheadend installation with your username and password as well as the number of tuners you have. Then just setup your tuner in Jellyfin by selecting a HD Homerun then enter your Antennas URL. For setting up guide data, you have to use XMLTV. Either a link or .xml file will work. In the UK, I use the free xmltv.co.uk which gives me a link for 7 days guide data.

