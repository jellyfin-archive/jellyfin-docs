---
uid: server-plugins-index
title: Plugins
---

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

#### Anime

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-anime.svg)](https://github.com/jellyfin/jellyfin-plugin-anime)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-anime.svg)](https://github.com/jellyfin/jellyfin-plugin-anime)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-anime.svg)](https://github.com/jellyfin/jellyfin-plugin-anime)

Manage your Anime in Jellyfin. Supports several different metadata providers and options for organizing your collection.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-anime)

#### Auto Organize

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-autoorganize.svg)](https://github.com/jellyfin/jellyfin-plugin-autoorganize)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-autoorganize.svg)](https://github.com/jellyfin/jellyfin-plugin-autoorganize)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-autoorganize.svg)](https://github.com/jellyfin/jellyfin-plugin-autoorganize)

Automatically organizes your media by monitoring a folder and moving or copying new media files into your library folder.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-autoorganize)

#### Bookshelf

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-bookshelf.svg)](https://github.com/jellyfin/jellyfin-plugin-bookshelf)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-bookshelf.svg)](https://github.com/jellyfin/jellyfin-plugin-bookshelf)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-bookshelf.svg)](https://github.com/jellyfin/jellyfin-plugin-bookshelf)

Supports several different metadata providers and options for organizing your collection. 

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-bookshelf)

#### Email Notifications

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-emailnotifications.svg)](https://github.com/jellyfin/jellyfin-plugin-emailnotifications)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-emailnotifications.svg)](https://github.com/jellyfin/jellyfin-plugin-emailnotifications)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-emailnotifications.svg)](https://github.com/jellyfin/jellyfin-plugin-emailnotifications)

Send SMTP email notifications.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-emailnotifications)

#### Fanart

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-fanart.svg)](https://github.com/jellyfin/jellyfin-plugin-fanart)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-fanart.svg)](https://github.com/jellyfin/jellyfin-plugin-fanart)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-fanart.svg)](https://github.com/jellyfin/jellyfin-plugin-fanart)

Scrape poster images for movies, shows, and artists in your library from [fanart.tv](https://fanart.tv).

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-fanart)

#### Gotify Notifications

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-gotify.svg)](https://github.com/jellyfin/jellyfin-plugin-gotify)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-gotify.svg)](https://github.com/jellyfin/jellyfin-plugin-gotify)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-gotify.svg)](https://github.com/jellyfin/jellyfin-plugin-gotify)

Sends notifications to your self-hosted [Gotify](https://gotify.net/) server.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-gotify)

#### IPTV

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-iptv.svg)](https://github.com/jellyfin/jellyfin-plugin-iptv)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-iptv.svg)](https://github.com/jellyfin/jellyfin-plugin-iptv)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-iptv.svg)](https://github.com/jellyfin/jellyfin-plugin-iptv)

Allows you to add IPTV feeds to Jellyfin.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-iptv)

#### Kodi Sync Queue

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-kodisyncqueue.svg)](https://github.com/jellyfin/jellyfin-plugin-kodisyncqueue)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-kodisyncqueue.svg)](https://github.com/jellyfin/jellyfin-plugin-kodisyncqueue)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-kodisyncqueue.svg)](https://github.com/jellyfin/jellyfin-plugin-kodisyncqueue)

Helps keep Jellyfin for Kodi in sync with the library without needing to run periodic full scans.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-kodisyncqueue)

#### LDAP Authentication

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-ldapauth.svg)](https://github.com/jellyfin/jellyfin-plugin-ldapauth)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-ldapauth.svg)](https://github.com/jellyfin/jellyfin-plugin-ldapauth)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-ldapauth.svg)](https://github.com/jellyfin/jellyfin-plugin-ldapauth)

Authenticate your Jellyfin users against an LDAP database, and optionally create users who do not yet exist automatically. Allows the administrator to customize most aspects of the LDAP authentication process, including customizable search attributes, username attribute, and a search filter for administrative users (set on user creation). The user, via the "Manual Login" process, can enter any valid attribute value, which will be mapped back to the specified username attribute automatically as well. 

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-ldapauth)

#### NextPVR

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-nextpvr.svg)](https://github.com/jellyfin/jellyfin-plugin-nextpvr)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-nextpvr.svg)](https://github.com/jellyfin/jellyfin-plugin-nextpvr)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-nextpvr.svg)](https://github.com/jellyfin/jellyfin-plugin-nextpvr)

Provides access to LiveTV, Program Guide and Recordings from [NextPVR](https://www.nextpvr.com/).

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-nextpvr)

#### [Open Subtitles](xref:server-plugins-open-subtitles)

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-opensubtitles.svg)](https://github.com/jellyfin/jellyfin-plugin-opensubtitles)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-opensubtitles.svg)](https://github.com/jellyfin/jellyfin-plugin-opensubtitles)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-opensubtitles.svg)](https://github.com/jellyfin/jellyfin-plugin-opensubtitles)

Download subtitles from the internet to use with your media files from [Open Subtitles](https://www.opensubtitles.org/). You can configure the languages it downloads on a per-library basis.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-opensubtitles)

#### Playback Reporting

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-playbackreporting.svg)](https://github.com/jellyfin/jellyfin-plugin-playbackreporting)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-playbackreporting.svg)](https://github.com/jellyfin/jellyfin-plugin-playbackreporting)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-playbackreporting.svg)](https://github.com/jellyfin/jellyfin-plugin-playbackreporting)

Collect and show user playback statistics, such as total time watched, media watched, time of day watched and time of week watched. Can keep information for as long as you want, or can cull older information automatically. Also allows you to manually query the data collected so you can generate your own reports.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-playbackreporting)

#### Pushbullet

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-pushbullet.svg)](https://github.com/jellyfin/jellyfin-plugin-pushbullet)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-pushbullet.svg)](https://github.com/jellyfin/jellyfin-plugin-pushbullet)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-pushbullet.svg)](https://github.com/jellyfin/jellyfin-plugin-pushbullet)

Get notifications via Pushbullet.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-pushbullet)

#### Reports

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-reports.svg)](https://github.com/jellyfin/jellyfin-plugin-reports)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-reports.svg)](https://github.com/jellyfin/jellyfin-plugin-reports)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-reports.svg)](https://github.com/jellyfin/jellyfin-plugin-reports)

Generate reports of your media library.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-reports)

#### ServerWMC

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-serverwmc.svg)](https://github.com/jellyfin/jellyfin-plugin-serverwmc)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-serverwmc.svg)](https://github.com/jellyfin/jellyfin-plugin-serverwmc)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-serverwmc.svg)](https://github.com/jellyfin/jellyfin-plugin-serverwmc)

Provides access to LiveTV, Program Guide and Recordings from your Windows MediaCenter Server running ServerWMC.
Requires [ServerWMC](https://serverwmc.github.io/) to be installed and running on your Windows MediaCenter machine.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-serverwmc)

#### Slack Notifications

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-slack.svg)](https://github.com/jellyfin/jellyfin-plugin-slack)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-slack.svg)](https://github.com/jellyfin/jellyfin-plugin-slack)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-slack.svg)](https://github.com/jellyfin/jellyfin-plugin-slack)

Get notifications via Slack.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-slack)

#### TMDb Box Sets

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-tmdbboxsets.svg)](https://github.com/jellyfin/jellyfin-plugin-tmdbboxsets)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-tmdbboxsets.svg)](https://github.com/jellyfin/jellyfin-plugin-tmdbboxsets)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-tmdbboxsets.svg)](https://github.com/jellyfin/jellyfin-plugin-tmdbboxsets)

Automatically create movie box sets based on TMDb collections. Configerable minimum number of films to be considered a boxset. Boxsets are created as collections, and includes a schedueld task to ensure that new media is automatically put into boxsets.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-tmdbboxsets)

#### Trakt

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-trakt.svg)](https://github.com/jellyfin/jellyfin-plugin-trakt)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-trakt.svg)](https://github.com/jellyfin/jellyfin-plugin-trakt)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-trakt.svg)](https://github.com/jellyfin/jellyfin-plugin-trakt)

Record your watched media with [Trakt](https://trakt.tv). 

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-trakt)

#### [TVHeadend](xref:server-plugins-tvheadend)

[![](https://img.shields.io/github/languages/top/jellyfin/jellyfin-plugin-tvheadend.svg)](https://github.com/jellyfin/jellyfin-plugin-tvheadend)
[![](https://img.shields.io/github/contributors/jellyfin/jellyfin-plugin-tvheadend.svg)](https://github.com/jellyfin/jellyfin-plugin-tvheadend)
[![](https://img.shields.io/github/license/jellyfin/jellyfin-plugin-tvheadend.svg)](https://github.com/jellyfin/jellyfin-plugin-tvheadend)

Manage TVHeadend from Jellyfin.

**Links:** 

* [GitHub](https://github.com/jellyfin/jellyfin-plugin-tvheadend)

### 3rd-Party Plugins

#### Antennas

Takes your tuners in TVHeadend and emulates a HDHomeRun, in order to connect to Jellyfin's Live TV and DVR features. It requires additional setup and configuration, but is a useful alternative to the TVHeadend plugin.

**Links:** 

* [GitHub](https://github.com/TheJF/antennas)
