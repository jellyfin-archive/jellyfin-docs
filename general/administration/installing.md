---
uid: admin-installing
title: Installing Jellyfin
---
<!-- markdownlint-disable MD036 no-emphasis-as-heading -->

# Installing <!-- omit in toc -->

The Jellyfin project and its contributors offer a number of pre-built binary packages to assist in getting Jellyfin up and running quickly on multiple systems.

- [Containers](#containers)
  - [Official Docker Hub](#official-docker-hub)
    - [Installing Docker](#installing-docker)
    - [Preparing the Folders](#preparing-the-folders)
    - [Running the Container](#running-the-container)
    - [Hardware Transcoding with Nvidia (Ubuntu)](#hardware-transcoding-with-nvidia-ubuntu)
  - [Docker Hub image maintained by LinuxServer.io](#docker-hub-image-maintained-by-linuxserverio)
  - [Unraid Docker](#unraid-docker)
  - [Kubernetes](#kubernetes)
  - [Podman](#podman)
- [Windows (x86/x64)](#windows-x86x64)
  - [Install using Installer (x64)](#install-using-installer-x64)
  - [Manual Installation (x86/x64)](#manual-installation-x86x64)
- [MacOS](#macos)
- [Linux](#linux)
  - [Linux (generic amd64)](#linux-generic-amd64)
    - [Installation Process](#installation-process)
  - [Portable DLL](#portable-dll)
  - [Arch Linux](#arch-linux)
  - [Fedora](#fedora)
  - [CentOS](#centos)
  - [Debian](#debian)
    - [Repository](#repository)
    - [Packages](#packages)
  - [Ubuntu](#ubuntu)
    - [Migrating to the new repository](#migrating-to-the-new-repository)
    - [Ubuntu Repository](#ubuntu-repository)
    - [Ubuntu Packages](#ubuntu-packages)

## Containers

[Open Container Initiative](https://stackoverflow.com/questions/31213126/libcontainer-vs-docker-vs-ocf-vs-runc#31219102) is a form of virtualization. An image is similar to an ISO while a container is akin to a running VM.

> [!Note]
> There is currently an [issue](https://github.com/docker/for-linux/issues/788) with read-only mounts in Docker. If there are submounts within the main mount, the submounts are read-write capable.

> [!Note]
> Use host mode for networking in order to use DLNA or an HDHomeRun.

### Official Docker Hub

<a href="https://hub.docker.com/r/jellyfin/jellyfin"><img alt="Docker Pull Count" src="https://img.shields.io/docker/pulls/jellyfin/jellyfin.svg"></a>

The Jellyfin Docker image is available on [Docker Hub](https://hub.docker.com/r/jellyfin/jellyfin/) for multiple architectures.

#### Installing Docker

There are multiple platforms that Docker can run on. Below are guides for Ubuntu, Windows and MacOS

**Ubuntu**

Lets start with Ubuntu, to install the basic Docker Daemon you will need to run the following 2 commands:

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

And to install Docker Compose you will need to run the following command:

```sh
apt-get install docker-compose
```

Now test the installation by running the following command in your terminal:

```sh
sudo docker run hello-world
```

You should see a message that states:

```sh
Hello from Docker! This message shows that your installation appears to be working correctly.
```

**Windows/MacOS**

For windows and MacOS you can use the following link to install Docker for Desktop:

<https://www.docker.com/products/docker-desktop>

Now test the installation by running the following command in your terminal(MacOS) or Powershell(Windows):

```sh
docker run hello-world
```

You should see a message that states:

```sh
Hello from Docker! This message shows that your installation appears to be working correctly.
```

#### Preparing the Folders

Before running the Jellyfin Container. We need to make 3 folders:

- Config
- Cache
- Media

**Ubuntu/Mac**

```sh
mkdir -p Path/To/Config
mkdir -p Path/To/Cache
mkdir -p Path/To/Media
```

**Windows**
Make a folder called Jellyfin, and create the 3 folders inside the Jellyfin Folder.

These folders will be used by Jellyfin to store data in. By default everything inside a Docker container gets removed once you delete the container. By making these folders you are able to delete the Jellyfin container while keeping your data. Amazing!

#### Running the Container

1. Get the latest image.

    ```sh
    docker pull jellyfin/jellyfin
    ```

2. Start the server in one of the following ways

    **Docker**

    Running a Container is very easy (as you might have noticed while running the Hello world! Container). However when running a service you'll need to add some options to your docker run Command. Below is the full command and then it will be explained what the different parts mean.

    ```sh
    docker run -d \
     --volume /path/to/config:/config \
     --volume /path/to/cache:/cache \
     --volume /path/to/media:/media \
     --user 1000:1000 \
     --net=host \
     --restart=unless-stopped \
     jellyfin/jellyfin
    ```

    - `-d`: This means that the Docker Container will run in the background. This can also be changed to -it this will make the container interactive allowing you to execute commands directly inside the container.

    - `--volume` /path/to/config:/config: This option connects the "/path/to/config" folder on your Host to the "/config" inside the container. You do not need to have any config present in /path/to/config as during the run command of the container Jellyfin will generate all of the necessary files. Everything in front of the colon is the of the config folder you've created in the previous step.

    - `--volume` /path/to/cache:/cache: This option connects the "/path/to/cache" folder on your Host to the "/cache" inside the container.

    - `--volume` /path/to/media:/media: This option connects the "/path/to/media" folder on your Host to the "/media" inside the container. This option has to be added in order for Jellyfin to find your media files. It is also possible that you have your media files spread across different places. In that case you can keep adding more volumes by using:

    - `--volume` /path/to/anothermedia:/media2 & --volume /path/to/differentmedia:/media3 etc. add as many as you like!

    - `--user 1000:1000`: Is option for Ubuntu to specify that you want to run the Container as the current user. This command is not necessary if you are using Docker for Desktop

    - `--net=host`: This option will tell the container to use the same network as the computer that it is running on. This means that if you have this running on your windows machine, you will be able to access jellyfin by using <http://localhost:8096> instead of a different IP

    - Alternatively you can use different options for the `--restart=unless-stopped` if you do not want the Jellyfin server to start whenever Docker starts. The following options are available:

      - `--restart=no` Do not automaticallu restart the container

      - `--restart=on-failure` Restart the container if it exits due to an error

      - `--restart=always` Always restart the container when it stops
  
    - `jellyfin/jellyfin`: This specifies what "image" to use to start the container with.

    **Docker-Compose**

    Create a `docker-compose.yml` file with the following contents:

    ```yml
    version: "3"
    services:
      jellyfin:
        image: jellyfin/jellyfin
        user: 1000:1000
        network_mode: "host"
        volumes:
          - /path/to/config:/config
          - /path/to/cache:/cache
          - /path/to/media:/media
    ```

    Then while in the same folder as the `docker-compose.yml` run:

    ```sh
    docker-compose up
    ```

#### Hardware Transcoding with Nvidia (Ubuntu)

You are able to use hardware encoding with Nvidia, but it requires some additional configuration. These steps require basic knowledge of Ubuntu but nothing too special.

**Adding Package Repositories**
First off you'll need to add the Nvidia package repositories to your Ubuntu installation. This can be done by running the following commands:

```sh
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```

**Installing Nvidia container toolkit**
Next we'll need to install the Nvidia container toolkit. This can be done by running the following commands:

```sh
sudo apt-get update -y
sudo apt-get install nvidia-container-toolkit -y
```

After installing the Nvidia Container Toolkit, you'll need to restart the Docker Daemon in order to let Docker use your Nvidia GPU:

```sh
sudo systemctl restart docker
```

**Changing the `docker-compose.yml`**
Now that all the packages are in order, let's change the `docker-compose.yml` to let the Jellyfin container make user of the Nvidia GPU.
The following lines need to be added to the file:

```sh
runtime: nvidia
environment:
- NVIDIA_VISIBLE_DEVICES=all
```

Your completed `docker-compose.yml` file should look something like this:

```yml
version: "2.3"
services:
  jellyfin-test:
    image: jellyfin/jellyfin
    user: 1000:1000
    network_mode: "host"
    runtime: nvidia
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
    volumes:
      - /path/to/config:/config
      - /path/to/cache:/cache
      - /path/to/media:/media
```

> [!Note]
> For Nvidia Hardware encoding the minimum version of docker-compose needs to be 2. However we recommend sticking with version 2.3 as it has proven to work with nvenc encoding.

### Docker Hub image maintained by LinuxServer.io

<a href="https://hub.docker.com/r/linuxserver/jellyfin"><img alt="Docker Pull Count" src="https://img.shields.io/docker/pulls/linuxserver/jellyfin.svg"></a>

The intent of the Jellyfin image is to provide the capability of building from source using Docker. The native image is [compiled](https://github.com/jellyfin/jellyfin/blob/master/Dockerfile) inside the container whereas the LinuxServer image [installs](https://github.com/linuxserver/docker-jellyfin/blob/master/Dockerfile) Jellyfin as a package. This can lead to larger image size and more space consumption since there isn't a common base image for the official Jellyfin image, [Jellyfin](https://hub.docker.com/r/jellyfin/jellyfin/tags) vs [LinuxServer](https://hub.docker.com/r/linuxserver/jellyfin/tags) sizes. The Jellyfin image does not support environmentals except for $TZ. No other environmental parameter works. If switching between images, the folder locations are not the same, so you have to move config folders around before spinning up the alternative image.

For ARM hardware and RPi, it is recommended to use the LinuxServer image since hardware acceleration support is not yet available on the native image.

### Unraid Docker

An Unraid Docker template is available in the repository.

1. Open the unRaid GUI (at least unRaid 6.5) and click on the "Docker" tab.

2. Add the following line under "Template Repositories" and save the options.

    ```data
    https://github.com/jellyfin/jellyfin/blob/master/deployment/unraid/docker-templates
    ```

3. Click "Add Container" and select "jellyfin".

4. Adjust any required paths and save your changes.

### Kubernetes

A community project to deploy Jellyfin on Kubernetes-based platforms exists [at their repository](https://github.com/home-cluster/jellyfin-openshift). Any issues or feature requests related to deployment on Kubernetes-based platforms should be filed there.

### Podman

[Podman](https://podman.io/) allows you to run containers as non-root. It's also the offically supported container solution on RHEL and CentOS.

Steps to run Jellyfin using Podman are almost identical to Docker steps:

1. Download the latest container image:

   ```sh
   podman pull jellyfin/jellyfin
   ```

2. Create directories on the host for persistent data storage:

   ```sh
   mkdir /path/to/config
   mkdir /path/to/cache
   ```

3. Run jellyfin:

   ```sh
   podman run \
   --cgroup-manager=systemd \
   --privileged \
   --volume /path/to/config:/config \
   --volume /path/to/cache:/cache \
   --volume /path/to/media:/media \
   --net=host \
   jellyfin/jellyfin
   ```

Note that Podman doesn't require root access and it's recommended to run the Jellyfin container as a separate non-root user for security.

If SELinux is enabled you need to use either `--privileged` or supply `z` volume option to allow Jellyfin to access the volumes.

To mount your media library read-only append ':ro' to the media volume:

```sh
--volume /path/to/media:/media:ro
```

To run as a systemd service see [Running containers with Podman and shareable systemd services](https://www.redhat.com/sysadmin/podman-shareable-systemd-services).

## Windows (x86/x64)

Windows installers and builds in ZIP archive format are available [here](https://jellyfin.org/downloads/#windows).

> [!WARNING]
> If you installed a version prior to 10.4.0 using a PowerShell script, you will need to manually remove the service using the command `nssm remove Jellyfin` and uninstall the server by remove all the files manually. Also one might need to move the data files to the correct location, or point the installer at the old location.

> [!WARNING]
> The 32-bit or x86 version is not recommended. `ffmpeg` and its video encoders generally perform better as a 64-bit executable due to the extra registers provided. This means that the 32-bit version of Jellyfin is deprecated.

### Install using Installer (x64)

**Install**

1. Download the latest version.
2. Run the installer.
3. (Optional) When installing as a service, pick the service account type.
4. If everything was completed successfully, the Jellyfin service is now running.
5. Open your browser at <http://localhost:8096> to finish setting up Jellyfin.

**Update**

1. Download the latest version.
2. Run the installer.
3. If everything was completed successfully, the Jellyfin service is now running as the new version.

**Uninstall**

1. Go to `Add or remove programs` in Windows.
2. Search for Jellyfin.
3. Click Uninstall.

### Manual Installation (x86/x64)

**Install**

1. Download and extract the latest version.
1. Create a folder `jellyfin` at your preferred install location.
1. Copy the extracted folder into the `jellyfin` folder and rename it to `system`.
1. Create `jellyfin.bat` within your `jellyfin` folder containing:
    - To use the default library/data location at `%localappdata%`:

    ```cmd
    <--Your install path-->\jellyfin\system\jellyfin.exe
    ```

    - To use a custom library/data location (Path after the -d parameter):

    ```cmd
    <--Your install path-->\jellyfin\system\jellyfin.exe -d <--Your install path-->\jellyfin\data
    ```

    - To use a custom library/data location (Path after the -d parameter) and disable the auto-start of the webapp:

    ```cmd
    <--Your install path-->\jellyfin\system\jellyfin.exe -d <--Your install path-->\jellyfin\data -noautorunwebapp
    ```

1. Run

    ```cmd
    jellyfin.bat
    ```

1. Open your browser at `http://<--Server-IP-->:8096` (if auto-start of webapp is disabled)

**Update**

1. Stop Jellyfin
2. Rename the Jellyfin `system` folder to `system-bak`
3. Download and extract the latest Jellyfin version
4. Copy the extracted folder into the `jellyfin` folder and rename it to `system`
5. Run `jellyfin.bat` to start the server again

**Rollback**

1. Stop Jellyfin.
2. Delete the `system` folder.
3. Rename `system-bak` to `system`.
4. Run `jellyfin.bat` to start the server again.

## MacOS

MacOS Application packages and builds in TAR archive format are available [here](https://jellyfin.org/downloads/#macos).

**Install**

1. Download the latest version.
2. Drag the `.app` package into the Applications folder.
3. Start the application.
4. Open your browser at `http://127.0.0.1:8096`.

**Upgrade**

1. Download the latest version.
2. Stop the currently running server either via the dashboard or using the application icon.
3. Drag the new `.app` package into the Applications folder and click yes to replace the files.
4. Start the application.
5. Open your browser at `http://127.0.0.1:8096`.

**Uninstall**

1. Stop the currently running server either via the dashboard or using the application icon.
2. Move the `.app` package to the trash.

**Deleting Configuation**

This will delete all settings and user information. This applies for the .app package and the portable version.

1. Delete the folder `~/.config/jellyfin/`
2. Delete the folder `~/.local/share/jellyfin/`

**Portable Version**

1. Download the latest version
2. Extract it into the Applications folder
3. Open Terminal and type `cd` followed with a space then drag the jellyfin folder into the terminal.
4. Type `./jellyfin` to run jellyfin.
5. Open your browser at <http://localhost:8096>

Closing the terminal window will end Jellyfin. Running Jellyfin in screen or tmux can prevent this from happening.

**Upgrading the Portable Version**

1. Download the latest version.
1. Stop the currently running server either via the dashboard or using `CTRL+C` in the terminal window.
1. Extract the latest version into Applications
1. Open Terminal and type `cd` followed with a space then drag the jellyfin folder into the terminal.
1. Type `./jellyfin` to run jellyfin.
1. Open your browser at <http://localhost:8096>

**Uninstalling the Portable Version**

1. Stop the currently running server either via the dashboard or using `CTRL+C` in the terminal window.
1. Move `/Application/jellyfin-version` folder to the Trash. Replace version with the actual version number you are trying to delete.

**Using FFmpeg with the Portable Version**

The portable version doesn't come with FFmpeg by default. To install FFmpeg you can use homebrew or download the build from [Zeranoe](https://ffmpeg.zeranoe.com/builds/macos64/static/).

If using Zeranoe's build, extract it to the `/Applications/` folder.

Navigate to the Playback tab in the Dashboard and set the path to FFmpeg under FFmpeg Path.

## Linux

### Linux (generic amd64)

Generic amd64 Linux builds in TAR archive format are available [here](https://jellyfin.org/downloads/#linux).

#### Installation Process

Create a directory in `/opt` for jellyfin and its files, and enter that directory.

```sh
sudo mkdir /opt/jellyfin
cd /opt/jellyfin
```

Download the latest generic Linux build from the [release page](https://github.com/jellyfin/jellyfin/releases). The generic Linux build ends with "`linux-amd64.tar.gz`". The rest of these instructions assume version 10.4.3 is being installed (i.e. `jellyfin_10.4.3_linux-amd64.tar.gz`). Download the generic build, then extract the archive:

```sh
sudo wget https://github.com/jellyfin/jellyfin/releases/download/v10.4.3/jellyfin_10.4.3_linux-amd64.tar.gz
sudo tar xvzf jellyfin_10.4.3_linux-amd64.tar.gz
```

Create a symbolic link to the Jellyfin 10.4.3 directory. This allows an upgrade by repeating the above steps and enabling it by simply re-creating the symbolic link to the new version.

```sh
sudo ln -s jellyfin_10.4.3 jellyfin
```

Create four sub-directories for Jellyfin data.

```sh
sudo mkdir data cache config log
```

If you are running Debian or a derivative, you can also [download](https://repo.jellyfin.org/releases/server/debian/versions/jellyfin-ffmpeg/) and install an ffmpeg release built specifically for Jellyfin. Be sure to download the latest release that matches your OS (4.2.1-5 for Debian Stretch assumed below).

```sh
sudo wget https://repo.jellyfin.org/releases/server/debian/versions/jellyfin-ffmpeg/4.2.1-5/jellyfin-ffmpeg_4.2.1-5-stretch_amd64.deb
sudo dpkg --install jellyfin-ffmpeg_4.2.1-5-stretch_amd64.deb
```

If you run into any dependency errors, run this and it will install them and jellyfin-ffmpeg.

```sh
sudo apt install -f
```

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

Assuming you desire Jellyfin to run as a non-root user, `chmod` all files and directories to your normal login user and group. Also make the startup script above executable.

```sh
sudo chown -R user:group *
sudo chmod u+x jellyfin.sh
```

Finally you can run it. You will see lots of log information when run, this is normal. Setup is as usual in the web browser.

```sh
./jellyfin.sh
```

### Portable DLL

Platform-agnostic .NET Core DLL builds in TAR archive format are available [here](https://jellyfin.org/downloads/#portable). These builds use the binary `jellyfin.dll` and must be loaded with `dotnet`.

### Arch Linux

Jellyfin can be found in the AUR as [`jellyfin`](https://aur.archlinux.org/packages/jellyfin/) and [`jellyfin-git`](https://aur.archlinux.org/packages/jellyfin-git/).

### Fedora

Fedora 29 builds in RPM package format are available [here](https://jellyfin.org/downloads/#fedora) for now but an official Fedora repository is coming soon.

### CentOS

CentOS/RHEL 7 builds in RPM package format are available [here](https://jellyfin.org/downloads/#centos) and an official CentOS/RHEL repository is planned for the future.

The default CentOS/RHEL repositories don't carry FFmpeg, which the RPM requires. You will need to add a third-party repository which carries FFmpeg, such as [RPM Fusion's Free repository](https://rpmfusion.org/Configuration).

You can also build [Jellyfin's version](https://github.com/jellyfin/jellyfin-ffmpeg) on your own. This includes gathering the dependencies and compiling and installing them. Instructions can be found at [the FFmpeg wiki](https://trac.ffmpeg.org/wiki/CompilationGuide/Centos).

### Debian

#### Repository

The Jellyfin team provides a Debian repository for installation on Debian Stretch/Buster. Supported architectures are `amd64`, `arm64`, and `armhf`.

> [!NOTE]
> Microsoft does not provide a .NET for 32-bit x86 Linux systems, and hence Jellyfin is not supported on the `i386` architecture.

1. Install HTTPS transport for APT if you haven't already:

    ```sh
    sudo apt install apt-transport-https
    ```

1. Import the GPG signing key (signed by the Jellyfin Team):

    ```sh
    wget -O - https://repo.jellyfin.org/debian/jellyfin_team.gpg.key | sudo apt-key add -
    ```

1. Add a repository configuration at `/etc/apt/sources.list.d/jellyfin.list`:

    ```sh
    echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/debian $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list
    ```

    > [!NOTE]
    > Supported releases are `stretch` and `buster`.

1. Update APT repositories:

    ```sh
    sudo apt update
    ```

1. Install Jellyfin:

    ```sh
    sudo apt install jellyfin
    ```

1. Manage the Jellyfin system service with your tool of choice:

    ```sh
    sudo service jellyfin status
    sudo systemctl restart jellyfin
    sudo /etc/init.d/jellyfin stop
    ```

#### Packages

Raw Debian packages, including old versions, are available [here](https://jellyfin.org/downloads/#debian).

> [!NOTE]
> The repository is the preferred way to obtain Jellyfin on Debian, as it contains several dependencies as well.

1. Download the desired `jellyfin` and `jellyfin-ffmpeg` `.deb` packages from the repository.

1. Install the downloaded `.deb` packages:

    ```sh
    sudo dpkg -i jellyfin_*.deb jellyfin-ffmpeg_*.deb
    ```

1. Use `apt` to install any missing dependencies:

    ```sh
    sudo apt -f install
    ```

1. Manage the Jellyfin system service with your tool of choice:

    ```sh
    sudo service jellyfin status
    sudo systemctl restart jellyfin
    sudo /etc/init.d/jellyfin stop
    ```

### Ubuntu

#### Migrating to the new repository

Previous versions of Jellyfin included Ubuntu under the Debian repository. This has now been split out into its own repository to better handle the separate binary packages. If you encounter errors about the `ubuntu` release not being found and you previously configured an `ubuntu` `jellyfin.list` file, please follow these steps.

1. Remove the old `/etc/apt/sources.list.d/jellyfin.list` file:

    ```sh
    sudo rm /etc/apt/sources.list.d/jellyfin.list
    ```

1. Proceed with the following section as written.

#### Ubuntu Repository

The Jellyfin team provides an Ubuntu repository for installation on Ubuntu Xenial, Bionic, Cosmic, Disco, and Eoan. Supported architectures are `amd64`, `arm64`, and `armhf`. Only `amd64` is supported on Ubuntu Xenial.

> [!NOTE]
> Microsoft does not provide a .NET for 32-bit x86 Linux systems, and hence Jellyfin is not supported on the `i386` architecture.

1. Install HTTPS transport for APT if you haven't already:

    ```sh
    sudo apt install apt-transport-https
    ```

1. Enable the Universe repository to obtain all the FFMpeg dependencies:

    ```sh
    sudo add-apt-repository universe
    ```

1. Import the GPG signing key (signed by the Jellyfin Team):

    ```sh
    wget -O - https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | sudo apt-key add -
    ```

1. Add a repository configuration at `/etc/apt/sources.list.d/jellyfin.list`:

    ```sh
    echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list
    ```

    > [!NOTE]
    > Supported releases are `xenial`, `bionic`, `cosmic`, `disco`, and `eoan`.

1. Update APT repositories:

    ```sh
    sudo apt update
    ```

1. Install Jellyfin:

    ```sh
    sudo apt install jellyfin
    ```

1. Manage the Jellyfin system service with your tool of choice:

    ```sh
    sudo service jellyfin status
    sudo systemctl restart jellyfin
    sudo /etc/init.d/jellyfin stop
    ```

#### Ubuntu Packages

Raw Ubuntu packages, including old versions, are available [here](https://jellyfin.org/downloads/#ubuntu).

> [!NOTE]
> The repository is the preferred way to install Jellyfin on Ubuntu, as it contains several dependencies as well.

1. Enable the Universe repository to obtain all the FFMpeg dependencies, and update repositories:

    ```sh
    sudo add-apt-repository universe
    sudo apt update
    ```

1. Download the desired `jellyfin` and `jellyfin-ffmpeg` `.deb` packages from the repository.

1. Install the required dependencies:

    ```sh
    sudo apt install at libsqlite3-0 libfontconfig1 libfreetype6 libssl1.0.0
    ```

1. Install the downloaded `.deb` packages:

    ```sh
    sudo dpkg -i jellyfin_*.deb jellyfin-ffmpeg_*.deb
    ```

1. Use `apt` to install any missing dependencies:

    ```sh
    sudo apt -f install
    ```

1. Manage the Jellyfin system service with your tool of choice:

    ```sh
    sudo service jellyfin status
    sudo systemctl restart jellyfin
    sudo /etc/init.d/jellyfin stop
    ```
