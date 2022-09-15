---
uid: admin-install-synology
title: Installing on Synology
---

# Installing on Synology

For [Synology](https://www.synology.com/en-us/dsm), Jellyfin is installed using Docker.

![Installing Synology](~/images/install-synology-1.png)

![Installing Synology](~/images/install-synology-2.png)

![Installing Synology](~/images/install-synology-3.png)

Create the container.

![Installing Synology](~/images/install-synology-4.png)

![Installing Synology](~/images/install-synology-5.png)

Use Advanced Settings to add mount points to your media and config.

![Installing Synology](~/images/install-synology-6.png)

![Installing Synology](~/images/install-synology-7.png)

Host Mode is required for HdHR and DLNA. Use bridge mode if running multiple instances.

![Installing Synology](~/images/install-synology-8.png)

![Installing Synology](~/images/install-synology-9.png)

Browse to `http://SERVER_IP:8096` to access the web client.

**Note on Hardware Acceleration **

If you want to use Hardware Acceleration, check the "Execute container using high privledge" box either during container setup, or after, when the container is stopped, but using the "edit" button in the Docker interface:
![image](https://user-images.githubusercontent.com/19777571/190295042-76d9997b-f9f9-4135-ae0d-18d368418bed.png)


