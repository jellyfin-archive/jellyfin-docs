---
uid: server-plugins-tvheadend
title: TVHeadend
---

# TVHeadend

The objective of the guide is to configure the Jellyfin Tvheadend plugin to backend a Tvheadend server.

## Requirements

* Tvheadend server
* Jellyfin server
* TVHeadend plugin installed in Jellyfin

## Configuration

1. Create a user for Jellyfin in Tvheadend: it is convenient to create a specific user for Jellyfin. Steps:
    * Go to Configuration> Users> Access Entries> Add
    * Give the user parameters
        * Enabled: ✔
        * Username: *Username* (for example: Jellyfin)
        * Change parameters: Rights,Channel number range,Channel tags,DVR configurations,Streaming profiles,Connection limits *
        * Web interface: ✔
        * Streaming: Basic,Advanced,HTSP *
        * Video recoder: Basic,HTSP,View all *
        * (optional) Comment: Comment for the user (for example: User used by Jellyfin)
        * (optional) Allowed networks: *Network address with network mask to allow* (for example 127.0.0.1/32)
        * Press Save
    * Go to Configuration> Users> Passwords> Add
    * Give the user parameters
        * Enabled: ✔
        * Username *The user created previously* (for example: Jellyfin)
        * Password: *The password for the user created previously* (for example: Jellyfin_password)
        * Press Save

    **Notes:** The parameters Change parameters, Streaming and Video recoder must be marked as shown, because although Jellyfin can connect to Tvheadend, it can cause problems when reproducing the content.

2. Adjust the Jellyfin Tvheadend plugin to establish the connection
    * Go to Dashboard> Plugins> TVHeadend> Settings
    * Provide creator access data previously:
        * TVHeadend Hostname or IP Address: *IP address of the Tvheadend server* (For example: 127.0.0.1) *
        * Username: *The user created previously* (for example: Jellyfin)
        * Password: *The password created previously* (for example: Jellyfin_password)
      
      **Notes:** By default the the *TVHeadend Hostname or IP Address* section is configured by default with the hostname *localhost*, it is preferable to use the IP address *127.0.0.1* instead of *localhost*. [Reference](https://emby.media/community/index.php?/topic/55768-tv-headend-plugin-where-does-it-store-data/)
      
3. Configure the channels for viewing in Jellyfin: even if Jellyfin manages to connect to Tvheadend, the guide will not be synchronized because there has to be a number assigned to the channels in Tvheadend [Reference](https://emby.media/community/index.php?/topic/64583-no-channels-with-tvheadend-plugin/#ipboard_body)
    * Go to Configuration> Channel/EPG> Channels
    * Select the channel to be changed and press Edit
    * In the option Number we enter the number that we are going to assign to the channel (for example: 1)
    * Press save

4. Update the data from the TVheadend guide to Jellyfin
    * Go to Dashboard> Live TV
    * Refresh Guide data
    
Once the update of the guide is finished, the Live TV will already be able to see the guide related to the synchronized channels and will be able to visualize the content.
