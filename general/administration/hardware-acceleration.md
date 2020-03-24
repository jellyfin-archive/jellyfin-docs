---
uid: admin-hardware-acceleration
title: Hardware Acceleration
---

# Hardware Acceleration

Jellyfin supports [hardware acceleration](https://trac.ffmpeg.org/wiki/HWAccelIntro) (HWA) of video encoding/decoding using FFMpeg. FFMpeg and Jellyfin can support multiple hardware acceleration implementations such as Intel Quicksync (QSV), AMD AMF, nVidia NVENC/NVDEC, OpenMax OMX and MediaCodec through Video Acceleration API's.

[VAAPI](https://en.wikipedia.org/wiki/Video_Acceleration_API) is a Video Acceleration API that uses [libva](https://github.com/intel/libva/blob/master/README.md) to interface with local drivers to provide HWA. [QSV](https://trac.ffmpeg.org/wiki/Hardware/QuickSync) uses a modified (forked) version of VAAPI and interfaces it with [libmfx](https://github.com/intel/media-driver/blob/master/README.md) and their proprietary drivers [(list of supported processors for QSV)](https://ark.intel.com/content/www/us/en/ark.html#@Processors).

OS      | Recommended HW Acceleration
------- | -------------
Linux   | QSV, NVENC, VAAPI
Windows | QSV, NVENC, AMF, VAAPI
MacOS   | None (VideoToolbox Coming Soon)
Android | MediaCodec, OMX
RPi     | OMX

[Graphics Cards comparison using HWA](https://www.elpamsoft.com/?p=Plex-Hardware-Transcoding)

[NVIDIA using ffmpeg official list](https://developer.nvidia.com/ffmpeg). Not every card has been tested. These [drivers](https://github.com/keylase/nvidia-patch) are recommended for Linux and Windows. Here is the official list of [NVIDIA Graphics Cards](https://developer.nvidia.com/video-encode-decode-gpu-support-matrix) for supported codecs. Example of Ubuntu working with [NVENC](https://www.reddit.com/r/jellyfin/comments/amuyba/nvenc_nvdec_working_in_jellyfin_on_ubuntu_server/). H264 10-bit is [not supported](https://devtalk.nvidia.com/default/topic/1039388/video-codec-and-optical-flow-sdk/is-there-nvidia-encoder-decoder-which-supports-hdr-10-bpp-for-avc-h-264-/) by NVIDIA acceleration.

List of supported codecs for [VAAPI](https://wiki.archlinux.org/index.php/Hardware_video_acceleration#Comparison_tables).

AMF Linux Support still [not official](https://github.com/GPUOpen-LibrariesAndSDKs/AMF/issues/4) and AMD GFX Cards are required to use VAAPI on Linux.

Zen is CPU only. No hardware acceleration for any form of video decoding/encoding. You will need an APU or dGPU for hardware acceleration.

Intel QSV Benchmarks on [Linux](https://www.intel.com/content/www/us/en/cloud-computing/cloud-computing-quicksync-video-ffmpeg-white-paper.html).

On Windows, you can use the DXVA2/D3D11VA libraries for decoding and the libmfx library for encoding.

CentOS may require [additional drivers](https://www.getpagespeed.com/server-setup/how-to-enable-intel-hardware-acceleration-for-video-playback-in-rhel-centos-8) for QSV.

Here's [additional information](https://github.com/Artiume/jellyfin-docs/blob/master/general/wiki/main.md) to learn more.

## Enabling Hardware Acceleration

Hardware acceleration options can be found in the Admin Dashboard under the **Transcoding** section. Select a valid hardware acceleration option from the drop-down menu, indicate a device if applicable, and check `enable hardware encoding` to enable encoding as well as decoding, if your hardware supports this.

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
      - /dev/vchiq:/dev/qchiq
```

## Debian Docker Nvidia

In order to achieve hardware acceleration using docker, several steps are required.

Prerequisites:

https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0)

- GNU/Linux x86_64 with kernel version > 3.10
- Docker >= 1.12
- NVIDIA GPU with Architecture > Fermi (2.1)
- NVIDIA drivers ~= 361.93 (untested on older versions)

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
deb http://ftp.ch.debian.org/debian/ stretch main
```

The line above should be modified to match the following line as an example.

```data
deb http://ftp.ch.debian.org/debian/ stretch main non-free contrib
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

Install linux-headers and run the following command.

```sh
apt-get install linux-headers-$(uname -r | sed 's/[^-]*-[^-]*-//')
```

Alternatively, run this command if you are on stretch for compatibility.

```sh
apt-get install -t stretch-backports linux-headers-$(uname -r | sed 's/[^-]*-[^-]*-//')
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
apt-get install -t stretch-backports nvidia-driver libnvcuvid1 libnvidia-encode1 libcuda1 nvidia-smi
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
-e "NVIDIA_DRIVER_CAPABILITIES=all" \
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

Once the container is started you can again validate access to the host ressources.

```sh
docker exec -it jellyfin ldconfig -p | grep cuvid
docker exec -it jellyfin ldconfig -p | grep libnvidia-encode.so.1
```

Now go in Jellyfin playback settings, enable Nvidia NVENC and select target codecs depending on what your GPU support
try to play any file needing a transcode. Changing the bitrate is a good way to try this.

Check the transcode logs to make sure everything is working properly.

```data
Stream #0:0 -> #0:0 (h264 (h264_cuvid) -> h264 (h264_nvenc))
Stream #0:2 -> #0:1 (ac3 (native) -> aac (native))
```

### Configuring VAAPI acceleration on Debian/Ubuntu from `.deb` packages

Configuring VAAPI on Debian/Ubuntu requires some additional configuration to ensure permissions are correct.

To check information about VAAPI on your system install and run `vainfo` from the command line.

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
> RPi4 currently doesn't support HWA decoding, only HWA encoding of H.264. [Active cooling](https://www.jeffgeerling.com/blog/2019/raspberry-pi-4-needs-fan-heres-why-and-how-you-can-add-one) is required, passive cooling is insufficient for transcoding. For RPi3 in testing, transcoding was not working fast enough to run in real time because the video was being resized.

### Verifying Transcodes

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

`Stream #0:0` used software to decode HEVC and used HWA to encode.

`Stream #0:1` had the same results. Decoding is easier than encoding so these are good results overall. HWA decoding is a work in progress.
