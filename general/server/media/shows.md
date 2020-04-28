---
uid: server-media-shows
title: Shows
---

# Shows

The most common naming scheme for shows is categorizing the files by series and then season. Another common method is simply using series folders, especially for shows that are organized by air date and those without seasons.

```txt
/Shows
    /Series
        /Season 01
            Episode S01E01.mkv
            Episode S01E02.mkv
        /Season 02
            Episode S02E01.mkv
            Episode S02E02.mkv
    /Series
        Episode S01E01.mp4
        Episode S01E02.mp4
        Episode S02E01.mp4
        Episode S02E02.mp4
```

> [!NOTE]
> Season folders shouldn't contain the series name, otherwise Jellyfin can in certain cases (Stargate SG-1 due to the dash and one, for instance) misdetect your episodes and put them all under the same season.
