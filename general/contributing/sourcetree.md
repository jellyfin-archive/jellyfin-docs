---
uid: contrib-source
title: Source Tree
---

# Contributing to Jellyfin's Source Tree

The Jellyfin Source Tree is a maze of many projects. With Emby's old code and Jellyfin's new code intermixed together. To help with this, this Source Tree guide was created.

### [Jellyfin Server](https://github.com/jellyfin/jellyfin)
1.  BDInfo: `Blu-Ray Analyzer`
    - Properties: `Assembly Info`
2.  DvdLib: `DVD Anaylzer`
    - Ifo: 
    - Properties:
3.  Emby.Dlna: 
4.  Emby.Drawing:
5.  Emby.Naming:
6.  Emby.Notifications:
7.  Emby.Photos:
8.  Emby.Server.Implementations:
9.  Jellyfin.Api:
10. Jellyfin.Drawing.Skia:
11. Jellyfin.Server:
12. MediaBrowser.Api:
13. MediaBrowser.Common:
14. MediaBrowser.Controller:
15. MediaBrowser.LocalMetadata:
16. MediaBrowser.MediaEncoding:
17. MediaBrowser.Model:
18. MediaBrowser.Providers:
19. MediaBrowser.WebDashboard:
20. MediaBrowser.XbmcMetadata:
21. RSSDP:
22. benches/Jellyfin.Common.Benches:


### [Web Client](https://github.com/jellyfin/jellyfin-web)
1.  Src: 
    - components: `custom elements used for different sections of the user interface`
    - controllers: `scripts that handle the logic for different pages`
    - css:
    - img:
    - legacy: `currently used for all polyfills and scripts related to backwards compatibility`
    - libraries: `dependencies that we eventually want to remove and include during the build step`
    - scripts: `any script that isn't tied to a UI element or page but rather general functionality`
    - splashscreens:
    - strings: `translations for the entire interface`
    <br>Future Implementations:
    - assets: `images, styles, splash screens, and any other static assets`
    - elements: `custom UI components that are used globally such as buttons or menus`
    - themes: `all themes will exist in this folder, including custom themes at some point`
    
### [Android](https://github.com/jellyfin/jellyfin-android)
1. res:
   - android:
2. src:
   - NativeShell:
     - res:
     - src:
       - RemotePlayerService.java: `Remote Notifier such as for BlueTooth`
     - www:
   - cordova:
   
### [Android-tv](https://github.com/jellyfin/jellyfin-androidtv)
1. app:
   - src:
     - main:
       - assets/fonts:
       - java/org/jellyfin/androidtv:
       - res:
