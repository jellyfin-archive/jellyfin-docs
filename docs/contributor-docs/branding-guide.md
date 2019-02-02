# Jellyfin Branding Guide

## Naming Conventions

The general rule is: Capitalize it, but language, file, or system conventions trump Jellyfin naming conventions.

Specific examples include:

* Writing referring to the project in the abstract should use capitalized `Jellyfin` at all times. `the Jellyfin Project seeks to`, `I contribute to Jellyfin and you should too!`
* C# class and project names, including their files and directories, should use capitalized `Jellyfin` as require by the C# case standards (camelCase or PascalCase). `Jellyfin.LiveTV`, `Jellyfin.sln`,
* Other code elements, where the code formatting or style requires lowercase, should use lowercase `jellyfin`. `jellyfinWebComponentsBowerPath`
* The Git repository and non-C# files inside of it should use lowercase `jellyfin` for convenience on case-sensitive filesystems. `build-jellyfin.ps1`
* The final output binary, initscrips, and package names should use lowercase `jellyfin` for similar reasons as above. `jellyfin.dll`, `jellyfin_3.5.2-1_all.deb`, `jellyfin.zip`
* Configuration directories can use either, depending on operating system conventions. `/var/lib/jellyfin`, `AppData/Jellyfin`
* The logo may use either, depending on aesthetics and font choice.

## Jellyfin UX Repository

All Jellyfin iconography and other resources can be found in the [jellyfin-ux repository](https://github.com/jellyfin/jellyfin-ux).

This repository contains:

* SVG files for icons
* SVG files for banners
* PNG files of icons and banners
* Fonts

## Jellyfin Colours

These are the colours used for the Jellyfin logos and other places throughout the interface.

### Logo Colours

The design for the logo uses a gradient for the infill, and if the non transparent logo is chosen there is a background colour which is optional.

* Gradient Start: #AA5CC3
* Gradient End: #00A4DC
* Background Colour: #000B25

### Interface Colours

* Background Colour: #101010
* Accent Colour: #00A4DC

## Jellyfin Fonts

The banner uses the font [Quicksand](https://fonts.google.com/specimen/Quicksand).
