---
uid: server-live-tv-setup
title: Live TV Setup Guide
---

## Add a TV tuner to Jellyfin (Automatic Discovery)

Click on the Admin Panel Icon in the top right corner (1)
Click 'Live TV' (2) under the 'Live TV' section
Click the '+' button (3) next to 'Tuner Devices'

<img src="/images/tuner1.png">


Click 'Detect My Devices' from the 'Live TV Tuner Setup' page that opens
JF will search and hopefully find your tuner automatically:

<img src="/images/tuner2.png">

Click on the device you'd like to set up then set any options then click 'Save'

<img src="/images/tuner3.png">

## Add a TV tuner to Jellyfin (Manual setup)

You can set up your tuners manually if they were not automatically discovered.  Click the 'Tuner Type' pull down.  Choose between 'HD Homerun', 'M3U Tuner', and 'Other'

<img src="/images/tuner4.png">

<h3>HD Homerun specific options:</h3>

* Tuner IP Address is the URL of your HD Homerun device.  Format will be http://YOUR.IP.ADDRESS

* Allow hardware transcoding will allow the tuner to transcode the video on the fly which can reduce server load.  Not all HD Homeruns support hardware transcoding.

* Restrict to channels marked as favorite will only import channels that are designated as favorite channels on the tuner.  This helps if your tuner autoscans and adds new channels that you do not want and/or adds channels that you are able to receive due to atmospheric conditions but later are not accessible.

To set a favorite, go to http://my.hdhomerun.com , select your tuner and then click on the grey star next to the channel name to change the star to yellow.  The yellow star indicates a favorited channel.  In this example, only the channels with yellow stars will be imported into Jellyfin

<img src="/images/hdhr_opt1.png">



<h3>M3U Tuner specific options:</h3>

This tuner allows you to add IPTV channel to Jellyfin by using the appropriate M3U8 playlist file.

* File or URL is the location of the M3U8 playlist.  The file can either be stored online at a web (HTTP) address or stored locally.

* User agent is needed in special cases where you need to supply a custome HTTP header to access the remotely stored M3U8 playlist

* Simultaneous stream limit will restrict the number of streams the server can have open at one time.  Setting this value to '0' will allow for unlimited streams

* Auto-loop live streams is sometimes necessary for some IPTV channels.  Turn this on only if your streams are not playing correctly


## Adding guide data:

Guide data is necessary for scheduling tv recordings and for browsing what's currently playing and what will air later.  Follow these steps once you have a tuner device set up.  Click on the Admin Panel Icon in the top right corner, Click 'Live TV' (2) under the 'Live TV' section, Click the '+' button next to 'TV Guide Data Providers' :

<img src="/images/guide1.png">


Choose between 'Schedules Direct' and 'Xml TV'
 
<b>Schedules Direct:</b>

Schedules Direct is a pay service that provides U.S./Canadian guide data for use in OSS projects.  The price is $25 a year and has not increased since it began in 2007.  The guide data is highly reliable.  Create an account at http://www.schedulesdirect.org

<b>Xml TV:</b>

Xml TV option allows for downloading of guide data in the XMLTV format ( http://wiki.xmltv.org/index.php/XMLTVFormat )

## Mapping channels:

Guide data from the 'TV Guide Data Providers' will need to be mapped to the physical channel from the tuner.  Click the '...' next to the guide provider you set up and select 'Map Channels'

<img src="/images/channels1.png">


The list of physical channels will be displayed.  Click the pencil icon to the right of the channel and then select the corresponding channel from the guide provider to map the channel.  Do this for all channels.  Click the left arrow at the top left of the window to exit and save:

<img src="/images/channels1.png">

The guide data will automatically refresh.  You can check that the data imported correctly by going to the 'Live TV Guide'  page from the main Jellyfin web page on your server.
