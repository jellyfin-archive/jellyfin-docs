---
uid: admin-hardware-acceleration
title: Hardware Acceleration
---


# Hardware Acceleration

Jellyfin supports hardware acceleration of video encoding/decoding/transcoding using FFMpeg. It supports multiple acceleration types, including  AMD AMF, Intel Quick Sync, OpenMax OMX, nVidia NVENC, Intel/AMD VAAPI, and others.

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

Note: In testing transcoding was not working fast enough to run in real time because the video was being resized. The Pi 3 is likely not fast enough to resize as part of the transcoding.