---
uid: server-live-tv
title: Live TV
---

## Live TV

Jellyfin allows you to watch live television if you have the hardware to support it, and even handles DVR from the settings. The first step is setting up a tuner to send data to Jellyfin, and then configure a source for the guide data.

### Tuner

Jellyfin has support for the following tuners but can support additional tuners through the plugin catalog.

  * HDHomerun
  * M3U

HDHomerun is a special case because they will usually get detected automatically by the server. Otherwise you can manually add tuners by navigating to **Live TV** in the settings and adding one there.

Note:  Docker users using HDHomerun devices should set networking to host mode as Jellyfin needs to connect to a changing UDP port

### Guide

The guides available below are included with the server but additional guides could eventually be installed through the plugin catalog.

  * Schedules Direct
  * XML TV

Guide data will need to be mapped to their corresponding channels after a guide data provider is configured.  This can be accessed by going to

Admin Dashboard-> Live TV -> TV Guide Data Providers -> Your Provider -> ... -> Map Channels

### Status

You can view the status of each tuner connected to the server in the settings. There are also buttons to manually refresh the tuners if they experience problems.

The guide data can be refreshed manually if you run into problems. This isn't normally required since the data is refreshed periodically.
