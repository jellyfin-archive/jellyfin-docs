# Installing

The Jellyfin project and its contributors offer a number of pre-built binary packages to assist in getting Jellyfin up and running quickly on multiple systems.

## Containers

### Docker Hub

<a href="https://hub.docker.com/r/jellyfin/jellyfin"><img alt="Docker Pull Count" src="https://img.shields.io/docker/pulls/jellyfin/jellyfin.svg"></a>

The Jellyfin Docker image is available on [Docker Hub](https://hub.docker.com/r/jellyfin/jellyfin/) for multiple architectures.

1. Get the latest image:  
    `docker pull jellyfin/jellyfin`
2. Create directories on the host for persistent data storage:  
    `mkdir /path/to/config`  
    `mkdir /path/to/cache`
3. Start the server:  
    `docker run -d \`  
    `--volume /path/to/config:/config \`  
    `--volume /path/to/cache:/cache \`  
    `--volume /path/to/media:/media \`  
    `--net=host \`  
    `jellyfin/jellyfin`  
  
Alternatively, using docker-compose:  
```
version: "3"  
services:  
    jellyfin:  
      image: jellyfin/jellyfin  
      network_mode: "host"  
      volumes:  
        - /path/to/config:/config  
        - /path/to/cache:/cache  
        - /path/to/media:/media  
```

### Unraid Docker

An Unraid Docker template is available in the repository.

1. Open the unRaid GUI (at least unRaid 6.5) and click on the "Docker" tab.

1. Add the following line under "Template Repositories" and click "Save":  
    `https://github.com/jellyfin/jellyfin/blob/master/deployment/unraid/docker-templates`

1. Click "Add Container" and select "jellyfin".

1. Adjust any required paths and save.

### Kubernetes

A community project to deploy Jellyfin on Kubernetes-based platforms exists [at their repository](https://github.com/home-cluster/jellyfin-openshift). Any issues or feature requests related to deployment on Kubernetes-based platforms should be filed there.

## Portable Binaries

Portable binary packages containing a compiled Jellyfin instance are available for multiple platforms. For all portable binaries, extract the relevant archive to a directory and launch the binary (`jellyfin` on Linux/MacOS, `jellyfin.exe` on Windows).

### Windows (x64/x86)

Windows builds in ZIP archive format are available [here](https://repo.jellyfin.org/releases/server/windows).

### Install via script

1. Download and extract the latest version
1. Run `install.bat` or `install-jellyfin.ps1`
1. (optional) Enter a custom install location (default is `%appdata%`)
1. (optional) Enter a custom libary/data location (default is `%localappdata%`) - Currently not working
1. (optional) Select to install jellyfin as a service
1. (optional) Import old libary - Not compatible with newer Emby versions
1. (optional) Create a shortcut on your desktop
1. (optional) Run Jellyfin after installation
1. Press `Install`

### Manual installation

**Install**

1. Download and extract the latest version
1. Create a folder `jellyfin` at your preferred install location
1. Copy the extracted folder into the `jellyfin` folder and rename it to `system`
1. Create `jellyfin.bat` within your `jellyfin` folder containing:
    - To use the default libary/data location at `%localappdata%`:  
    `<--Your install path-->\jellyfin\system\jellyfin.exe`
    - To use a custom libary/data location (Path after the -d paramenter):  
    `<--Your install path-->\jellyfin\system\jellyfin.exe -d <--Your install path-->\jellyfin\data`
    - To use a custom libary/data location (Path after the -d paramenter) and disable the autostart of the webapp:  
    `<--Your install path-->\jellyfin\system\jellyfin.exe -d <--Your install path-->\jellyfin\data -noautorunwebapp`
1. Run `jellyfin.bat`
1. Open your browser at http://<--Server-IP-->:8096 (if autostart of webapp is disabled)


**Update**

1. Stop Jellyfin
1. Rename the Jellyfin `system` folder to `system-bak`
1. Download and extract the latest Jellyfin version
1. Copy the extracted folder into the `jellyfin` folder and rename it to `system`
1. Run `jellyfin.bat` to start the server again

**Rollback**

1. Stop Jellyfin
1. Delete the `system` folder
1. Rename `system-bak` to `system`
1. Run `jellyfin.bat` to start the server again

### MacOS

MacOS builds in TAR archive format are available [here](https://repo.jellyfin.org/releases/server/macos).

### Linux (generic amd64)

Generic amd64 Linux builds in TAR archive format are available [here](https://repo.jellyfin.org/releases/server/linux).

### Portable DLL

Platform-agnostic .NET Core DLL builds in TAR archive format are available [here](https://repo.jellyfin.org/releases/server/portable). These builds use the binary `jellyfin.dll` and must be loaded with `dotnet`.

## Arch

Jellyfin is not yet available in the official repository but can be found [here](https://aur.archlinux.org/packages/jellyfin-git/) in the user repository.

## Fedora

Fedora 29 builds in RPM package format are available [here](https://repo.jellyfin.org/releases/server/fedora) for now but an official Fedora repository is coming soon.

## CentOS

CentOS/RHEL 7 builds in RPM package format are available [here](https://repo.jellyfin.org/releases/server/centos) and an official CentOS/RHEL repository is planned for the future.

## Debian

### Repository

The Jellyfin team provides a Debian repository for installation on Debian Stretch/Buster. Supported architectures are `amd64`, `arm64`, and `armhf`.

**NOTE:** Microsoft does not provide a .NET for 32-bit x86 Linux systems, and hence Jellyfin is not supported on the `i386` architecture.

1. Install HTTPS transport for APT if you haven't already:  
    `sudo apt install apt-transport-https`

1. Import the GPG signing key (signed by the Jellyfin Team):  
    `wget -O - https://repo.jellyfin.org/debian/jellyfin_team.gpg.key | sudo apt-key add -`

1. Add a repository configuration at `/etc/apt/sources.list.d/jellyfin.list`:  
    `echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/debian $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list`

    **NOTE:** Supported releases are: `stretch` and `buster`.

1. Update APT repositories:  
    `sudo apt update`

1. Install Jellyfin:  
    `sudo apt install jellyfin`

1. Manage the Jellyfin system service with your tool of choice:  
    `sudo service jellyfin status`  
    `sudo systemctl restart jellyfin`  
    `sudo /etc/init.d/jellyfin stop`  

### Packages

Raw Debian packages, including old versions, are available [here](https://repo.jellyfin.org/releases/server/debian).

**Note:** The repository is the preferred way to obtain Jellyfin on Debian, as it contains several dependencies as well.

1. Download the desired `jellyfin` and `jellyfin-ffmpeg` `.deb` packages from the repository.

1. Install the downloaded `.deb` packages:  
    `sudo dpkg -i jellyfin_*.deb jellyfin-ffmpeg_*.deb`

1. Use `apt` to install any missing dependencies:  
    `sudo apt -f install`

1. Manage the Jellyfin system service with your tool of choice:  
    `sudo service jellyfin status`  
    `sudo systemctl restart jellyfin`  
    `sudo /etc/init.d/jellyfin stop`  

## Ubuntu

### Migrating to the new repository

Previous versions of Jellyfin included Ubuntu under the Debian repository. This has now been split out into its own repository to better handle the separate binary packages. If you encounter errors about the `ubuntu` release not being found and you previously configured an `ubuntu` `jellyfin.list` file, please follow these steps.

1. Remove the old `/etc/apt/sources.list.d/jellyfin.list` file:  
    `sudo rm /etc/apt/sources.list.d/jellyfin.list`

1. Proceed with the following section as written.

### Repository

The Jellyfin team provides an Ubuntu repository for installation on Ubuntu Xenial/Bionic/Cosmic/Disco. Supported architectures are `amd64`, `arm64`, and `armhf`. Only `amd64` is supported on Ubuntu Xenial.

**NOTE:** Microsoft does not provide a .NET for 32-bit x86 Linux systems, and hence Jellyfin is not supported on the `i386` architecture.

1. Install HTTPS transport for APT if you haven't already:  
    `sudo apt install apt-transport-https`

1. Enable the Universe repository to obtain all the FFMpeg dependencies:  
    `sudo add-apt-repository universe`

1. Import the GPG signing key (signed by the Jellyfin Team):  
    `wget -O - https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | sudo apt-key add -`

1. Add a repository configuration at `/etc/apt/sources.list.d/jellyfin.list`:  
    `echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list`

    **NOTE:** Supported releases are: `xenial`, `bionic`, `cosmic`, and `disco`.

1. Update APT repositories:  
    `sudo apt update`

1. Install Jellyfin:  
    `sudo apt install jellyfin`

1. Manage the Jellyfin system service with your tool of choice:  
    `sudo service jellyfin status`  
    `sudo systemctl restart jellyfin`  
    `sudo /etc/init.d/jellyfin stop`  

### Packages

Raw Ubuntu packages, including old versions, are available [here](https://repo.jellyfin.org/releases/server/ubuntu).

**Note:** The repository is the preferred way to obtain Jellyfin on Ubuntu, as it contains several dependencies as well.

1. Enable the Universe repository to obtain all the FFMpeg dependencies, and update repositories:  
    `sudo add-apt-repository universe`  
    `sudo apt update`

1. Download the desired `jellyfin` and `jellyfin-ffmpeg` `.deb` packages from the repository.

1. Install the required dependencies:  
    `sudo apt install at libsqlite3-0 libfontconfig1 libfreetype6 libssl1.0.0`

1. Install the downloaded `.deb` packages:  
    `sudo dpkg -i jellyfin_*.deb jellyfin-ffmpeg_*.deb`

1. Use `apt` to install any missing dependencies:  
    `sudo apt -f install`

1. Manage the Jellyfin system service with your tool of choice:  
    `sudo service jellyfin status`  
    `sudo systemctl restart jellyfin`  
    `sudo /etc/init.d/jellyfin stop`  
