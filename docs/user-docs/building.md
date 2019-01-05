
[//]: # (TODO: Convert this page into links to project specific build instructions)

# Building Jellyfin from Source

As an alternative to using [binary packages](/user-docs/installing), you can build Jellyfin from source.

Jellyfin supports several methods of building for different platforms and instructions for all supported platforms are below.

All package builds begin with the first two steps (for Linux/OSX; alter as needed for Windows):

1. Clone the repository:  
    `git clone https://github.com/jellyfin/jellyfin.git`  
    `cd jellyfin`

2. Initialize the submodules:  
    `git submodule update --init`

## Docker

3. Build the Docker image:  
    `docker build -t $USERNAME/jellyfin .`

4. Run the container:  
    `docker run -d -p 8096:8096 $USERNAME/jellyfin`

## Debian Packages via Docker

3. Run the build script:  
    `./build-deb.sh`

4. Resulting packages will be in `../jellyfin*.deb`

## Debian Packages via `dpkg-dev`

3. Add the Microsoft .NET Core repository:       
    `sudo apt-get install -y apt-transport-https debhelper gnupg wget devscripts equivs`  
    `wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg`  
    `wget -qO- https://packages.microsoft.com/config/debian/9/prod.list | sudo tee /etc/apt/sources.list.d/microsoft-prod.list`  
    `sudo apt-get update`  

4. Install build dependencies:  
    `sudo mk-build-deps -i`

5. Build the packages:  
    `dpkg-buildpackage -us -uc`

6. Resulting packages will be in  `../jellyfin*.deb`

## Windows (64 bit)

3. Install the dotnet core SDK 2.2 from [Microsoft's Webpage](https://dotnet.microsoft.com/download/dotnet-core/2.2) and [install Git for Windows](https://gitforwindows.org/)

4. Set `executionpolicy` to unrestricted.

5. Run the Jellyfin build script:  
    `build-jellyfin.ps1`

    * The `-WindowsVersion` and `-Architecture` flags can optimize the build for your current environment; the default is generic Windows x64.

    * The `-InstallLocation` flag lets you select where the compiled binaries go; the default is `$Env:AppData\Jellyfin-Server\` .

    * The `-InstallFFMPEG` flag will automatically pull the stable `ffmpeg` binaries appropriate to your architecture (x86/x64 only for now) from [Zeranoe](https://ffmpeg.zeranoe.com/builds/) and place them in your Jellyfin directory.

6. (Optional) Use [NSSM](https://nssm.cc/) to configure Jellyfin to run as a service

7. Jellyfin is now available in the default directory (or the directory you chose). Assuming you kept the default directory:

    * To start it from a Powershell window, run:  
        `&"$env:APPDATA\Jellyfin-Server\jellyfin.exe"`

    * To start it from CMD, run:  
        `%APPDATA%\Jellyfin-Server\jellyfin.exe`
