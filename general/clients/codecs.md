---
uid: codecs
title: Codec Compatibility
---

 # [Codec Tables](https://en.wikipedia.org/wiki/List_of_codecs "Wikipedia's list of all codecs")
## [Video Compatibility](https://en.wikipedia.org/wiki/Comparison_of_video_container_formats "Wikipedia's video codec tables")

If the video codec is unsupported, this will result in transcoding. This is the most intensive CPU component of transcoding. Decoding is less intensive than encoding.

||WebOS|Android|AndroidTV|Kodi|Roku|
|:---:|:---:|:---:|:---:|:---:|:---:|
|[H.262/Xvid](https://en.wikipedia.org/wiki/MPEG-4_Part_2)|✅|✅|✅|✅|✅|
|[H.262/DivX](https://en.wikipedia.org/wiki/DivX)|✅|✅|✅|✅|✅|
|[H.264/AVC](https://caniuse.com/#feat=mpeg4 "H264 Browser Support Reference")|✅|✅|✅|✅|✅|
|[H.265/HEVC](https://caniuse.com/#feat=hevc "HEVC Browser Support Reference")|❌<sup>1</sup>|🔶<sup>2</sup>|❌|✅|❌|

<sup>1</sup>HEVC support is potentially possible by offloading to the OS. *untested*

<sup>2</sup>Android playback is currently broken. Client reports that HEVC is supported and attempts to Directstream it.

## [Audio Compatibility](https://en.wikipedia.org/wiki/Comparison_of_video_container_formats#Audio_coding_formats_support "Wikipedia's audio codec tables")

If the audio codec is unsupported or incompatible (such as playing a 5.1 channel stream on a stereo device), the audio codec must be transcoded. This is not nearly as intensive as video coding.

||WebOS|Android|AndroidTV|Kodi|Roku
|:---:|:---:|:---:|:---:|:---:|:---:
|MP3|🔶<sup>1</sup>|✅|✅|✅|✅
|AAC|✅|✅|✅|✅|✅
|AC3|✅|✅|✅|✅|✅

<sup>1</sup>MP3 Mono is incorrectly reported as unsupported.

## [Subtitle Compatibility](https://en.wikipedia.org/wiki/Comparison_of_video_container_formats#Subtitle/caption_formats_support "Wikipedia's subtitle codec tables")

Subtiles can be a subtle issue for transcoding. Containers have a limited number of subtitles that are supported. If subtitles need to be transcoded, it will happen one of two ways. They can be converted into another supported format (text-based subtitles) or burned into the video (image/lossless based and ASS based) due to the subtitles transcoding not being supported. This is the most intenstive method of transcoding due to two transcodings happening at once; applying the subtitle layer on top of the video layer. 

## [Container Compatibility](https://developer.mozilla.org/en-US/docs/Web/Media/Formats/Containers)

If the container is unsupported, this will result in remuxing. The video and audio codec will remain intact, but wrapped in a container that is supported. This is the least intensive process, remuxing speed can be up to 10000x real time, remuxing + audio (ac3 2ch to aac 2ch) happened at 100x real time on the same sample.

||WebOS|Android|AndroidTV|Kodi|Roku
|:---:|:---:|:---:|:---:|:---:|:---:
|[mp4](https://en.wikipedia.org/wiki/MPEG-4_Part_14)|✅|✅|✅|✅|✅
|[MKV](https://en.wikipedia.org/wiki/Matroska)<sup>1, 2</sup>|❌|🔶|🔶|🔶|🔶
|[ts](https://en.wikipedia.org/wiki/MPEG_transport_stream)|❌|✅|✅|✅|✅


<sup>1</sup>MKV containers can hold nearly any codec. *support not verified, initial testing is showing that all containers convert to ts using hls streaming protocol* Mp4 successfully streamed using http protocol instead of hls protocol and did not remux.

<sup>2</sup>webm containers that have file extension mkv are marked as mkv on the media info page, and properly labeled as webm during playback. 
