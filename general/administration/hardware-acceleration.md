---
uid: admin-hardware-acceleration
title: Hardware Acceleration
---

# Hardware Acceleration

Jellyfin supports [hardware acceleration](https://trac.ffmpeg.org/wiki/HWAccelIntro) (HWA) of video encoding/decoding using FFMpeg. FFMpeg and Jellyfin can support multiple hardware acceleration implementations such as Intel Quicksync (QSV), AMD AMF, nVidia NVENC/NVDEC, OpenMax OMX and MediaCodec through Video Acceleration API's.

[VAAPI](https://en.wikipedia.org/wiki/Video_Acceleration_API) is a Video Acceleration API that uses [libva](https://github.com/intel/libva/blob/master/README.md) to interface with local drivers to provide HWA. [QSV](https://trac.ffmpeg.org/wiki/Hardware/QuickSync) uses a modified (forked) version of VAAPI and interfaces it with [libmfx](https://github.com/intel/media-driver/blob/master/README.md) and their proprietary drivers [(list of supported processors for QSV)](https://ark.intel.com/content/www/us/en/ark.html#@Processors).

OS      | Recommended HW Acceleration
------- | -------------
Linux   | QSV, NVENC, AMF, VAAPI
Windows | QSV, NVENC, AMF
MacOS   | VideoToolbox
Android | MediaCodec, OMX
RPi     | OMX, VAAPI

[Graphics Cards comparison using HWA](https://www.elpamsoft.com/?p=Plex-Hardware-Transcoding)

## NVIDIA NVENC

[NVIDIA using ffmpeg official list](https://developer.nvidia.com/ffmpeg). Not every card has been tested. These [drivers](https://github.com/keylase/nvidia-patch) are recommended for Linux and Windows. Here is the official list of [NVIDIA Graphics Cards](https://developer.nvidia.com/video-encode-decode-gpu-support-matrix) for supported codecs. Example of Ubuntu working with [NVENC](https://www.reddit.com/r/jellyfin/comments/amuyba/nvenc_nvdec_working_in_jellyfin_on_ubuntu_server/). H264 10-bit is [not supported](https://devtalk.nvidia.com/default/topic/1039388/video-codec-and-optical-flow-sdk/is-there-nvidia-encoder-decoder-which-supports-hdr-10-bpp-for-avc-h-264-/) by NVIDIA acceleration. **The minimum required driver version is: Linux: 418.30, Windows: 450.51.**

## VAAPI

List of supported codecs for [VAAPI](https://wiki.archlinux.org/index.php/Hardware_video_acceleration#Comparison_tables). Both Intel iGPU and AMD GPU can use VAAPI.
> [!NOTE]
> AMD GPU requires open source driver Mesa 20.1 or higher to support hardware decoding HEVC.

## AMD AMF

AMF is now available on Windows and Linux, but since AMD has not implemented the HW decoder and scaler in ffmpeg, the decoding speed may not be as expected. The closed source driver `amdgpu-pro` is required when using AMF on Linux.
> [!NOTE]
> Zen is CPU only. No hardware acceleration for any form of video decoding/encoding. You will need an APU or dGPU for hardware acceleration.

## Intel QuickSync

Intel QSV Benchmarks on [Linux](https://www.intel.com/content/www/us/en/cloud-computing/cloud-computing-quicksync-video-ffmpeg-white-paper.html).

On Windows, you can use the DXVA2/D3D11VA libraries for decoding and the libmfx library for encoding.

> [!NOTE]
> To use QSV on Windows, please do not install Jellyfin as a system service.

Issues: [FFmpeg Windows version with QSV hwaccel fails over TERMINAL](https://trac.ffmpeg.org/ticket/7511) and [Intel QSV: "Failed to create Direct3D device" on Core i7-7700K (Skylake) on Windows 10](https://trac.ffmpeg.org/ticket/6827)

CentOS may require [additional drivers](https://www.getpagespeed.com/server-setup/how-to-enable-intel-hardware-acceleration-for-video-playback-in-rhel-centos-8) for QSV.

Here's [additional information](https://github.com/Artiume/jellyfin-docs/blob/master/general/wiki/main.md) to learn more.

If your Jellyfin server does not support hardware acceleration, but you have another machine that does, you can leverage [rffmpeg](https://github.com/joshuaboniface/rffmpeg) to delegate the transcoding to another machine. Currently Linux-only and requires SSH between the machines, as well as shared storage both for media and for the Jellyfin data directory.

## Enabling Hardware Acceleration

Hardware acceleration options can be found in the Admin Dashboard under the **Transcoding** section of the **Playback** tab. Select a valid hardware acceleration option from the drop-down menu, indicate a device if applicable, and check `enable hardware encoding` to enable encoding as well as decoding, if your hardware supports this.

The hardware acceleration is available immediately for media playback. No server restart is required.

## Setup

Each hardware acceleration type, as well as each Jellyfin installation type, requires different setup options before it can be used. It is always best to consult the FFMpeg documentation on the acceleration type you choose for the latest information.

### Acceleration on Docker

In order to use hardware acceleration in Docker, the devices must be passed to the container. To see what video devices are available, you can run `sudo lshw -c video` or `vainfo` on your machine.

> [!NOTE]
> [NVIDIA GPUs](https://github.com/docker/compose/issues/6691) aren't currently supported in docker-compose.

You can use `docker run` to start the server with a command like the one below.

```sh
docker run -d \
 --volume /path/to/config:/config \
 --volume /path/to/cache:/cache \
 --volume /path/to/media:/media \
 --user 1000:1000 \
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

### Debian Docker Nvidia

In order to achieve hardware acceleration using docker, several steps are required.

Prerequisites:

[NVIDIA Docker Installation](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0))

- GNU/Linux x86_64 with kernel version > 3.10
- Docker >= 1.12
- NVIDIA GPU with Architecture > Fermi (2.1)
- NVIDIA drivers >= 418.30

Confirm that your GPU shows up with this command.

```sh
lspci | grep VGA
```

Update your host so there is no chance of outdated software causing issues.

```sh
apt-get update && apt-get dist-upgrade -y
```

Install curl which will be used to download the required files.

```sh
apt-get install curl
```

Edit `sources.list` in `/etc/apt/sources.list` and add `non-free contrib` to each source as required.

```data
deb http://deb.debian.org/debian/ stretch main
```

The line above should be modified to match the following line as an example.

```data
deb http://deb.debian.org/debian/ stretch main non-free contrib
```

Download and add the sources for the Nvidia docker container.

```sh
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```

Update your package list again to download the latest software available from the new repository.

```sh
apt-get update
```

Install linux-headers with the following command.

```sh
apt-get install linux-headers-$(uname -r | sed 's/[^-]*-[^-]*-//')
```

Alternatively, Install linux-headers using backports.

```sh
distribution=$(. /etc/*-release;echo $VERSION_CODENAME)
apt-get install -t $distribution-backports linux-headers-$(uname -r | sed 's/[^-]*-[^-]*-//')
```

Install Nvidia docker2 from the repository.

```sh
apt-get install nvidia-docker2
```

When prompted to choose to keep or install the maintainer package file type `y` to install the maintainer version.

After the install you may want to add nvidia as default runtime: editing `/etc/docker/daemon.json` like this:

```json
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```

Restart any docker services currently running.

```sh
sudo pkill -SIGHUP docker
```

Install nvidia drivers and dependencies.

```sh
distribution=$(. /etc/*-release;echo $VERSION_CODENAME)
apt-get install -t $distribution-backports nvidia-driver libnvcuvid1 libnvidia-encode1 libcuda1 nvidia-smi
```

Reboot your host to apply all changes.

```sh
reboot now
```

Validate that your driver and docker are correctly set up with this driver test.

```sh
nvidia-smi
docker run --gpus 0 nvidia/cuda:9.0-base nvidia-smi
```

Validate access to needed ressources from host and docker.

```sh
ldconfig -p | grep cuvid
ldconfig -p | grep libnvidia-encode.so.1
```

Start your container adding those environement parameters.

```sh
-e NVIDIA_DRIVER_CAPABILITIES=all \
-e NVIDIA_VISIBLE_DEVICES=all \
--runtime=nvidia \
--gpus all \
```

A complete run command would look like this.

```sh
docker run -d \
 --name=jellyfin \
 -e NVIDIA_DRIVER_CAPABILITIES=all \
 -e NVIDIA_VISIBLE_DEVICES=all \
 --gpus all \
 --runtime=nvidia \
 -p 8096:8096 \
 -p 8920:8920 \
 -v /config:/config \
 -v /media:/media \
 -v /cache:/cache \
 --restart unless-stopped \
 jellyfin/jellyfin
```

There are some special steps when running with the following option.

```sh
--user 1000:1000
```

You may need to add this user to the video group.

```sh
usermod -aG video user
```

Once the container is started you can again validate access to the host resources.

```sh
docker exec -it jellyfin nvidia-smi
```

If you get driver information, everything is fine but if you get an error like `couldn't find libnvidia-ml.so library in your system` you need to run the following command.

```sh
docker exec -it jellyfin ldconfig
```

After that, you should ensure the Nvidia driver loads correctly.

Now go to the Jellyfin playback settings, enable Nvidia NVENC and select your target codecs depending on what your GPU supports. Try to play any file needing a transcode by changing the bitrate.

Check the transcode logs to make sure everything is working properly.

```data
Stream #0:0 -> #0:0 (h264 (h264_cuvid) -> h264 (h264_nvenc))
Stream #0:2 -> #0:1 (ac3 (native) -> aac (native))
```

### Configuring OpenCL accelerated Tone mapping

Currently, Tone mapping with Nvidia NVENC, AMD AMF and Intel VAAPI is through OpenCL image support.

OS/Platform | NVIDIA NVENC | AMD AMF  | Intel VAAPI | AMD VAAPI | Intel QSV | Software
----------- | ------------ | -------- | ----------- | --------- | --------- | --------
Linux       | OK           | OK       | OK          | planned   | planned   | planned
Windows     | OK           | OK       | N/A         | N/A       | planned   | planned
Docker      | OK           | untested | OK          | planned   | planned   | planned

> [!NOTE]
> Make sure the hardware acceleration is well configured before reading this section.

1. On Windows: Install the latest Nvidia or AMD driver is fairly enough.

2. On Linux or docker:

   - For Nvidia cards, install `nvidia-opencl-icd` on Debian/Ubuntu. Install `opencl-nvidia` on Arch.

    ```sh
    sudo apt update
    sudo apt install nvidia-opencl-icd
    ```
    ```sh
    sudo pacman -Sy opencl-nvidia
    ```

   - For AMD cards, install `amdgpu-pro` with opencl arguments. See **Configuring AMD AMF encoding on Ubuntu 18.04 or 20.04 LTS** for more details.

    ```sh
    sudo ./amdgpu-pro-install -y --opencl=pal,legacy
    ```

   - For Intel iGPUs, follow the instructions from [intel-compute-runtime](https://github.com/intel/compute-runtime/releases). If you are using the docker image from jellyfin/jellyfin, this step can be skipped.

> [!NOTE]
> Tone mapping on Intel VAAPI needs an iGPU that support 10-bit decoding.
> Do not use the `intel-opencl-icd` package from the repository since they were not build with RELEASE_WITH_REGKEYS enabled for P010 pixel interop flags.

3. Check the OpenCL device status. You will see corresponding vendor name if it goes well.

   - Use `clinfo`: Install `clinfo` before using it. `sudo apt update && sudo apt install clinfo -y` on Debian/Ubuntu or `sudo pacman -Sy clinfo` on Arch. Then `sudo clinfo`

   - Use `jellyfin-ffmpeg`: `/usr/lib/jellyfin-ffmpeg/ffmpeg -v debug -init_hw_device opencl`

### Configuring VAAPI acceleration on Debian/Ubuntu from `.deb` packages

Configuring VAAPI on Debian/Ubuntu requires some additional configuration to ensure permissions are correct.

To check information about VAAPI on your system install and run `vainfo` from the command line.

   > [!NOTE]
   > For Intel Comet Lake or newer iGPUs, the legacy i965 VAAPI driver is incompatible with your hardware.
   > Please follow the instructions from **Configuring Intel QuickSync(QSV) on Debian/Ubuntu** to get the newer iHD driver.

1. Configure VAAPI for your system by following the [relevant documentation](https://wiki.archlinux.org/index.php/Hardware_video_acceleration). Verify that a `render` device is now present in `/dev/dri`, and note the permissions and group available to write to it, in this case `render`:

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

3. Configure VAAPI acceleration in the "Transcoding" page of the Admin Dashboard. Enter the `/dev/dri/renderD128` device above as the `VA API Device` value.

4. Watch a movie, and verify that transcoding is occurring by watching the `ffmpeg-transcode-*.txt` logs under `/var/log/jellyfin` and using `radeontop` or similar tools.

### Configuring Intel QuickSync(QSV) on Debian/Ubuntu

1. QSV is based on VAAPI device on Linux, so please confirm whether you have completed the VAAPI configuration first.

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

2. Then install `amf-amdgpu-pro`:

   ```bash
   sudo apt install amf-amdgpu-pro
   ```

3. Make sure your `jellyfin-ffmpeg` or `ffmpeg` contains `h264_amf` encoder:

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

1. Clone [this repository](https://aur.archlinux.org/pkgbase/amdgpu-pro-installer/) using `git`:

   ```bash
   git clone https://aur.archlinux.org/amdgpu-pro-installer.git
   ```

2. Enter that folder and make the installation package and install it:

   ```bash
   cd amdgpu-pro-installer
   makepkg -si
   ```

3. Go to step 3 of **on Ubuntu 18.04 or 20.04 LTS** above.

### Configuring OMX on Raspberry Pi 3 and 4 running Raspberry Pi OS

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
> For RPi3 in testing, transcoding was not working fast enough to run in real time because the video was being resized.

### Configuring VAAPI on Raspberry Pi 3 and 4 running Ubuntu server

1. Enable the `render` device on your Pi.

   - If you are using Raspberry Pi 3 add this to the `/boot/firmware/usercfg.txt` file.

     ```sh
     gpu_mem=256
     dtoverlay=vc4-kms-v3d
     ```

   - Or if you are a Raspberry Pi 4 user add this to the `/boot/firmware/usercfg.txt` file.

     ```sh
     gpu_mem=320
     dtoverlay=vc4-kms-v3d-pi4
     ```

    Then save the file and do a reboot. Verify that a `render` device is now present in `/dev/dri`.

    ```sh
    $ ls -l /dev/dri
    total 0
    drwxr-xr-x 2 root root        100 Oct 13 16:00 by-path
    crw-rw---- 1 root video  226,   0 Oct 13 16:00 card0
    crw-rw---- 1 root video  226,   1 Oct 13 16:00 card1
    crw-rw---- 1 root render 226, 128 Oct 13 16:00 renderD128
    ```

2. Add Jellyfin service user to the `render` group to allow Jellyfin's FFMpeg process access to the device, and restart Jellyfin.

   ```sh
   sudo usermod -aG render jellyfin
   sudo systemctl restart jellyfin
   ```

3. Configure VAAPI acceleration in the **Transcoding** page of the Admin Dashboard. Enter the `/dev/dri/renderD128` device above as the `VA API` Device value.

4. Watch a movie, and verify that transcoding is working by watching `ffmpeg-transcode-*.txt` logs under `/var/log/jellyfin`.

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
