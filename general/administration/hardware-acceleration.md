---
uid: admin-hardware-acceleration
title: Hardware Acceleration
---

# Hardware Acceleration

Jellyfin supports [hardware acceleration](https://trac.ffmpeg.org/wiki/HWAccelIntro) (HWA) of video encoding/decoding using FFMpeg. FFMpeg and Jellyfin can support multiple hardware acceleration implementations such as Intel Quicksync (QSV), AMD AMF, nVidia NVENC/NVDEC, OpenMax OMX and MediaCodec through Video Acceleration API's.

[VAAPI](https://en.wikipedia.org/wiki/Video_Acceleration_API) is a Video Acceleration API that uses [libva](https://github.com/intel/libva/blob/master/README.md) to interface with local drivers to provide HWA. [QSV](https://trac.ffmpeg.org/wiki/Hardware/QuickSync) uses a modified (forked) version of VAAPI and interfaces it with [libmfx](https://github.com/intel/media-driver/blob/master/README.md) and their proprietary drivers [(list of supported processors for QSV)](https://ark.intel.com/content/www/us/en/ark.html#@Processors).

OS | Recommended HW Acceleration
------------ | -------------
Linux/GNU | QSV, NVENC, VAAPI
Windows | QSV, NVENC, AMF, VAAPI
MacOS | None (videotoolbox support coming)
Android | MediaCodec, OMX
RPi | OMX

[Graphics Cards comparison using HWA](https://www.elpamsoft.com/?p=Plex-Hardware-Transcoding)

[NVIDIA using ffmpeg official list](https://developer.nvidia.com/ffmpeg). Not every card has been tested. These [drivers](https://github.com/keylase/nvidia-patch) are recommended for Linux/GNU and Windows. Here is the official list of [NVIDIA Graphics Cards](https://developer.nvidia.com/video-encode-decode-gpu-support-matrix) for supported codecs. Example of Ubuntu working with [NVENC](https://www.reddit.com/r/jellyfin/comments/amuyba/nvenc_nvdec_working_in_jellyfin_on_ubuntu_server/).

List of supported codecs for [VAAPI](https://wiki.archlinux.org/index.php/Hardware_video_acceleration#Comparison_tables).

AMF Linux Support still [not official](https://github.com/GPUOpen-LibrariesAndSDKs/AMF/issues/4) and AMD GFX Cards are required to use VAAPI on linux.

Zen is CPU only. No hardware acceleration for any form of video decoding/encoding. You need an APU or dGPU for hardware acceleration.

Intel QSV Benchmarks on [Linux](https://www.intel.com/content/www/us/en/cloud-computing/cloud-computing-quicksync-video-ffmpeg-white-paper.html)

On Windows you can use DXVA2/D3D11VA libraries for decoding instead of libmfx and HWA encoding on Windows requires libmfx. The DXVA2/D3D11VA libraries are currently not supported by of Jellyfin. 

CentOS may require [additional drivers](https://www.getpagespeed.com/server-setup/how-to-enable-intel-hardware-acceleration-for-video-playback-in-rhel-centos-8) for QSV

Here's [additional information](https://github.com/Artiume/jellyfin-docs/blob/master/general/wiki/main.md) to learn more. 

## Enabling Hardware Acceleration

Hardware acceleration options can be found in the Admin Dashboard under the **Transcoding** section. Select a valid hardware acceleration option from the drop-down menu, indicate a device if applicable, and check `enable hardware encoding` to enable encoding as well as decoding, if your hardware supports this.

The hardware acceleration is available immediately for media playback. No server restart is required.

## Setup

Each hardware acceleration type, as well as each Jellyfin installation type, requires different setup options before it can be used. It is always best to consult the FFMpeg documentation on the acceleration type you choose for the latest information.

### Acceleration on Docker

In order to use Hardware acceleration in Docker, the devices must be passed to the container. To see what video devices are available, you can run `sudo lshw -c video` or `vainfo`

> [!NOTE]
> [NVIDIA GPUs](https://github.com/docker/compose/issues/6691) aren't currently supported in docker-compose.

Docker run configuration example:
 
   `docker run -d \`  
    `--volume /path/to/config:/config \`  
    `--volume /path/to/cache:/cache \`  
    `--volume /path/to/media:/media \`  
    `--net=host \`  
    `--restart=unless-stopped \`  
    `--device /dev/dri/renderD128:/dev/dri/renderD128 \`  
    `--device /dev/dri/card0:/dev/dri/card0 \`  
    `jellyfin/jellyfin`
  
Alternatively, using docker-compose:  

```yaml
version: "3"  
services:  
  jellyfin:  
    image: jellyfin/jellyfin
    network_mode: "host"  
    volumes:  
      - /path/to/config:/config  
      - /path/to/cache:/cache  
      - /path/to/media:/media  
    devices: 
      - /dev/dri/renderD128:/dev/dri/renderD128 # VAAPI devices, may be D128, D129, etc.
      - /dev/dri/card0:/dev/dri/card0
      - /dev/vchiq:/dev/qchiq  # Rpi4
```

### Configuring VAAPI acceleration on Debian/Ubuntu from `.deb` packages

Configuring VAAPI on Debian/Ubuntu requires some additional configuration to ensure permissions are correct.

To check information about VAAPI on your system install and run `vainfo`

1. Configure VAAPI for your system by following the [relevant documentation](https://wiki.archlinux.org/index.php/Hardware_video_acceleration). Verify that a `render` device is now present in `/dev/dri`, and note the permissions and group available to write to it, in this case `render`:  
    `$ ls -l /dev/dri`  
    `total 0`  
    `drwxr-xr-x 2 root root        100 Apr 13 16:37 by-path`  
    `crw-rw---- 1 root video  226,   0 Apr 13 16:37 card0`  
    `crw-rw---- 1 root video  226,   1 Apr 13 16:37 card1`  
    `crw-rw---- 1 root render 226, 128 Apr 13 16:37 renderD128`  

> [!NOTE]
> On some releases, the group may be `video` instead of `render`.

2. Add the Jellyfin service user to the above group to allow Jellyfin's FFMpeg process access to the device, and restart Jellyfin:  
    `sudo usermod -aG render jellyfin`  
    `sudo systemctl restart jellyfin`  

3. Configure VAAPI acceleration in the "Transcoding" page of the Admin Dashboard. Enter the `/dev/dri/renderD128` device above as the `VA API Device` value.

4. Watch a movie, and verify that transcoding is occurring by watching the `ffmpeg-transcode-*.txt` logs under `/var/log/jellyfin` and using `radeontop` or similar tools.

### LXC or LXD Container

This has been tested with LXC 3.0 and may or may not work with older versions.

Follow the steps above to add the jellyfin user to the `video` or `render` group, depending on your circumstances.

1. Add your GPU to the container:
    `$ lxc config device add <container name> gpu gpu gid=<gid of your video or render group>`

2. Make sure you have the card within the container:
    `$ lxc exec jellyfin -- ls -l /dev/dri`
    `total 0`
    `crw-rw---- 1 root video 226,   0 Jun  4 02:13 card0`
    `crw-rw---- 1 root video 226,   0 Jun  4 02:13 controlD64`
    `crw-rw---- 1 root video 226, 128 Jun  4 02:13 renderD128`

3. Configure Jellyfin to use video acceleration, point it at the right device if the default option is wrong.

4. Try and play a video that requires transcoding and run the following, you should get a hit:
    `$ ps aux | grep ffmpeg | grep accel`

5. You can also try playing a video that requires transcoding, and if it plays you're good.

Useful resources:
* https://github.com/lxc/lxd/blob/master/doc/containers.md#type-gpu
* https://stgraber.org/2017/03/21/cuda-in-lxd/

### Raspberry Pi 3 and 4
1. Add the Jellyfin service user to the video group to allow Jellyfin's FFMpeg process access to the encoder, and restart Jellyfin.
    `sudo usermod -aG video jellyfin`
    `sudo systemctl restart jellyfin`
    On Rpi4, update the firmware and kernel.
    `sudo rpi-update`
2. Choose `OpenMAX OMX` as the Hardware acceleration on the Transcoding tab of the Server Dashboard.
3. Change the amount of memory allocated to the GPU. The GPU can't handle accelerated decoding and encoding simultaneously.
    `sudo nano /boot/config.txt`

    For RPi4, add the line `gpu_mem=320` [See more Here](https://www.raspberrypi.org/documentation/configuration/config-txt/)

    For RPi3, add the line `gpu_mem=256`

    You can set any value, but 320 is recommended amount for [4K HEVC](https://github.com/CoreELEC/CoreELEC/blob/coreelec-9.2/projects/RPi/devices/RPi4/config/config.txt).

    Use `vcgencmd get_mem arm && vcgencmd get_mem gpu` to verify the split between CPU and GPU memory.
    
    Use `vcgencmd measure_temp && vcgencmd measure_clock arm` to monitor the temperature and clock speed of the CPU.

> [!NOTE]
> RPi4 currently doesn't support HWA decoding, only HWA encoding of H.264. [Active cooling](https://www.jeffgeerling.com/blog/2019/raspberry-pi-4-needs-fan-heres-why-and-how-you-can-add-one) is required, passive cooling is insufficient for transcoding. For Rpi3 in testing, transcoding was not working fast enough to run in real time because the video was being resized.

### Verifying Transcodes

To verify that you are using the proper libraries, run this command against your transcoding log. This can be found at Admin Dashboard > Logs, and /var/log/jellyfin if instead via the repository.

```bash
grep -A2 'Stream mapping:' /var/log/jellyfin/ffmpeg-transcode-85a68972-7129-474c-9c5d-2d9949021b44.txt
```

This returned the following results.

```bash
Stream mapping:
Stream #0:0 -> #0:0 (hevc (native) -> h264 (h264_omx))
Stream #0:1 -> #0:1 (aac (native) -> mp3 (libmp3lame))
```

Stream #0:0 used software to decode hevc and used HWA to encode.

Stream #0:1 had the same results. Decoding is easier than encoding so these are good results overall. HWA decoding is a work in progress.
