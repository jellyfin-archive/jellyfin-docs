---
uid: admin-hardware-acceleration-Ubuntu-Debion-Hardware-Acceleration
title: Install and Setup of Debian/Ubuntu NVENC
---


##  Install & Setup for Debain/Ubuntu Nvidia NVENC

### Checking Your GPU Drivers

**(Important)**  If you already know you have the latest drivers please skip down to the installing of the patch file.

First off you need to figure out what the most up to date driver is for your NVIDIA Card is.

- So for this you need to go to the below link.

[NVIDIA Driver Update](https://www.nvidia.com/Download/index.aspx)

   1. You'll need to know what NVIDIA Device you have before searching.
    
        - IE. i have an MSI Geoforce GTX 970.

        - If you dont know what kind of GPU you have you can run 
                
                lspci 
        - it will display an output like this:

                00:00.0 Host bridge: Intel Corporation 8th Gen Core 4-core Desktop Processor Host Bridge/DRAM Registers [Coffee Lake S] (rev 07)
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
                01:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU116 [GeForce GTX 1650 SUPER] (rev a1)`
        
        - This is the ouput you are looking for

        01:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU116 [GeForce GTX 1650 SUPER] (rev a1)
        Now check the firmware revision its on by typing 

                ndvidia-smi

        - you should get an ouput like this

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

   2. So to find the correct drivers select from the dropdown. Againb using my Geoforce 970 as an example

        Product Type: Geoforce (whoever manufacters your GPU)
        Product Series: Geoforce 900 Series (make sure you are not selecting the M unless your on a laptop)
        Product Geoforce GTX 970 (Select what model of graphics card you have for your GPU)
        Operating System: LINUX 64BIT        
        Download Type: 
        
        **(Important)**  Select Linux Short Lived if your graphics card is a bit older.WHEN I SAY OLDER I MEAN 2 YEARS OR LESS.
        **(Important)**  Select Linux Long Lived if your NVIDIA CARD IS FAIRLY NEW.       
        - Click Search. This will automatically tell you your most updated driver you will need. Write or type this out somewhere so you can access it later.

###  Patching Your NVIDIA Driver

**This is extremely important. If you want to have more than 2 concurrent streams running on your jellyfin server i would HIGHLY Recommend patching your existing drivers below. If you are not going to have more than 2 consecutive streams running at once please skip to the Configuring Your Settings in Jellyfin.**
    
   1. Now go to this link for patching the drivers.   [NVIDIA Github patch](https://github.com/keylase/nvidia-patch) 

   2. Scroll Down to the versions table or type in browser CTRL + F. Then type in your browser window for your drive
        - IE. Geoforce GTX 970 = 432.21 (it showed us the driver on nvidias website)
     
   3. Once youve located your correct driver hover over the driver link with your mouse right click the link and copy the link location.

   4. **(Important) YOU NEED TO RUN THESE COMMANDS IN CLI NOT IN YOUR DESKTOP TERMINAL** 
        - To do this you need to go out of GUI(Desktop Enviroment) and into CLI(kernal recovery terminal). 
        - So you do this by Pressing CTRL+ALT+F1 (Some people DE(desktop enviroment) will already be on F1 so change it to any other F#

   5. Now your should see a terminal login with your user
        - IE. my user is `devilscoder`      
        - so i login with user `devilscoder` and the password associated with it.

   6. Now make the this directory and navigate to it by sending this command.
   
                sudo mkdir /opt/nvidia && cd /opt/nvidia

   7. Now you need to download the correctly update driver from the command posted below
       
                sudo wget https://international.download.nvidia.com/XFree86/Linux-x86_64/(driver firmware number)/NVIDIA-Linux-x86_(driver firmware number).run
        
        - IE if my drivers firmware revision is 335.21 that you found on the nvidia driver search on hte nvidia website. So mine would look like this
        
                sudo wget https://international.download.nvidia.com/XFree86/Linux-x86_64/435.21/NVIDIA-Linux-x86_64-435.21.run`

   8. Now you need to give them permissions.
                `sudo chmod +x ./NVIDIA-Linux-x86_64-(driver firmware number).run`
   9.Now you need to run the driver installer.

                ./NVIDIA-Linux-x86_64-430.50.run

   10. Make sure the new drivers is installed and recognized by typing in
                `nvidia-smi`

   11. Once the driver is installed you now need to install and patch the driver with the patch file downloaded from the github.

        Navigate to your users Home Directory either by using        
               
               `cd ~/`
                
        - or
                `cd /home/(your username)`
                
        - Now run
        
                `sudo git clone https://ipfs.io/ipns/Qmed4r8yrBP162WK1ybd1DJWhLUi4t6mGuBoB9fLtjxR7u nvidia-patch`
                
        - Finally run
        
                `bash ./patch.sh`
    
   12. Now it should display succesfully patched. Now that everythings done you can restart xServer or whatever you were using for DE (Desktop Enviroment)    
        - To start your xserver run    
                `startx`
        - Your Desktop Enviroment should then display login and move your way to your jellyfin install in browser
            
###  Configuring Your Settings in Jellyfin
   1. Open up your jellyfin Web UI by typing in one of the following domains.        
        - ie. (internal ip adress of server):8096 ie. 192.168.1.155:8096
        - ie. (if your on the computer where jellyfin is installed)       http://localhost:8096 
        - ie. (if you have a reverse-proxy running) https://sub.yourdomain.com        https://stream.jellyfin.com

   2. Once there click on the top left hamburger menu and click on dashboard in the menu
        So because these are enabled please write them down somewhere.
   3. Once Loaded click on the hamburger menu again and select playback
   
   4. Now Open this link [NVENC/DECODING SETTINGS FOR GPU](https://developer.nvidia.com/video-encode-decode-gpu-support-matrix#Encoder)   
        - Once there if your card is 2 years or older it will most likely not have NVENC (NVIDIA ENCODING) on the card. So lets go  scroll to the bottom and select the green button that says Geoforce/Titan becuase mine in this example is a Geoforce GTX 970.
        - Now it should pull up more graphics card. Hit the key combinations CTRL + F and type your graphics card so im going to type 970. The page will take you to your card and now check the settings mine has these decoding features.
                `MPEG-1   YES      MPEG-2   YES      VC-1   YES      H.264(AVCHD)   YES`
        - So because these are enabled please write them down somewhere.
   
   5. Now go back to Jellyfin and click the first dropdown menu and select Nvidia NVENC

   6. Then enable only those options. That you wrote down in step 19. So Since my card does not encoding i need to disable anything with encoding in the options if you dont bascically you wont be able to watch your videos on your Jellyfin server.
    
   7. Click on save at the bottom and check if they stuck by hitting on your keyboard CTR + F5 this should clear cache and refresh your page. Now if you settings stuck on the playback page. Great Enjoy! IF NOT YOU NEED TO DOUBLE CHECK YOUR COMPATIBILITY WITH NVENC DECODING/ENCODING. The only way the settings wont stick is if your device is incompatible. So it says nope i dont like those settings and automatically reverts the changes to not harm your system.
