---
uid: clients-installing-mopidy
title: Installing Mopidy Plugin
---

# Installing Mopidy Plugin

The Mopidy Jellyfin plugin is available to install from [PyPi](https://pypi.org/project/Mopidy-Jellyfin) using pip.

## General

For general use computers, such as workstations or laptops, it's recommended to install Mopidy plugins in user mode.  Installing python packages from pip using sudo or root permissions can lead to conflicts with your package manager in the future.

1. Install Mopidy using your method of choice using the [official docs](https://docs.mopidy.com/en/latest/installation/)
1. Install the Jellyfin plugin for Mopidy:  
    `pip3 install --user mopidy-jellyfin`
2. (Optional) Install other mopidy related packages:  
    `pip3 install --user mopidy-mpd mopidy-musicbox-webclient`
3. Configure your `mopidy.conf` located at `$HOME/.config/mopidy/mopidy.conf`  
    See [Config File](xref:clients-installing-mopidy#config-file)
4. There may be a need to install extra gstreamer codecs if they're not already on your system, but these are highly variable and depend on your hardware and distro

## Raspberry Pi (Remote Controlled Speakers)

Utilizing a Raspberry Pi (or other small form factor computer) it's possible to use Mopidy to build a set of standalone smart speakers connected to your Jellyfin server.

1. Grab the latest [raspbian image](https://www.raspberrypi.org/downloads/raspbian/).  Unless you have a need for a GUI, the 'Lite' image is plenty for this project.
2. Install the image to the sd card (See the [official docs](https://www.raspberrypi.org/documentation/installation/installing-images/README.md))
3. Install Mopidy from their [apt repo](https://docs.mopidy.com/en/latest/installation/debian/#install-from-apt-mopidy-com) to ensure we get the latest version
4. Install required OS packages:  
    `sudo apt install mopidy mopidy-mpd gstreamer1.0-plugins-bad python3-pip`
5. Install the Jellyfin plugin and any other Mopidy related packages you may want:  
    `sudo pip3 install mopidy-jellyfin mopidy-musicbox-webclient`
6. Configure your `mopidy.conf` located at `/etc/mopidy/mopidy.conf`:  
    See [Config File](xref:clients-installing-mopidy#config-file)
7. Enable and start the mopidy service:  
    `sudo systemctl enable --now mopidy`

## Config File

The config file for mopidy is divided into sections in an ini format.  An example Jellyfin example is shown here.

```ini
[jellyfin]
hostname = Jellyfin server hostname
port = Jellyfin server port
username = username
password = password
# Optional: will default to "Music" if left undefined
libraries = Library1, Library2
```

The `libraries` option determines what is populated into Mopidy's internal library.  All of your audio libraries will be available from the browse menu regardless of what is entered here.

Other options that may be useful to include:

```ini
[mpd]
enabled = true
# Useful if you want to control this instance from a remote mpd client
hostname = 0.0.0.0
# If you have artists or folders with large amounts of files, this helps avoid timeout errors
connection_timeout = 300

# Used in the event you want to control this system from a web browser
[http]
hostname = 0.0.0.0
```
