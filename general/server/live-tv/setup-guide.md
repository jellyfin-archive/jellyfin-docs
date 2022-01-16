---
uid: server-live-tv-setup-guide
title: Setup Guide
---

# Setup Guide

## Add a TV Tuner to Jellyfin (Automatic Discovery)

Click on the Admin Panel Icon in the top right corner (1)
Click 'Live TV' (2) under the 'Live TV' section
Click the '+' button (3) next to 'Tuner Devices'

![How to access the 'Tuner Devices' page](~/images/live-tv-setup-tuner1.png)

Click 'Detect My Devices' from the 'Live TV Tuner Setup' page that opens
Jellyfin will search and hopefully find your tuner automatically:

![An example of detected TV tuner devices](~/images/live-tv-setup-tuner2.png)

Click on the device you'd like to set up then set any options then click 'Save'

![Saving TV tuner setup](~/images/live-tv-setup-tuner3.png)

## Add a TV Tuner to Jellyfin (Manual Setup)

You can set up your tuners manually if they were not automatically discovered.  Click the 'Tuner Type' pull down.  Choose between 'HD Homerun', 'M3U Tuner', and 'Other'

![Manually adding a TV tuner](~/images/live-tv-setup-tuner4.png)

### HDHomeRun Specific Options

* Tuner IP Address is the URL of your HDHomeRun device. The format will be `http://YOUR.IP.ADDRESS`

* Allow hardware transcoding will allow the tuner to transcode the video on the fly which can reduce server load.  Not all HDHomeRun devices support hardware transcoding.

* Restrict to channels marked as favorite will only import channels that are designated as favorite channels on the tuner.  This helps if your tuner autoscans and adds new channels that you do not want and/or adds channels that you are able to receive due to atmospheric conditions but later are not accessible.

To set a favorite, go to the [HDHomeRun website](http://my.hdhomerun.com), select your tuner and then click on the grey star next to the channel name to change the star to yellow.  The yellow star indicates a favorited channel.  In this example, only the channels with yellow stars will be imported into Jellyfin

![Selecting favorites in HDHomeRun](~/images/live-tv-setup-hdhr_opt1.png)

### M3U Tuner Specific Options

This tuner allows you to add IPTV channel to Jellyfin by using the appropriate M3U8 playlist file.

* File or URL is the location of the M3U8 playlist.  The file can either be stored online at a web (HTTP) address or stored locally.

* User agent is needed in special cases where you need to supply a custome HTTP header to access the remotely stored M3U8 playlist

* Simultaneous stream limit will restrict the number of streams the server can have open at one time.  Setting this value to '0' will allow for unlimited streams

* Auto-loop live streams is sometimes necessary for some IPTV channels.  Turn this on only if your streams are not playing correctly

> [!NOTE]
> Here is a list of legal samples to use to test connectivity.
>
> [LegalStream Live News Playlist](https://raw.githubusercontent.com/notanewbie/LegalStream/master/packages/news/live.m3u8)

## Adding Guide Data

Guide data is necessary for scheduling tv recordings and for browsing what's currently playing and what will air later.  Follow these steps once you have a tuner device set up.  Click on the Admin Panel Icon in the top right corner, Click 'Live TV' (2) under the 'Live TV' section, Click the '+' button next to 'TV Guide Data Providers' :

![How to add guide data](~/images/live-tv-setup-guide1.png)

Choose between 'Schedules Direct' and 'XMLTV'. You currently cannot use both at the same time.

**Schedules Direct:**

Schedules Direct is a paid service that provides U.S. and Canadian guide data for use in OSS projects. The price is $25 a year and has not increased since it began in 2007. The guide data is highly reliable. You will have to create an account at their [website](http://www.schedulesdirect.org).

**XMLTV:**

This option allows for downloading of guide data in the [XMLTV](http://wiki.xmltv.org/index.php/XMLTVFormat) format.

## Mapping Channels

Guide data from the 'TV Guide Data Providers' will need to be mapped to the physical channel from the tuner. Click the '...' next to the guide provider you set up and select 'Map Channels'

![Step 1 of mapping channels](~/images/live-tv-setup-channels1.png)

The list of physical channels will be displayed. Click the pencil icon to the right of the channel and then select the corresponding channel from the guide provider to map the channel. Do this for all channels. Click the left arrow at the top left of the window to exit and save the information.

![Step 2 of mapping channels](~/images/live-tv-setup-channels2.png)

The guide data will now automatically imported. You can check that the data has been imported correctly by going to the 'Live TV Guide' page from the main Jellyfin web page on your server.

## Recording Post Processing

Jellyfin supports Post Processing of recorded Live TV shows. This can be used to transcode the recording to a specific format that does not require transcoding on the fly when playing back, extract subtitles, remove commercials, and more.

There are several different ways to set up your post-processing script, and this largely will need to be changed to your individual use case.

Somewhere to start:
[Transcode to MP4 with AAC audio](https://gist.github.com/AndrewBreyen/5c28ae36831aa7363cc1e4131ce597dc)
[Commercial Skipping](https://www.reddit.com/comments/jvzxnd/comment/hh6zwdn/)

Save your script to somewhere accessible by your Jellyfin instance.

In the Live TV DVR settings, you will need to configure your post processing script.
These settings are for a script that requires one command line parameter, in this case, the path to the newly recorded file.

Post-processing application: /path/to/your/script.sh
Post-processor command line arguments: "{path}"
![Live TV post process configuration](~/images/live-tv-post-process.png)
**note that {path} likely will need to be in quotes: again, your mileage may vary.
