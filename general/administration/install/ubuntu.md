---
uid: admin-install-ubuntu
title: Installing on Ubuntu
---

# Installing on Ubuntu

## Repository

The Jellyfin team provides an Ubuntu repository for installation on Ubuntu Bionic, Focal, Impish and Jammy.
Supported architectures are `amd64`, `arm64`, and `armhf`.

> [!NOTE]
> Microsoft does not provide a .NET for 32-bit x86 Linux systems, and hence Jellyfin is **not** supported on the `i386` architecture.

1. Install `curl`, `gnupg` and `lsb-release` if you haven't already.

    ```sh
    sudo apt install curl gnupg lsb-release
    ```

2. Import the GPG signing key (signed by the Jellyfin Team):

    ```sh
    curl -fsSL https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | gpg --dearmor -o /etc/apt/trusted.gpg.d/jellyfin.gpg
    ```

3. Add a repository configuration at `/etc/apt/sources.list.d/jellyfin.list`:

    ```sh
    echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list
    ```

    > [!NOTE]
    > Officially supported releases are `bionic`, `focal`, `impish` and `jammy`.

4. Update APT repositories:

    ```sh
    sudo apt update
    ```

5. Install Jellyfin:

    ```sh
    sudo apt install jellyfin
    ```

6. Check/Manage the Jellyfin system service:

    ```sh
    sudo systemctl status jellyfin
    ```

## Packages

Raw Ubuntu packages, including old versions, are available [here](https://repo.jellyfin.org/releases/server/ubuntu/versions/).

> [!NOTE]
> The repository is the preferred way to install Jellyfin on Ubuntu.

1. Download the desired `jellyfin-server`, `jellyfin-web` and `jellyfin-ffmpeg` `.deb` packages from the repository.

2. Install the downloaded `.deb` packages:

    ```sh
    sudo dpkg -i jellyfin-server_*.deb jellyfin-web_*.deb jellyfin-ffmpeg_*.deb
    ```

3. Use `apt` to install any missing dependencies:

    ```sh
    sudo apt -f install
    ```

4. Check/Manage the Jellyfin system service:

    ```sh
    sudo systemctl status jellyfin
    ```
