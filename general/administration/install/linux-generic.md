---
uid: admin-install-linux-generic
title: Installing on generic Linux
---

# Installing on generic Linux

Generic amd64, arm64, and armhf Linux builds in TAR archive format are available [here](https://jellyfin.org/downloads/#linux).

## Base Installation Process

Create a directory in `/opt` for jellyfin and its files, and enter that directory.

```sh
sudo mkdir /opt/jellyfin
cd /opt/jellyfin
```

Download the latest generic Linux build for your architecture.
The rest of these instructions assume version 10.7.7 is being installed (i.e. `jellyfin_10.7.7_amd64.tar.gz`).
Download the generic build, then extract the archive:

```sh
sudo wget https://repo.jellyfin.org/releases/server/linux/stable/combined/jellyfin_10.7.7_amd64.tar.gz
sudo tar xvzf jellyfin_10.7.7_amd64.tar.gz
```

Create a symbolic link to the Jellyfin 10.7.7 directory.
This allows an upgrade by repeating the above steps and enabling it by simply re-creating the symbolic link to the new version.

```sh
sudo ln -s jellyfin_10.7.7 jellyfin
```

Create four sub-directories for Jellyfin data.

```sh
sudo mkdir data cache config log
```

## `ffmpeg` Installation

If you are not running a Debian derivative, install `ffmpeg` through your OS's package manager, and skip this section.

> [!WARNING]
> Not being able to use `jellyfin-ffmpeg` will most likely break hardware acceleration and tonemapping.

If you are running Debian or a derivative, you should [download](https://repo.jellyfin.org/releases/server/debian/versions/jellyfin-ffmpeg/) and install an `ffmpeg` release built specifically for Jellyfin.
Be sure to download the latest release that matches your OS (4.4.1-1 for Debian Bullseye assumed below).

```sh
sudo wget https://repo.jellyfin.org/releases/server/debian/versions/jellyfin-ffmpeg/4.4.1-1/jellyfin-ffmpeg_4.4.1-1-bullseye_amd64.deb
sudo dpkg --install jellyfin-ffmpeg_4.4.1-1-bullseye_amd64.deb
```

If you run into any dependency errors, run this and it will install them and `jellyfin-ffmpeg`.

```sh
sudo apt install -f
```

## Running Jellyfin

Due to the number of command line options that must be passed, it is easiest to create a small script to run Jellyfin.

```sh
sudo nano jellyfin.sh
```

Then paste the following commands and modify as needed.

```sh
#!/bin/bash
JELLYFINDIR="/opt/jellyfin"
FFMPEGDIR="/usr/share/jellyfin-ffmpeg"

$JELLYFINDIR/jellyfin/jellyfin \
 -d $JELLYFINDIR/data \
 -C $JELLYFINDIR/cache \
 -c $JELLYFINDIR/config \
 -l $JELLYFINDIR/log \
 --ffmpeg $FFMPEGDIR/ffmpeg
```

Assuming you desire Jellyfin to run as a non-root user, `chmod` all files and directories to your normal login user and group.
Also make the startup script above executable.

```sh
sudo chown -R user:group *
sudo chmod u+x jellyfin.sh
```

Finally you can run it.
You will see lots of log information when run, this is normal.
Setup is as usual in the web browser.

```sh
./jellyfin.sh
```

## Starting Jellyfin on boot (optional)

Create a `systemd` unit file.

```sh
cd /etc/systemd/system
sudo nano jellyfin.service
```

Then paste the following contents, replacing `youruser` with your username.

```ini
[Unit]
Description=Jellyfin
After=network.target

[Service]
Type=simple
User=youruser
Restart=always
ExecStart=/opt/jellyfin/jellyfin.sh

[Install]
WantedBy=multi-user.target
```

Apply the correct permissions to the file, enable the service to start on boot, then start it.

```sh
sudo chmod 644 jellyfin.service
sudo systemctl daemon-reload
sudo systemctl enable jellyfin.service
sudo systemctl start jellyfin.service
```
