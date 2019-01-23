# Installing Jellyfin from Binary Packages

The Jellyfin project and its contributors offer a number of pre-built binary packages to assist in getting Jellyfin up and running quickly on multiple systems.

## Containers

### Docker Hub

<a href="https://hub.docker.com/r/jellyfin/jellyfin"><img alt="Docker Pull Count" src="https://img.shields.io/docker/pulls/jellyfin/jellyfin.svg"></a>

The Jellyfin Docker image is available on [Docker Hub](https://hub.docker.com/r/jellyfin/jellyfin/).

### Unraid Docker

An Unraid Docker template is available in the repository.

1. Open the unRaid GUI (at least unRaid 6.5) and click on the "Docker" tab.

1. Add the following line under "Template Repositories" and click "Save":  
    `https://github.com/jellyfin/jellyfin/blob/master/unRaid/docker-templates`

1. Click "Add Container" and select "jellyfin".

1. Adjust any required paths and save.

### Kubernetes

A community project to deploy Jellyfin on Kubernetes-based platforms exists at `https://github.com/home-cluster/jellyfin-openshift`.
Any issues or feature requests related to deployment on Kubernetes-based platforms should be filed there.

## Portable Binaries

Portable binary packages containing a compiled Jellyfin instance are available for multiple platforms.

### Windows (x64/x86)

Windows builds in ZIP archive format are available [here](https://repo.jellyfin.org/releases/server/windows).

### MacOS

MacOS builds in TAR archive format are available [here](https://repo.jellyfin.org/releases/server/macos).

### Linux (generic amd64)

Generic amd64 Linux builds in TAR archive format are available [here](https://repo.jellyfin.org/releases/server/linux).

### Portable DLL

Platform-agnostic .NET Core DLL builds in TAR archive format are available [here](https://repo.jellyfin.org/releases/server/portable). These builds use the binary `jellyfin.dll` and must be loaded with `dotnet`.

## Arch AUR

The Jellyfin package is in the AUR avilable [here](https://aur.archlinux.org/packages/jellyfin-git/).

## Debian / Ubuntu

### Repository

The Jellyfin team provides a Debian repository for installation on Debian and Ubuntu machines.

**NOTE:** Ubuntu users may find that the ffmpeg dependency package is not present in their release or is simply a rebranded `libav` which is not directly compatible. Please obtain the `ffmpeg` package directly from [their repository](https://ffmpeg.org/) to use Jellyfin on Ubuntu.

1. Import the GPG signing key (signed by the Jellyfin Team):  
    `wget -O - https://repo.jellyfin.org/debian/jellyfin_team.gpg.key | sudo apt-key add -`

    **NOTE:** If you still use the old key signed by Joshua from the initial releases, you can remove it after installing the new one:  
        `sudo apt-key remove 99FD1406`

1. Add a repository configuration at `/etc/apt/sources.list.d/jellyfin.list`, changing `<release>` to match your system:  
    `echo "deb https://repo.jellyfin.org/debian <release> main" | sudo tee /etc/apt/sources.list.d/jellyfin.list`

    **NOTE:** Valid releases are: `jessie`, `stretch`, `buster`, and `ubuntu`. Ubuntu does not yet have different version releases.

    **NOTE:** Ensure you have the `apt-transport-https` package installed, as the Jellyfin repository supports only HTTPS:  
        `sudo apt install apt-transport-https`

1. Update APT repositories:  
    `sudo apt update`

1. Install Jellyfin:  
    `sudo apt install jellyfin`

When installed via Debian packages, Jellyfin is started as a service under either `systemd`, `upstart`, or `init`. To check on its status, use:  
`sudo service jellyfin status`

To restart the daemon, use:  
`sudo service jellyfin restart`

### Packages

Raw Debian packages, compatible with Debian 8+ or Ubuntu 14.04+, are available [here](https://repo.jellyfin.org/releases/server/debian).

**NOTE:** When installing packages with `dpkg -i`, it won't attempt to resolve dependencies for you. Ensure you have `ffmpeg` installed already, or use `apt -f install` after attempting the `dpkg -i` to resolve and install the required dependencies.

When installed via Debian packages, Jellyfin is started as a service under either `systemd`, `upstart`, or `init`. To check on its status, use:  
`sudo service jellyfin status`

To restart the daemon, use:  
`sudo service jellyfin restart`
