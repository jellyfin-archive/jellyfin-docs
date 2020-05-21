---
uid: admin-building
title: Building from Source
---
<!-- markdownlint-disable MD029 ol-prefix -->

# Source

As an alternative to using [binary packages](xref:admin-installing), you can build Jellyfin from source.

Jellyfin supports several methods of building for different platforms and instructions for all supported platforms are below.

All package builds begin with these two steps:

1. Clone the repository:

    ```sh
    git clone https://github.com/jellyfin/jellyfin.git
    cd jellyfin
    ```

2. Initialize the submodules:

    ```sh
    git submodule update --init
    ```

## Container image

1. Build the container image using Docker or Podman:

    ```sh
    docker build -t $USERNAME/jellyfin .
    ```

    or

    ```sh
    podman build -t $USERNAME/jellyfin .
    ```

2. Run Jellyfin in a new container using Docker or Podman from the built container image:

    ```sh
    docker run -d -p 8096:8096 $USERNAME/jellyfin
    ```

    or

    ```sh
    podman run -d -p 8096:8096 $USERNAME/jellyfin
    ```

## Linux or MacOS

3. Use the included `build` script to perform builds:

    ```sh
    ./build --help
    ./build --list-platforms
    ./build <platform> all
    ```

4. The resulting archives can be found at `../bin/<platform>`

> [!NOTE]
> This will very likely be split out into a separate repository at some point in the future.

## Windows

3. Install the dotnet core SDK 3.1 from [Microsoft's Website](https://dotnet.microsoft.com/download/dotnet-core/3.1) and [install Git for Windows](https://gitforwindows.org/). You must be on Powershell 3 or higher.

4. From Powershell set the execution policy to unrestricted:

    ```powershell
    set-executionpolicy unrestricted
    ```

5. Run the Jellyfin build script:

    ```powershell
    deployment\windows\build-jellyfin.ps1 -verbose
    ```

    * The `-WindowsVersion` and `-Architecture` flags can optimize the build for your current environment; the default is generic Windows x64.

    * The `-InstallLocation` flag lets you select where the compiled binaries go; the default is `$Env:AppData\Jellyfin-Server\`.

    * The `-InstallFFMPEG` flag will automatically pull the stable `ffmpeg` binaries appropriate to your architecture (x86/x64 only for now) from [Zeranoe](https://ffmpeg.zeranoe.com/builds/) and place them in your Jellyfin directory.

    * The `-InstallNSSM` flag will automatically pull the stable `nssm` binary appropriate to your architecture (x86/x64 only for now) from [NSSM's Website](https://nssm.cc/) and place it in your Jellyfin directory.

6. (Optional) Use [NSSM](https://nssm.cc/) to configure Jellyfin to run as a service.

7. Jellyfin is now available in the default directory (or the directory you chose). Assuming you kept the default directory:

    * To start it from a Powershell window, run:

        ```powershell
        &"$env:APPDATA\Jellyfin-Server\jellyfin.exe"
        ```

    * To start it from CMD, run:

        ```cmd
        %APPDATA%\Jellyfin-Server\jellyfin.exe
        ```

> [!NOTE]
> This will very likely be split out into a separate repository at some point in the future.
