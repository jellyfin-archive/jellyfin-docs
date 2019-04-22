# Hardware Acceleration

Jellyfin supports hardware acceleration of video encoding/decoding/transcoding using FFMpeg. It supports multiple acceleration types, including  AMD AMF, Intel Quick Sync, OpenMax OMX, nVidia NVENC, Intel/AMD VAAPI, and others.

## Enabling Hardware Acceleration

Hardware acceleration options can be found in the Admin Dashboard under the **Transcoding** section. Select a valid hardware acceleration option from the drop-down menu, indicate a device if applicable, and check `enable hardware encoding` as well as decoding if your hardware supports that as well.

The hardware acceleration is available immediately for media playback. No server restart is required.

## Setup

Each hardware acceleration type, as well as each Jellyfin installation type, requires different setup options before it can be used. It is always best to consult the FFMpeg documentation on the acceleration type you choose for the latest information.

### Configuring VAAPI acceleration on Debian/Ubuntu from `.deb` packages

Configuring VAAPI on Debian/Ubuntu requires some additional configuration to ensure permissions are correct.

1. Configure VAAPI for your system by following the [relevant documentation](https://wiki.archlinux.org/index.php/Hardware_video_acceleration). Verify that a `render` device is now present in `/dev/dri`, and note the permissions and group available to write to it, in this case `render`:

    $ ls -l /dev/dri
    total 0
    drwxr-xr-x 2 root root        100 Apr 13 16:37 by-path
    crw-rw---- 1 root video  226,   0 Apr 13 16:37 card0
    crw-rw---- 1 root video  226,   1 Apr 13 16:37 card1
    crw-rw---- 1 root render 226, 128 Apr 13 16:37 renderD128

   **NOTE:** On some releases, the group may be `video` instead of `render`.

2. Add the Jellyfin service user to the above group to allow Jellyfin's FFMpeg process access to the device, and restart Jellyfin:

    sudo usermod -aG render jellyfin
    sudo systemctl restart jellyfin

3. Configure VAAPI acceleration in the "Transcoding" page of the Admin Dashboard. Enter the `/dev/dri/renderD128` device above as the `VA API Device` value.

4. Watch a movie, and verify that transcoding is occurring by watching the `ffmpeg-transcode-*.txt` logs under `/var/log/jellyfin` and using `radeontop` or similar tools.
