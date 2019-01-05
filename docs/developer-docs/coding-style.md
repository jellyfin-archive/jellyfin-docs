# Jellyfin Code Style Guide

## General style

* Ensure all new files start with the `new-file-header.txt` file in the root of the repository; this ensures all files are explicitly licensed.

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
