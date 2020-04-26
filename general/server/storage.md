---
uid: server-storage
title: Storage
---

## Storage

Jellyfin is designed to directly read media from the filesystem. This means to pass a network storage device that is using samba or NFS must be directly mounted to the OS. The Jellyfin database also should be stored locally and not on a network storage device.

## Docker/VM's

For storage, a library database can take up to 50 to 100 GB. The [transcoding](https://github.com/jellyfin/jellyfin-docs/blob/master/general/server/transcoding.md) folder needs roughly the same size as the original media if it's being transcoded at the same bitrate. A single 50GB Blu-Ray Remux by itself can take up to approximately 60GB or as little as 15GB, depending on the quality selected. If the transcoding folder is held on the same storage as the database, this must be taken into considerable.

## Cloud

A popular choice for cloud storage has been the program [rclone](https://rclone.org/). To prevent API bans, rclone is typically paired with another program such as [mergerfs](https://github.com/trapexit/mergerfs). 

- animostiy's [repo](https://github.com/animosity22/homescripts) about rclone and mergerfs. 

- animosity22's [rclone config](https://github.com/animosity22/homescripts/blob/master/systemd/rclone.service).

### MergerFS

For best performance with rclone and mergerfs, it is ideal to establish a rclone [cache](https://rclone.org/cache). Mergerfs isn't meant for everything, [see here](https://github.com/trapexit/mergerfs#what-should-mergerfs-not-be-used-for) for more.

- animosity22's [mergerfs config](https://github.com/animosity22/homescripts/blob/master/systemd/gmedia.service).

To modify and examine your mergerfs mount, here's a quick [guide](https://zackreed.me/mergerfs-neat-tricks/).

To create a crypt drive with a cache, there's a specific manner that it has to been done. See this [section](https://rclone.org/cache/#cache-and-crypt) for more. 
