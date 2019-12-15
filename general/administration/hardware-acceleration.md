---
uid: admin-hardware-acceleration
title: Hardware Acceleration
---


# Hardware Acceleration

Jellyfin supports hardware acceleration of video encoding/decoding using FFMpeg. FFMpeg can support multiple hardware acceleration implementations like Intel Quicksync (QSV), AMD AMF, OpenMax OMX, nVidia NVENC/NVDEC through the Video Acceleration API (VAAPI), and others.

OS | Recommended HW Acceleration
------------ | -------------
Linux/GNU | VAAPI (recommended), NVENC, QSV, AMF
Windows | QSV, NVENC, AMF, VAAPI
MacOS | None (videotoolbox support coming)
Android | MediaCodec, OMX
RPi | OMX

Here is the official list of supported Codecs for [NVIDIA Graphics Cards](https://developer.nvidia.com/video-encode-decode-gpu-support-matrix). Not every card has been tested. These [drivers](https://github.com/keylase/nvidia-patch) are recommended for Linux/GNU and Windows.

List of supported Codecs for [VAAPI](https://wiki.archlinux.org/index.php/Hardware_video_acceleration#Comparison_tables).

List of Intel Processors that support [QSV](https://ark.intel.com/content/www/us/en/ark.html#@Processors).

FFmpeg Hardware Acceleration support [list](https://trac.ffmpeg.org/wiki/HWAccelIntro).

Example of Ubuntu working with [NVENC](https://www.reddit.com/r/jellyfin/comments/amuyba/nvenc_nvdec_working_in_jellyfin_on_ubuntu_server/)

#### Known Issues

[RPi 3 failing to transcode](https://github.com/jellyfin/jellyfin/issues/1546)<br/>
[RPi 4 failing to transcode](https://trac.ffmpeg.org/ticket/8018)<br/>


## Enabling Hardware Acceleration

Hardware acceleration options can be found in the Admin Dashboard under the **Transcoding** section. Select a valid hardware acceleration option from the drop-down menu, indicate a device if applicable, and check `enable hardware encoding` to enable encoding as well as decoding, if your hardware supports this.

The hardware acceleration is available immediately for media playback. No server restart is required.

## Setup

Each hardware acceleration type, as well as each Jellyfin installation type, requires different setup options before it can be used. It is always best to consult the FFMpeg documentation on the acceleration type you choose for the latest information.

### Configuring VAAPI acceleration on Debian/Ubuntu from `.deb` packages

Configuring VAAPI on Debian/Ubuntu requires some additional configuration to ensure permissions are correct.

1. Configure VAAPI for your system by following the [relevant documentation](https://wiki.archlinux.org/index.php/Hardware_video_acceleration). Verify that a `render` device is now present in `/dev/dri`, and note the permissions and group available to write to it, in this case `render`:  
    `$ ls -l /dev/dri`  
    `total 0`  
    `drwxr-xr-x 2 root root        100 Apr 13 16:37 by-path`  
    `crw-rw---- 1 root video  226,   0 Apr 13 16:37 card0`  
    `crw-rw---- 1 root video  226,   1 Apr 13 16:37 card1`  
    `crw-rw---- 1 root render 226, 128 Apr 13 16:37 renderD128`  

    **NOTE:** On some releases, the group may be `video` instead of `render`.

2. Add the Jellyfin service user to the above group to allow Jellyfin's FFMpeg process access to the device, and restart Jellyfin:  
    `sudo usermod -aG render jellyfin`  
    `sudo systemctl restart jellyfin`  

3. Configure VAAPI acceleration in the "Transcoding" page of the Admin Dashboard. Enter the `/dev/dri/renderD128` device above as the `VA API Device` value.

4. Watch a movie, and verify that transcoding is occurring by watching the `ffmpeg-transcode-*.txt` logs under `/var/log/jellyfin` and using `radeontop` or similar tools.

### Hardware acceleration in a LXC/LXD container (tested with LXC 3.0, may or may not work with version 2)

Follow the steps above to add the jellyfin user to the `video` or `render` group, depending on your circumstances.

1. Add your GPU to the container:
    `$ lxc config device add <container name> gpu gpu gid=<gid of your video or render group>`

2. Make sure you have the card within the container:
    `$ lxc exec jellyfin -- ls -l /dev/dri`
    `total 0`
    `crw-rw---- 1 root video 226,   0 Jun  4 02:13 card0`
    `crw-rw---- 1 root video 226,   0 Jun  4 02:13 controlD64`
    `crw-rw---- 1 root video 226, 128 Jun  4 02:13 renderD128`

3. Configure Jellyfin to use video acceleration, point it at the right device if the default option doesn't

4. Try and play a video that requires transcoding and run the following, you should get a hit:
   `$ ps aux | grep ffmpeg | grep accel`

5. You can also try playing a video that requires transcoding, and if it plays you're good.

Useful resources:
- https://github.com/lxc/lxd/blob/master/doc/containers.md#type-gpu
- https://stgraber.org/2017/03/21/cuda-in-lxd/

### Hardware acceleration on Raspberry Pi (tested on RPi3)
1. Add the Jellyfin service user to the video group to allow Jellyfin's FFMpeg process access to the encoder, and restart Jellyfin:  
    `sudo usermod -a -G video jellyfin`
    `sudo systemctl restart jellyfin`   
2. Choose `OpenMAX OMX` as the Hardware acceleration on the Transcoding tab of the Server Dashboard
3. Change the amount of memory allocated to the GPU, as the Pi's GPU can't handle accelerated decoding and encoding simultaneously:
    `sudo nano /boot/config.txt`
    
    Find the line that starts with `gpu_mem=` and replace it with `gpu_mem=256`.
    
    You can set any value, but 256 was thoroughly tested to be the minimum recommended for the best results.

Note: In testing transcoding was not working fast enough to run in real time because the video was being resized. The Pi 3 is likely not fast enough to resize as part of the transcoding.
