---
uid: contrib-branding
title: Branding
---

# Branding

## Naming Conventions

The general rule is: Capitalize it, but language, file, or system conventions trump Jellyfin naming conventions.

Specific examples include:

* Writing referring to the project in the abstract should use capitalized `Jellyfin` at all times. `I contribute to Jellyfin and you should too!`
* C# class and project names, including their files and directories, should use capitalized `Jellyfin` as required by the C# case standards (camelCase or PascalCase). `Jellyfin.LiveTv`, `Jellyfin.sln`
* Other code elements, where the code formatting or style requires lowercase, should use lowercase `jellyfin`. `jellyfinWebComponentsBowerPath`
* The Git repository and non-C# files inside of it should use lowercase `jellyfin` for convenience on case-sensitive filesystems. `build-jellyfin.ps1`
* The final output binary, initscrips, and package names should use lowercase `jellyfin` for similar reasons as above. `jellyfin.dll`, `jellyfin_3.5.2-1_all.deb`, `jellyfin.zip`
* Configuration directories can use either depending on operating system conventions. `/var/lib/jellyfin`, `AppData/Jellyfin`
* The logo has no strict rules for capitalization, the style is dependent on aesthetics and font choice.

## Icons and Other Assets

All iconography and other resources can be found in the [jellyfin-ux](https://github.com/jellyfin/jellyfin-ux) repository.

* Icons
* Banners
* Fonts

### Logo

The design for the logo uses a gradient for the infill, and if the non-transparent logo is chosen there is an optional background color.

* Gradient Start: `#AA5CC3`
* Gradient End: `#00A4DC`
* Background Colour: `#000B25`

### Theme

* Background Colour: `#101010`
* Accent Colour: `#00A4DC`

### Fonts

The banner uses the [Quicksand](https://fonts.google.com/specimen/Quicksand) font.
