---
uid: admin-hardware-acceleration
title: Hardware Acceleration
---

# Hardware Acceleration

Jellyfin supports [hardware acceleration (HWA) of video encoding/decoding using FFMpeg](https://trac.ffmpeg.org/wiki/HWAccelIntro). FFMpeg and Jellyfin can support multiple hardware acceleration implementations such as Intel Quicksync (QSV), AMD AMF, nVidia NVENC/NVDEC, OpenMax OMX and MediaCodec through Video Acceleration API's.

[VA-API](https://en.wikipedia.org/wiki/Video_Acceleration_API) is a Video Acceleration API that uses [libva](https://github.com/intel/libva/blob/master/README.md) to interface with local drivers to provide HWA. [QSV](https://trac.ffmpeg.org/wiki/Hardware/QuickSync) uses a modified (forked) version of VA-API and interfaces it with [libmfx](https://github.com/intel/media-driver/blob/master/README.md) and their proprietary drivers [(list of supported processors for QSV)](https://ark.intel.com/content/www/us/en/ark.html#@Processors).

OS      | Recommended HW Acceleration
------- | -------------
Linux   | QSV, NVENC, AMF, VA-API
Windows | QSV, NVENC, AMF
MacOS   | VideoToolbox
RPi     | V4L2, OMX (deprecated)

[Graphics Cards comparison using HWA](https://www.elpamsoft.com/?p=Plex-Hardware-Transcoding)

Based on hardware vendor:

Vendor  | Supported HW Acceleration
------- | -------------
NVIDIA  | NVENC
AMD     | AMF, VA-API
Intel   | QSV, VA-API
Apple   | VideoToolbox
RPi | V4L2, OMX (deprecated)

## Enabling Hardware Acceleration

Hardware acceleration options can be found in the Admin Dashboard under the **Transcoding** section of the **Playback** tab. Select a valid hardware acceleration option from the drop-down menu, indicate a device if applicable, and check `Enable hardware encoding` to enable encoding as well as decoding, if your hardware supports this.

The hardware acceleration is available immediately for media playback. No server restart is required.

On Linux you can check available GPU using:

```sh
lspci -nn | egrep -i "3d|display|vga"
```

or using `lshw`:

```sh
lshw -C display
```

## Tips on H.264 / AVC 10-bit videos

The hardware decoding of H.264 10-bit aka High10 profile video is not supported by any Intel, AMD or NVIDIA GPU.

Please consider upgrading these videos to HEVC 10-bit aka Main10 profile if you want to offload your CPU usage during transcoding.

## Tips for Intel Gen9 and Gen11+ when using VAAPI or QSV on Linux

The Intel [Guc/Huc firmware](https://01.org/linuxgraphics/downloads/firmware) must be enabled for optional Low-Power encoding (pre-Gen11 only supports LP H.264).

Instructions for ArchLinux: [Arch Wiki](https://wiki.archlinux.org/title/intel_graphics#Enable_GuC_/_HuC_firmware_loading) and for Debian/Ubuntu: [Brainiarc7's gist](https://gist.github.com/Brainiarc7/aa43570f512906e882ad6cdd835efe57)

For Jasper Lake chips (such as N5095 and N6005), Low-Power encoding must be enabled. But the linux-firmware support is not ready in Ubuntu 20.04.3 LTS. The 21.10 or newer distro is required.

## Supported Acceleration Methods

Since Jellyfin 10.8 release, the full hardware filtering (scale, de-interlacle, tone-mapping and subtitle burn-in) on Intel, AMD and NVIDIA have been verified with `jellyfin-ffmpeg` 4.4.1.

**Using the old or original version of FFmpeg binary may disable some hardware filtering improvements.**

### NVIDIA NVENC

**The minimum required driver version is: Linux: 455.28, Windows: 456.71 since Jellyfin 10.8 release.**

[NVIDIA using ffmpeg official list](https://developer.nvidia.com/ffmpeg). Not every card has been tested. These [drivers](https://github.com/keylase/nvidia-patch) are recommended for Linux and Windows. Here is the official list of [NVIDIA Graphics Cards](https://developer.nvidia.com/video-encode-decode-gpu-support-matrix) for supported codecs. Example of Ubuntu working with [NVENC](https://www.reddit.com/r/jellyfin/comments/amuyba/nvenc_nvdec_working_in_jellyfin_on_ubuntu_server/).

On Linux use `nvidia-smi` to check driver and GPU card version.

### VA-API

List of supported codecs for [VA-API](https://wiki.archlinux.org/index.php/Hardware_video_acceleration#Comparison_tables). Intel iGPU, AMD GPU.

> [!NOTE]
> AMD GPU requires open source driver Mesa 20.1 or higher to support hardware decoding HEVC.

> [!NOTE]
> As of 10.7.1, the Docker image uses Debian 10 and thus Mesa 18.3.6. To upgrade it, you'll need to make your own image based on a more recent distribution.

### AMD AMF

**Full OpenCL based hardware filtering in AMF is supported on Windows 10 or newer since Jellyfin 10.8 release.**

AMF is available on Windows and Linux.

However AMD has not implemented the Vulkan based HW decoder and scaler in ffmpeg, the decoding speed may not be as expected on Linux. The closed source driver `amdgpu-pro` is required when using AMF on Linux.

> [!NOTE]
> Most Zen CPUs do not come with integrated graphics. You will need a dedicated GPU (dGPU) or a Zen CPU with integrated graphics for hardware acceleration. If your Zen CPU is suffixed with a "G" or "GE" in model name, you have integrated graphics.

### Intel QuickSync

Intel QSV Benchmarks on [Linux](https://www.intel.com/content/www/us/en/architecture-and-technology/quick-sync-video/quick-sync-video-installation.html).

On Windows, you can use the DXVA2/D3D11VA libraries for decoding and the libmfx library for encoding.

> [!NOTE]
> To use QSV on Windows, please do not install Jellyfin as a system service.

Issues: [FFmpeg Windows version with QSV hwaccel fails over TERMINAL](https://trac.ffmpeg.org/ticket/7511) and [Intel QSV: "Failed to create Direct3D device" on Core i7-7700K (Skylake) on Windows 10](https://trac.ffmpeg.org/ticket/6827)

CentOS may require [additional drivers](https://www.getpagespeed.com/server-setup/how-to-enable-intel-hardware-acceleration-for-video-playback-in-rhel-centos-8) for QSV.

Here's [additional information](https://github.com/Artiume/jellyfin-docs/blob/master/general/wiki/main.md) to learn more.

If your Jellyfin server does not support hardware acceleration, but you have another machine that does, you can leverage [rffmpeg](https://github.com/joshuaboniface/rffmpeg) to delegate the transcoding to another machine. Currently Linux-only and requires SSH between the machines, as well as shared storage both for media and for the Jellyfin data directory.

## Common setup

Each hardware acceleration type, as well as each Jellyfin installation type, requires different setup options before it can be used. It is always best to consult [the FFMpeg documentation]((https://trac.ffmpeg.org/wiki/HWAccelIntro)) on the acceleration type you choose for the latest information.

### Acceleration on Docker

In order to use hardware acceleration in Docker, the devices must be passed to the container. To see what video devices are available, you can run `sudo lshw -c video` or `vainfo` on your machine. VA-API may require the `render` group added to the docker permissions. The `render` group id can be discovered in /etc/group such as `render:x:122:`.

You can use `docker run` to start the server with a command like the one below.

```sh
docker run -d \
 --volume /path/to/config:/config \
 --volume /path/to/cache:/cache \
 --volume /path/to/media:/media \
 --user 1000:1000 \
 --group-add=122 \
 --net=host \
 --restart=unless-stopped \
 --device /dev/dri/renderD128:/dev/dri/renderD128 \
 --device /dev/dri/card0:/dev/dri/card0 \
 jellyfin/jellyfin
```

Alternatively, you can use docker-compose with a configuration file so you don't need to run a long command every time you restart your server.

```yaml
version: "3"
services:
  jellyfin:
    image: jellyfin/jellyfin
    user: 1000:1000
    group_add:
      - 122
    network_mode: "host"
    volumes:
      - /path/to/config:/config
      - /path/to/cache:/cache
      - /path/to/media:/media
    devices:
      # VAAPI Devices
      - /dev/dri/renderD128:/dev/dri/renderD128
      - /dev/dri/card0:/dev/dri/card0
      # RPi 4
      - /dev/vchiq:/dev/vchiq
```

### Linux Docker NVIDIA NVENC

In order to achieve hardware acceleration using Docker, several steps are required.

Prerequisites:

[NVIDIA Container Toolkit installation](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#getting-started)

- GNU/Linux x86_64 with kernel version > 3.10
- Docker >= 19.03
- NVIDIA GPU with Architecture > Fermi (2.1)
- NVIDIA drivers >= 361.93

Follow the instructions in the link above to install the NVIDIA Container Toolkit for your Linux distribution.

Start your container adding these parameters:

```sh
-e NVIDIA_DRIVER_CAPABILITIES=all \
-e NVIDIA_VISIBLE_DEVICES=all \
--gpus all \
```

A complete run command would look like this:

```sh
docker run -d \
 --name=jellyfin \
 -e NVIDIA_DRIVER_CAPABILITIES=all \
 -e NVIDIA_VISIBLE_DEVICES=all \
 --gpus all \
 -p 8096:8096 \
 -p 8920:8920 \
 -v /config:/config \
 -v /media:/media \
 -v /cache:/cache \
 --restart unless-stopped \
 jellyfin/jellyfin
```

Or with docker-compose >1.28, add the `deploy` and `environment` parts to your Jellyfin service:

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin
  # ... your Jellyfin config
  environment:
    NVIDIA_DRIVER_CAPABILITIES: all
    NVIDIA_VISIBLE_DEVICES: all
  deploy:
    resources:
      reservations:
        devices:
        - capabilities: [gpu]
```

There are some special steps when running with the following option:

```sh
--user 1000:1000
```

You may need to add this user to the video group on your host machine:

```sh
usermod -aG video user
```

Once the container is started you can again validate access to the host resources:

```sh
docker exec -it jellyfin nvidia-smi
```

If you get driver information, everything is fine but if you get an error like `couldn't find libnvidia-ml.so library in your system` you need to run the following command:

```sh
docker exec -it jellyfin ldconfig
```

After that, you should ensure the NVIDIA driver loads correctly.

### Configuring OpenCL / CUDA / Intel VPP Tone-Mapping

Hardware based tone-mapping with NVIDIA NVENC, AMD AMF, Intel QSV and VA-API is through OpenCL or CUDA.

Intel hardware based VPP tone-mapping is supported on Intel QSV and VA-API on Linux. VPP is prefered when both two tone-mapping options are checked on Intel.

OS/Platform | NVIDIA NVENC | AMD AMF  | Intel QSV | Intel VA-API | AMD VA-API | Software
----------- | ------------ | -------- | ----------- | --------- | --------- | --------
Linux       | ✔️          | ✔️       | ✔️        | ✔️          | ✔️   | WIP
Windows     | ✔️           | ✔️       | ✔️        | N/A         | N/A       | WIP
Docker      | ✔️           | untested | ✔️        | ✔️          | untested   | WIP

> [!NOTE]
> Tone-mapping on Windows with Intel QSV and AMD AMF requires Windows 10 or newer.

> [!NOTE]
> Make sure the hardware acceleration is well configured before reading this section.

1. On Windows: Install the latest NVIDIA or AMD or Intel drivers.

2. On Linux or docker:
   - For AMD cards, install `amdgpu-pro` with opencl arguments. See **Configuring AMD AMF encoding on Ubuntu 18.04 or 20.04 LTS** for more details.

    ```sh
    sudo ./amdgpu-pro-install -y --opencl=pal,legacy
    sudo usermod -aG video $LOGNAME
    sudo usermod -aG render $LOGNAME
    ```

   - For Intel iGPUs, you have two types of tonemapping methods: OpenCL and VPP. Choose the latter one for faster transcoding speed, but fine tuning options are not supported.

    Method OpenCL: Follow the instructions from [intel-compute-runtime](https://github.com/intel/compute-runtime/releases). If you are using the docker image from jellyfin/jellyfin or linuxserver/jellyfin, this step can be skipped.

    Method VPP: Install `intel-media-va-driver-non-free` 20.1 and `jellyfin-ffmpeg` 4.4.1-1 or newer.

   > [!NOTE]
   > Tone mapping on Intel VA-API and QSV needs an iGPU that supports 10-bit decoding, such as i3-7100 and J4105.
   > Do not use the `intel-opencl-icd` package from the repository since they were not build with RELEASE_WITH_REGKEYS enabled for P010 pixel interop flags.

3. Debugging: Check the OpenCL device status. You will see corresponding vendor name if it goes well.

   - Use `clinfo`: Install `clinfo` before using it. `sudo apt update && sudo apt install clinfo -y` on Debian/Ubuntu or `sudo pacman -Sy clinfo` on Arch. Then `sudo clinfo`

   - Use `jellyfin-ffmpeg`: `/usr/lib/jellyfin-ffmpeg/ffmpeg -v debug -init_hw_device opencl`

### Configuring VA-API acceleration on Debian/Ubuntu

Configuring VA-API on Debian/Ubuntu requires some additional configuration to ensure permissions are correct.

To check information about VA-API on your system install and run `vainfo` from the command line.

   > [!NOTE]
   > For Intel Comet Lake or newer iGPUs, the legacy i965 VA-API driver is incompatible with your hardware.
   > Please follow the instructions from **Configuring Intel QuickSync(QSV) on Debian/Ubuntu** to get the newer iHD driver.

1. Configure VA-API for your system by following the [relevant documentation](https://wiki.archlinux.org/index.php/Hardware_video_acceleration). Verify that a `render` device is now present in `/dev/dri`, and note the permissions and group available to write to it, in this case `render`:

    ```sh
    $ ls -l /dev/dri
    total 0
    drwxr-xr-x 2 root root        100 Apr 13 16:37 by-path
    crw-rw---- 1 root video  226,   0 Apr 13 16:37 card0
    crw-rw---- 1 root video  226,   1 Apr 13 16:37 card1
    crw-rw---- 1 root render 226, 128 Apr 13 16:37 renderD128
    ```

    > [!NOTE]
    > On some releases, the group may be `video` instead of `render`.

2. Add the Jellyfin service user to the above group to allow Jellyfin's FFMpeg process access to the device, and restart Jellyfin.

    ```sh
    sudo usermod -aG render jellyfin
    sudo systemctl restart jellyfin
    ```

3. Configure VA-API acceleration in the "Transcoding" page of the Admin Dashboard. Enter the `/dev/dri/renderD128` device above as the `VA API Device` value.

4. Watch a movie, and verify that transcoding is occurring by watching the `ffmpeg-transcode-*.txt` logs under `/var/log/jellyfin` and using `radeontop` or similar tools.

### Configuring Intel QuickSync(QSV) on Debian/Ubuntu

1. QSV is based on VA-API device on Linux, so please confirm whether you have completed the VA-API configuration first.

2. Make sure that `jellyfin-ffmpeg 4.3.1-1` or higher is installed.

3. Install the non-free iHD driver.

   ```bash
   sudo apt update
   sudo apt install vainfo intel-media-va-driver-non-free -y
   ```

   > [!NOTE]
   > For Intel Comet Lake or newer iGPUs, make sure the version of `intel-media-va-driver-non-free` >= 19.1.
   > `intel-media-va-driver-non-free` is avaliable from apt since Debian buster and Ubuntu 19.04. Otherwise you have to build from source.

4. Verify iHD driver using `vainfo`. You will find `iHD` from the result if it goes well.

   ```bash
   vainfo | grep iHD
   ```

5. If you want to uninstall iHD driver and fallback to i965 driver.

   ```bash
   sudo apt remove intel-media-va-driver intel-media-va-driver-non-free -y
   ```

6. QSV in docker. Due to incompatible licenses, we will not integrate non-free drivers in the docker image. You need to perform the above operations manually in docker and add `--privileged` to the docker configuration.

### LXC or LXD Container

This has been tested with LXC 3.0 and may or may not work with older versions.

Follow the steps above to add the jellyfin user to the `video` or `render` group, depending on your circumstances.

1. Add your GPU to the container.

    ```sh
    lxc config device add <container name> gpu gpu gid=<gid of your video or render group>
    ```

2. Make sure you have the card within the container:

    ```sh
    $ lxc exec jellyfin -- ls -l /dev/dri
    total 0
    crw-rw---- 1 root video 226,   0 Jun  4 02:13 card0
    crw-rw---- 1 root video 226,   0 Jun  4 02:13 controlD64
    crw-rw---- 1 root video 226, 128 Jun  4 02:13 renderD128
    ```

3. Configure Jellyfin to use video acceleration and point it at the right device if the default option is wrong.

4. Try and play a video that requires transcoding and run the following, you should get a hit.

    ```sh
    ps aux | grep ffmpeg | grep accel
    ```

5. You can also try playing a video that requires transcoding, and if it plays you're good.

Useful Resources:

- [LXD Documentation - GPU instance configuration](https://github.com/lxc/lxd/blob/master/doc/instances.md#type-gpu)
- [NVidia CUDA inside a LXD container](https://stgraber.org/2017/03/21/cuda-in-lxd/)

### Configuring AMD AMF encoding on Ubuntu 18.04 or 20.04 LTS

1. Install `amdgpu-pro` closed source graphics driver by following the [installation instructions](https://amdgpu-install.readthedocs.io/en/latest/).

2. Then install `amf-amdgpu-pro`.

   ```bash
   sudo apt install amf-amdgpu-pro
   ```

3. Make sure your `jellyfin-ffmpeg` or `ffmpeg` contains `h264_amf` encoder.

   ```bash
   $ cd /usr/lib/jellyfin-ffmpeg/
   $ ./ffmpeg -encoders | grep h264_amf
   V..... h264_amf             AMD AMF H.264 Encoder (codec h264)
   ```

   > [!NOTE]
   > If not contain, update your `jellyfin-ffmpeg` to the latest version and try again.

   For compiling ffmpeg with AMF library, refer to [this page](https://www.ffmpeg.org/general.html#AMD-AMF_002fVCE).

4. Choose AMD AMF video acceleration in Jellyfin and check the `Enable hardware encoding` option.

5. Watch a movie, then verify that `h264_amf` encoder is working by watching the `ffmpeg-transcode-*.txt` transcoding logs under `/var/log/jellyfin` and using `radeontop` or similar tools.

### Configuring AMD AMF encoding on Arch Linux

AMD does not provide official `amdgpu-pro` driver support for Arch Linux, but fortunately, a third-party packaged `amdgpu-pro-installer` is provided in the archlinux user repository.

1. Clone [this repository](https://aur.archlinux.org/pkgbase/amdgpu-pro-installer/) using `git`.

   ```bash
   git clone https://aur.archlinux.org/amdgpu-pro-installer.git
   ```

2. Enter that folder and make the installation package and install it.

   ```bash
   cd amdgpu-pro-installer
   makepkg -si
   ```

3. Go to step 3 of **on Ubuntu 18.04 or 20.04 LTS** above.

### Raspberry Pi 3 and 4

1. Add the Jellyfin service user to the video group to allow Jellyfin's FFMpeg process access to the encoder, and restart Jellyfin.

    ```sh
    sudo usermod -aG video jellyfin
    sudo systemctl restart jellyfin
    ```

    > [!NOTE]
    > If you are using a Raspberry Pi 4, you might need to run `sudo rpi-update` for kernel and firmware updates.

2. Choose `OpenMAX OMX` as the Hardware acceleration on the Transcoding tab of the Server Dashboard.

3. Change the amount of memory allocated to the GPU. The GPU can't handle accelerated decoding and encoding simultaneously.

    ```sh
    sudo nano /boot/config.txt
    ```

    For RPi4, add the line `gpu_mem=320` [See more Here](https://www.raspberrypi.org/documentation/configuration/config-txt/)

    For RPi3, add the line `gpu_mem=256`

    You can set any value, but 320 is recommended amount for [4K HEVC](https://github.com/CoreELEC/CoreELEC/blob/coreelec-9.2/projects/RPi/devices/RPi4/config/config.txt).

    Verify the split between CPU and GPU memory:

    ```sh
    vcgencmd get_mem arm && vcgencmd get_mem gpu
    ```

    Monitor the temperature and clock speed of the CPU:

    ```sh
    vcgencmd measure_temp && vcgencmd measure_clock arm
    ```

> [!NOTE]
> RPi4 currently doesn't support HWA HEVC decoding, only encode and decode H.264. [Active cooling](https://www.jeffgeerling.com/blog/2019/raspberry-pi-4-needs-fan-heres-why-and-how-you-can-add-one) is required, passive cooling is insufficient for transcoding. Only Raspbian OS works so far. For docker, only the linuxserver image works. For more tips see [here](https://www.reddit.com/r/jellyfin/comments/ei6ew6/rpi4_hardware_acceleration_guide/).

> [!NOTE]
> As per [this issue](https://github.com/jellyfin/jellyfin/issues/4023), hardware acceleration is not yet supported on 64-bit Raspberry Pi OS (and likely on derivative builds e.g. DietPi), as some libraries in the 32-bit build are still missing from the 64-bit build.

> [!NOTE]
> For RPi3 in testing, transcoding was not working fast enough to run in real time because the video was being resized.

## Verifying Transcodes

To verify that you are using the proper libraries, run this command against your transcoding log. This can be found at Admin Dashboard > Logs, and /var/log/jellyfin if instead via the repository.

```sh
grep -A2 'Stream mapping:' /var/log/jellyfin/ffmpeg-transcode-85a68972-7129-474c-9c5d-2d9949021b44.txt
```

This returned the following results.

```data
Stream mapping:
Stream #0:0 -> #0:0 (hevc (native) -> h264 (h264_omx))
Stream #0:1 -> #0:1 (aac (native) -> mp3 (libmp3lame))
```

`Stream #0:0` used software (VAAPI Decode can also say native) to decode HEVC and used HWA to encode.

```data
Stream mapping:
Stream #0:0 -> #0:0 (h264 (h264_mmal) -> h264 (h264_omx))
Stream #0:1 -> #0:1 (flac (native) -> mp3 (libmp3lame))
```

`Stream #0:0` used HWA for both. h264_mmal to decode and h264_omx to encode.
