---
uid: server-media-external-audio-files
title: External audio files
---

# External audio files

Audio will usually be embedded in video files, but the server also supports external audio files. Supported formats include m4a, aac, mp3 and mka files. Multiple audio streams in one mka file are also supported. Unsupported are strm files.

The server only scans local files.

## Naming

Jellyfin will search for audio files that exactly match the video filename. They can optionally include a language code which will only be used if the language cannot be determined from the audio file.

```txt
/Movies
    /Film (1946)
        Film.mkv
        Film.mka
        Film.de.m4a
```
