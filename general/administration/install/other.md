---
uid: admin-install-other
title: Installing on other Platforms
---

# Installing on other Platforms

## Portable DLL

Platform-agnostic .NET Core DLL builds in TAR archive format are available [here](https://jellyfin.org/downloads/#portable).
These builds use the binary `jellyfin.dll` and must be loaded with `dotnet`.

## Arch Linux

Jellyfin can be found in the AUR as [`jellyfin`](https://aur.archlinux.org/packages/jellyfin/), [`jellyfin-bin`](https://aur.archlinux.org/packages/jellyfin-bin/) and [`jellyfin-git`](https://aur.archlinux.org/packages/jellyfin-git/).

Jellyfin-FFmpeg is available as [`jellyfin-ffmpeg`](https://aur.archlinux.org/packages/jellyfin-ffmpeg) in the AUR too.

## Fedora

Fedora builds in RPM package format are available [here](https://jellyfin.org/downloads/#fedora) for now but an official Fedora repository is coming soon.

1. You will need to enable rpmfusion as ffmpeg is a dependency of the jellyfin server package

    ```sh
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    ```

    > [!NOTE]
    > You do not need to manually install ffmpeg, it will be installed by the jellyfin server package as a dependency

2. Install the jellyfin server

    ```sh
    sudo dnf install (link to version jellyfin server you want to install)
    ```

3. Install the jellyfin web interface

    ```sh
    sudo dnf install (link to web RPM you want to install)
    ```

4. Enable jellyfin service with systemd

    ```sh
    sudo systemctl start jellyfin
    ```

    ```sh
    sudo systemctl enable jellyfin
    ```

5. Open jellyfin service with firewalld

    ```sh
    sudo firewall-cmd --permanent --add-service=jellyfin
    ```

    > [!NOTE]
    > This will open the following ports
    > 8096 TCP used by default for HTTP traffic, you can change this in the dashboard
    > 8920 TCP used by default for HTTPS traffic, you can change this in the dashboard
    > 1900 UDP used for service auto-discovery, this is not configurable
    > 7359 UDP used for auto-discovery, this is not configurable

6. Reboot your machine

    ```sh
    sudo systemctl reboot
    ```

7. Go to `localhost:8096` or `ip-address-of-jellyfin-server:8096` to finish setup in the web UI

## CentOS

CentOS/RHEL 7 builds in RPM package format are available [here](https://jellyfin.org/downloads/#centos) and an official CentOS/RHEL repository is planned for the future.

The default CentOS/RHEL repositories don't provide FFmpeg, which the RPM requires. You will need to add a third-party repository which provide FFmpeg, such as [RPM Fusion's Free repository](https://rpmfusion.org/Configuration).

You can also build [Jellyfin's version](https://github.com/jellyfin/jellyfin-ffmpeg) on your own. This includes gathering the dependencies and compiling and installing them. Instructions can be found at [the FFmpeg wiki](https://trac.ffmpeg.org/wiki/CompilationGuide/Centos).

## Cloudron

Cloudron is a complete solution for running apps on your server and keeping them up-to-date and secure.
On your Cloudron you can install Jellyfin with a few clicks via the [app library](https://cloudron.io/store/org.jellyfin.cloudronapp.html) and updates are delivered automatically.

The source code for the package can be found [here](https://git.cloudron.io/cloudron/jellyfin-app).
Any issues or feature requests related to deployment on Cloudron should be filed there.
