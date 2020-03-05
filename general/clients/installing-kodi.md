---
uid: clients-installing-kodi
title: Installing Kodi
---

# Installing Kodi

## Installation Process

1. Download the repository installer [here](https://repo.jellyfin.org/releases/client/kodi/repository.jellyfin.kodi.zip).
    * It will be saved as `repository.jellyfin.kodi.zip`
2. Install the Jellyfin repository.
    * Open Kodi and navigate to "Add-On Browser"
    * Select "Install from Zip File"
        * If prompted, enter settings and enable "Unknown Sources", then go back
    * Select the newly downloaded file and it will be installed
3. Install Jellyfin for Kodi.
    * From within Kodi, navigate back to "Add-On Browser"
    * Select "Install from Repository"
    * Choose "Kodi Jellyfin Addons"
    * "Video Add-ons"
    * Select the Jellyfin add-on and choose install
4. Within a few seconds you should be prompted for your server details.
    * If a Jellyfin server is detected on your local network, it will displayed in a dialog
    * If a Jellyfin server is not detected on your local network, select "Manually Add Server"
        * Note that if you have a baseurl set, you should append that value to the end of the host field. (`192.168.0.10:8096/jellyfin`)
        * Enter the server name or IP address and the port number (default value is 8096)
            * Host: `192.168.1.10:8096`
        * If using SSL and a reverse proxy, enter the URL in the "Host" field
            * Host: `https://jellyfin.example.com`
    * Select user account and input password
5. Once you're succesfully authenticated with the server, you'll be asked about your preferences for this device.
    * Choose your preferences for each options
      * Add-On mode requires no additional configuration
      * To get Native mode to work skipping the initial import is necessary, so stop here and skip to **Native Mode Configuration**
    * Select "Proceed" to configure libraries
    * Select the libraries you would like to keep synced with this device
6. The first sync of the server to the local Kodi database may take some time depending on your device and library size.
7. Once the full sync is done you can browse and play your media through Kodi, and syncs will be done periodically in the background.

### Native Mode Configuration

The benefit of Native mode over Add-On mode is that nothing will be transcoded, currently Add-On mode doesn't support audio with more than 5.1 channels, which means no Dolby Atmos or DTS-X. Since no transcoding happens, files play instantly.

1. You need to delete and re-add your libraries on your Jellyfin server in order to set the **Optional Network Path** to your share locations if you haven't already done so previously, SMB/Samba is preferred, and **must be in the Windows format** using backslashes, *even if both the client and server are using Unix-like OSes*, for example **\\\192.168.1.7\movies**, wait for the import to finish on the server.
2. If using a Unix-like OS you must create a local user and Samba user named **guest** (with no password) on your server and allow guest only access to your shares, if using Windows this may already be done for you by default. Alternatively, a user-password combination can be provided in the the **\\\\username:password@host\share** format.
3. Add in your SMB/Samba shares into Kodi like you normally would when not using the Jellyfin plugin, setting the content type, but it is not necessary to import that data since this will be handled by the Jellyfin plugin.
4. Select your libraries to add in using the Jellyfin plugin's menu, proceed to import your library.
5. Your files should now be accessible in Kodi and function the same way as Add-On mode, if not, enable debug logging in the Jellyfin plugin in Kodi and if in a Unix-like OS, set the **log level** of Samba to 2 to see if there are issues authenticating.

> [!NOTE]
> It's recommended to install the `Kodi Sync Queue` plugin into the Jellyfin server as well.

This will help keep your media libraries up to date without waiting for a periodic re-sync from Kodi.

> [!NOTE]
> Kodi's default skin does not display all unicode characters. To display unicode characters the skin's font must be changed.
