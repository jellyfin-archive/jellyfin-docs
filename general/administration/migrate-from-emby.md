---
uid: admin-migrate-from-emby
title: Migrating from Emby
---

# Migrating from Emby to Jellyfin

Direct database migration from Emby (of any version) to Jellyfin is NOT SUPPORTED. We have found many subtle bugs due to the inconsistent database schemas that result from trying to do this, and strongly recommend that all Jellyfin users migrating from Emby start with a fresh database and library scan.

The original procedure is provided below for reference however we cannot support it nor guarantee that a system upgraded in this way will work properly, if at all. If anyone is interested in writing a database migration script which will correct the deficiencies in the existing database and properly import them into Jellyfin, [we would welcome it however](xref:contrib-index)!

## Unofficial procedure

~~Jellyfin offers a seamless migration from Emby version 3.5.2 or earlier. Emby versions 3.5.3 or 3.6+ cannot be easily migrated, and we recommend rebuilding your library instead.~~

Windows users may take advantage of the `install-jellyfin.ps1` script in the [Jellyfin repository](https://github.com/jellyfin/jellyfin) which includes an automatic upgrade option.

This procedure is written for Debian-based Linux distributions, but can be translated to other platforms by following the same general principles.

1. Upgrade to Emby version 3.5.2, so that the database schema is fully up-to-date and consistent. While this is not required, it can help reduce the possibility of obscure bugs in the database.

1. Stop the `emby-server` daemon:  
    `sudo service emby-server stop`

1. Move your existing Emby data directory out of the way:  
    `sudo mv /var/lib/emby /var/lib/emby.backup`

1. Remove or purge the `emby-server` package:  
    `sudo apt purge emby-server`

1. Install the `jellyfin` package using the [installaton instructions](xref:admin-installing).

1. Stop the `jellyfin` daemon:  
    `sudo service jellyfin stop`

1. Copy over all the data files from the Emby backup data directory:  
    `sudo cp -a /var/lib/emby.backup/* /var/lib/jellyfin/`

1. Correct ownership on the new data directory:  
    `sudo chown -R jellyfin:jellyfin /var/lib/jellyfin`

1. Start the `jellyfin` daemon:  
    `sudo service jellyfin start`
