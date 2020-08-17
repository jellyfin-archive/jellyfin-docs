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
Windows | QSV, NVENC, AMF
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

Issues: [FFmpeg Windows version with QSV hwaccel fails over TERMINAL](https://trac.ffmpeg.org/ticket/7511) and [Intel QSV: "Failed to create Direct3D device" on Core i7-7700K (Skylake) on Windows 10](https://trac.ffmpeg.org/ticket/6827)

CentOS may require [additional drivers](https://www.getpagespeed.com/server-setup/how-to-enable-intel-hardware-acceleration-for-video-playback-in-rhel-centos-8) for QSV.

Here's [additional information](https://github.com/Artiume/jellyfin-docs/blob/master/general/wiki/main.md) to learn more.

If your Jellyfin server does not support hardware acceleration, but you have another machine that does, you can leverage [rffmpeg](https://github.com/joshuaboniface/rffmpeg) to delegate the transcoding to another machine. Currently Linux-only and requires SSH between the machines, as well as shared storage both for media and for the Jellyfin data directory.

## Enabling Hardware Acceleration

Hardware acceleration options can be found in the Admin Dashboard under the **Transcoding** section of the **Playback** tab. Select a valid hardware acceleration option from the drop-down menu, indicate a device if applicable, and check `enable hardware encoding` to enable encoding as well as decoding, if your hardware supports this.

The hardware acceleration is available immediately for media playback. No server restart is required.

## Setup

Each hardware acceleration type, as well as each Jellyfin installation type, requires different setup options before it can be used. It is always best to consult the FFMpeg documentation on the acceleration type you choose for the latest information.

##Install & Setup for Debain/Ubuntu Nvidia NVENC
First off we need to figure out what the most up to date driver is for your NVIDIA Card is.
So for this we need to go to the below link.

[NVIDIA Driver Update](https://www.nvidia.com/Download/index.aspx)

1. You'll need to know what NVIDIA Device you have before searching.
    -IE. i have an MSI Geoforce GTX 970 for the example of looking up im goin to show you my 1650, thats in the computer im typing this out on but the commands should all show the NVIDIA Geoforce GTX 970 for examples. The only thing that will show my 1650 is this output below.
        If you dont know what kind of GPU you have you can type in terminal ```lspci``` it will have an output like this
```00:00.0 Host bridge: Intel Corporation 8th Gen Core 4-core Desktop Processor Host Bridge/DRAM Registers [Coffee Lake S] (rev 07)
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) (rev 07)
00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
00:14.0 USB controller: Intel Corporation 200 Series/Z370 Chipset Family USB 3.0 xHCI Controller
00:14.2 Signal processing controller: Intel Corporation 200 Series PCH Thermal Subsystem
00:16.0 Communication controller: Intel Corporation 200 Series PCH CSME HECI #1
00:17.0 SATA controller: Intel Corporation 200 Series PCH SATA controller [AHCI mode]
00:1f.0 ISA bridge: Intel Corporation Device a2ca
00:1f.2 Memory controller: Intel Corporation 200 Series/Z370 Chipset Family Power Management Controller
00:1f.3 Audio device: Intel Corporation 200 Series PCH HD Audio
00:1f.4 SMBus: Intel Corporation 200 Series/Z370 Chipset Family SMBus Controller
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (2) I219-V
01:00.0 VGA compatible controller: NVIDIA Corporation TU116 [GeForce GTX 1650 SUPER] (rev a1)
01:00.1 Audio device: NVIDIA Corporation TU116 High Definition Audio Controller (rev a1)
01:00.2 USB controller: NVIDIA Corporation TU116 USB 3.1 Host Controller (rev a1)
01:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU116 [GeForce GTX 1650 SUPER] (rev a1)
```
This is the ouput you are looking for
`01:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU116 [GeForce GTX 1650 SUPER] (rev a1)`
Now check the firmware revision its on by typing ```ndvidia-smi```
you should get an ouput like this
Sun Aug 16 20:42:25 2020       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.57       Driver Version: 450.57       CUDA Version: 11.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  GeForce GTX 165...  Off  | 00000000:01:00.0  On |                  N/A |
|  0%   50C    P0    26W / 100W |    719MiB /  3895MiB |     17%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+

(you specifically just need this to see if you have the latest available driver and if so then skip steps 9.-14.

2. So to find the correct drivers select from the dropdown. Againb using my Geoforce 970 as an example
        Product Type: Geoforce (whoever manufacters your GPU)
        Product Series: Geoforce 900 Series (make sure you are not selecting the M unless your on a laptop)
        Product Geoforce GTX 970 (Select what model of graphics card you have for your GPU)
        Operating System: LINUX 64BIT (This is very important!!)        
        Download Type: Select Linux Short Lived if your graphics card is a bit older.WHEN I SAY OLDER I MEAN 2 YEARS OR LESS.
                       Select Linux Long Lived if your NVIDIA CARD IS FAIRLY NEW.
        Click Search. This will automatically tell you your most updated driver you will need. Write or type this out somewhere so you can access it later.

3. Now go to this link [NVIDIA Github patch](https://github.com/keylase/nvidia-patch) for patching the drivers.

4. Scroll Down to the versions table or type in browser CTRL + F. Then type in your browser window for your drive
        IE. Geoforce GTX 970 = 432.21 (it showed us the driver on nvidias website)

5. Once youve located your correct driver hover over the driver link with your mouse right click the link and copy the link location.

6. IMPORTANT!!! YOU NEED TO RUN THESE COMMANDS IN CLI NOT DE NOT DE TERMINAL CLI 
        To do this we need to go out of GUI(Desktop Enviroment) and into CLI(kernal recovery terminal). 
        So we do this by Pressing CTRL+ALT+F1 (Some people DE(desktop enviroment) will already be on F1 so change it to any other F#

7. Now your should see a terminal login with your user
          IE. my user is ```devilscoder```
          so i loing with user ```devilscoder``` and the password associated with it.

9. Now make the this directory and navigate to it by sending this command.
        ```sudo mkdir /opt/nvidia && cd /opt/nvidia```

10. Now we need to download the correctly update driver from the command posted below
        ```sudo wget https://international.download.nvidia.com/XFree86/Linux-x86_64/(driver firmware number)/NVIDIA-Linux-x86_(driver firmware number).run```
        IE if my drivers firmware revision is 335.21 that we found on the nvidia driver search on hte nvidia website. So mine would look like this
        ```sudo wget https://international.download.nvidia.com/XFree86/Linux-x86_64/435.21/NVIDIA-Linux-x86_64-435.21.run```

11. Now we need to give them permissions.
        ```sudo chmod +x ./NVIDIA-Linux-x86_64-(driver firmware number).run```

12.Now we need to run the driver installer.
           ```./NVIDIA-Linux-x86_64-430.50.run```

14. Make sure the new drivers is installed and recognized by typing in
            ```nvidia-smi```

15. Once the driver is installed we now need to install and patch the driver with the patch file downloaded from the github.
            ```cd ~/```
            ```sudo git clone https://ipfs.io/ipns/Qmed4r8yrBP162WK1ybd1DJWhLUi4t6mGuBoB9fLtjxR7u nvidia-patch```
            ```bash ./patch.sh```
16. Now it should display succesfully patched. Now that everythings done we can restart xServer or whatever you were using for DE (Desktop Enviroment)    
            ```startx```
            Your Desktop Enviroment should then display login and move your way to your jellyfin install in browser
            ie. (internal ip adress of server):8096 ie. 192.168.1.155:8096
            ie. (if your on the computer where jellyfin is installed)       http://localhost:8096 
            ie. (if you have a reverse-proxy running) https://sub.yourdomain.com        https://stream.jellyfin.com
17. Once there click on the top left hamburger menu and click on dashboard in the menu

18. Once Loaded click on the hamburger menu again and select playback

19. Now is IMPORTANT!!! Open this link [NVENC/DECODING SETTINGS FOR GPU](https://developer.nvidia.com/video-encode-decode-gpu-support-matrix#Encoder)
                Once there if your card is 2 years or older it will most likely not have NVENC (NVIDIA ENCODING) on the card. So lets go  scroll to the bottom and select the green button that says Geoforce/Titan becuase mine in this example is a Geoforce GTX 970.
        Now it should pull up more graphics card. Hit the key combinations CTRL + F and type your graphics card so im going to type 970. 
        it will take you to your card and now check the settings mine has these decoding features. 
            MPEG-1   YES      MPEG-2   YES      VC-1   YES      H.264(AVCHD)   YES
        So because these are enabled please write them down somewhere.
20. Now go back to Jellyfin and click the first dropdown menu and select Nvidia NVENC
21. Then enable only those options. That you wrote down in step 19. So Since my card does not encoding i need to disable anything with encoding in the options if you dont bascically you wont be able to watch your videos on your Jellyfin server.
22. Click on save at the bottom and check if they stuck by hitting on your keyboard CTR + F5 this should clear cache and refresh your page. Now if you settings stuck on the playback page. Great Enjoy! IF NOT YOU NEED TO DOUBLE CHECK YOUR COMPATIBILITY WITH NVENC DECODING/ENCODING. The only way the settings wont stick is if your device is incompatible. So it says nope i dont like those settings and automatically reverts the changes to not harm your system.


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

## Debian Docker Nvidia

In order to achieve hardware acceleration using docker, several steps are required.

Prerequisites:

[NVIDIA Docker Installation](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0))

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
> RPi4 currently doesn't support HWA HEVC decoding, only encode and decode H.264. [Active cooling](https://www.jeffgeerling.com/blog/2019/raspberry-pi-4-needs-fan-heres-why-and-how-you-can-add-one) is required, passive cooling is insufficient for transcoding. Only Raspbian OS works so far. For docker, only the linuxserver image works. For more tips see [here](https://www.reddit.com/r/jellyfin/comments/ei6ew6/rpi4_hardware_acceleration_guide/).

> [!NOTE]
> For RPi3 in testing, transcoding was not working fast enough to run in real time because the video was being resized.

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

`Stream #0:0` used software (VAAPI Decode can also say native) to decode HEVC and used HWA to encode.

```data
Stream mapping:
Stream #0:0 -> #0:0 (h264 (h264_mmal) -> h264 (h264_omx))
Stream #0:1 -> #0:1 (flac (native) -> mp3 (libmp3lame))
```

`Stream #0:0` used HWA for both. h264_mmal to decode and h264_omx to encode.
