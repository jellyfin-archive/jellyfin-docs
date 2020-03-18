---
uid: clients-kodi
title: Installing Kodi Add-On
---

# Installing Kodi Add-On

> [!NOTE]
> It's highly recommended to install the `Kodi Sync Queue` plugin into the Jellyfin server as well.
> This will keep your media libraries up to date without waiting for a periodic re-sync from Kodi.


## Installation Process

### Install Add-On Repository

The recommended install method is to use the official Jellyfin add-on repository.  This allows for easy install of the Jellyfin for Kodi add-on, as well as automatically keeping the add-on up to date with the latest version.  Any other Jellyfin related add-ons that may be built in the future will also be available in this repository.

The installation method for the repository varies depending on what kind of device you're using, outlined below.

#### General Use Devices (PCs and Tablets)

1. Download the repository installer found [here](https://repo.jellyfin.org/releases/client/kodi/repository.jellyfin.kodi.zip).
    * It will be saved as `repository.jellyfin.kodi.zip`
2. Install the Jellyfin repository.
    * Open Kodi, go to the settings menu,  and navigate to "Add-On Browser"
    * Select "Install from Zip File"
        * If prompted, enter settings and enable "Unknown Sources", then go back to the Add-On Browser
    * Select the newly downloaded file and it will be installed
3. Proceed to [Install Jellyfin for Kodi Add-On](xref:clients-kodi#install-jellyfin-for-kodi-add-on)

#### "Embedded" Devices (Android TV, Firestick, and other TV Boxes)

1. Open Kodi, go to the settings menu, and navigate to "File manager"
    * Select "Add source"
    * In the text box, enter `https://repo.jellyfin.org/releases/client/kodi/`
    * Enter a name for the data source, such as "Jellyfin Repo" and select Ok
2. From the settings menu, navigate to "Add-On Browser"
    * Select "Install from Zip File"
        * If prompted, enter settings and enable "Unknown Sources", then go back to the Add-On Browser
    * Select the data source you just added
    * Install `repository.jellyfin.kodi.zip`
3. Proceed to [Install Jellyfin for Kodi Add-On](xref:clients-kodi#install-jellyfin-for-kodi-add-on)

### Install Jellyfin for Kodi Add-On

1. Install Jellyfin for Kodi.
    * From within Kodi, navigate back to "Add-On Browser"
    * Select "Install from Repository"
    * Choose "Kodi Jellyfin Addons", followed by "Video Add-ons"
    * Select the Jellyfin add-on and choose install
2. Within a few seconds you should be prompted for your server details.
    * If a Jellyfin server is detected on your local network, it will displayed in a dialog
    * If a Jellyfin server is not detected on your local network, select "Manually Add Server".  Enter your server info into the text field.
        * Enter the server name or IP address and the port number (default value is 8096)
            * Host: `192.168.1.10:8096`
        * If using SSL and a reverse proxy, enter the full URL in the "Host" field
            * Host: `https://jellyfin.example.com`
        * Note that if you have a baseurl set, you should append that value to the end of the host field.
            * Host: `192.168.0.10:8096/jellyfin`
    * Select user account and input password, or select "Manual Login" and fill in your user infomation
3. Once you're succesfully authenticated with the server, you'll be asked about which mode you'd like to use, Add-on vs Native, which are outlined below.

#### Add-on Mode

Add-on mode uses the Jellyfin server to translate media files from the filesystem to Kodi.  This is the default setting for the add-on, and is sufficient for most use cases.  It will work both on the local network and over the Internet through a reverse proxy or VPN connection.  Providing network speed is sufficient, Kodi will direct play nearly all files and put little overhead on the Jellyfin server.  Exceptions to this rule are files with 7.1 audio tracks and some 4k content, which will be transcoded by the server.

To use Add-on mode, simply choose "Add-on" at the dialog and proceed to [Library Syncing](xref:clients-kodi#library-syncing)

#### Native Mode

Native mode accesses your media files directly from the filesystem, bypassing the Jellyfin server during playback.  Native mode needs more setup and configuration, but it can lead to better performance as everything will direct play no matter what format or encoding is used.  It requires your media to be available to the device Kodi is running on over either NFS or Samba, and therefore should only be used on a LAN or over a VPN connection.

To use Native mode, first set up your libraries in Jellyfin with a remote path.

1. In the Jellyfin server, navigate to the Libraries section of the admin dashboard.
    * Select an existing library (or create a new one)
    * Select the media folder
    * Enter the path to your network share in the "Shared network folder" textbox
    * Possible formats:
        * NFS
            * `nfs://192.168.0.10:/path/to/media`
        * Samba
            * Guest User - `\\192.168.0.10\share_name`
            * Custom User (Not Recommended) - `\\user:password@192.168.0.10\share_name`
                * It's more secure to use the generic Guest mapping here and specify credentials from within Kodi
2. Configure libraries in Kodi
    * Skip the initial library selection.  We need to add file shares to Kodi first
    * Within Kodi, navigate to the settings menu and select "File manager"
    * Select "Add source"
    * Select "Browse" and "Add network location"
    * Create either a NFS or SMB location from the selection box and fill in the necessary information about your network share
    * Select your newly created location and choose "Ok"
    * Give your media source a name and choose "Ok"
    * Go to Add-Ons -> Jellyfin -> Manage Libraries -> Add Libraries
3. Proceed to [Library Syncing](xref:clients-kodi#library-syncing)

### Library Syncing

This screen allows you to choose which libraries to sync to your Kodi install.  This process will copy metadata for your media into the local Kodi database, allowing you to browse through your media libraries as if they were native to your device.

Either choose "All" or select individual libraries you'd like synced, and select OK.  Syncing the metadata will start automatically.  The duration of this process varies greatly depending on the size of your library, the power of your local device, and the connection speed to the server.

You can still access any libraries that haven't been synced by going through the Jellyfin add-on menu.  These unsynced libraries will be labeled as "dynamic."

If an error occurs during syncing, enable debug logging in the Jellyfin add-on in Kodi and if in a Unix-like OS, set the **log level** of Samba to 2 to see if there are issues authenticating.

### Multiple User Accounts

The Jellyfin for Kodi addon doesn't natively handle multiple user accounts.  Fortunately, Kodi has a built in method of handling this called profiles.  Information about this can be found on the Profiles page of the [Kodi Wiki](https://kodi.wiki/view/Profiles).  Once profiles have been created, you must install the Jellyfin add-on and go through the installation steps above for each user profile.  When you switch Kodi profiles, you will also switch Jellyfin users. You can tell Kodi to bring you to a profile login screen during startup by going to the Profiles section inside of the Settings page and checking the box for "Show login screen on startup."

> [!NOTE]
> Kodi's default skin does not display all unicode characters. To display unicode characters the skin's font must be changed.

