---
uid: codecs
title: Codec Compatibility
---

 # [Codec Tables](https://en.wikipedia.org/wiki/List_of_codecs "Wikipedia's list of all codecs")
 
 The goal is to DirectPlay all media. This means the container, video, audio and subtitles are all compatible with the client. DirectStream will occur if the audio, container or subtitles happen to not be supported. Subtitles can be tricky because they can cause DirectStreaming (subtitles are remuxed) or video transcoding (burning in subtitles) to occur. If the video codec is unsupported, this will result in video transcoding. This is the most intensive CPU component of transcoding. Decoding is less intensive than encoding.
 
## [Video Compatibility](https://en.wikipedia.org/wiki/Comparison_of_video_container_formats "Wikipedia's video codec tables")

||Browser|Android|AndroidTV|Kodi|[Roku](https://developer.roku.com/docs/specs/streaming.md)|
|:---:|:---:|:---:|:---:|:---:|:---:|
|[MPEG4 ASP](https://en.wikipedia.org/wiki/MPEG-4_Part_2)<sup>4</sup>|❌|❌|❌|✅|✅|
|[H.262/DivX](https://en.wikipedia.org/wiki/DivX)|✅|✅|✅|✅|✅|
|[H.264/AVC](https://caniuse.com/#feat=mpeg4 "H264 Browser Support Reference")|🔶<sup>3</sup>|✅|✅|✅|✅|
|[H.265/HEVC](https://caniuse.com/#feat=hevc "HEVC Browser Support Reference")|❌<sup>1</sup>|🔶<sup>2</sup>|❌|✅|❌|

<sup>1</sup>HEVC support is potentially possible by offloading to the OS. *untested*

<sup>2</sup>Android playback is currently broken. Client reports that HEVC is supported and attempts to Directstream it.

<sup>3</sup>H.264 10Bit is unsupported.

<sup>4</sup>This is the codec format for Xvid encodes.

## [Audio Compatibility](https://en.wikipedia.org/wiki/Comparison_of_video_container_formats#Audio_coding_formats_support "Wikipedia's audio codec tables")

If the audio codec is unsupported or incompatible (such as playing a 5.1 channel stream on a stereo device), the audio codec must be transcoded. This is not nearly as intensive as video coding.

||Browser|Android|AndroidTV|Kodi|Roku|
|:---:|:---:|:---:|:---:|:---:|:---:|
FLAC|✅|✅|✅|✅|✅|
|MP3|🔶<sup>1</sup>|✅|✅|✅|✅|
|AAC|🔶<sup>2</sup>|✅|✅|✅|✅|
|AC3|✅|❌|✅|✅|✅|
|EAC3<sup>3/sup>|✅|✅|✅|✅|✅|
|VORBIS|❌|✅|✅|✅|✅|
|DTS<sup>4</sup>|❌|❌|❌|✅|✅|

<sup>1</sup>MP3 Mono is incorrectly reported as unsupported and will transcode to AAC.

<sup>2</sup> AAC is incorrectly reported as unsupported and will transcode to MP3.

<sup>3</sup>Only EAC3 2.0 has been tested.

<sup>4</sup> Only DTS Mono has been tested.

## [Subtitle Compatibility](https://en.wikipedia.org/wiki/Comparison_of_video_container_formats#Subtitle/caption_formats_support "Wikipedia's subtitle codec tables")

Subtiles can be a subtle issue for transcoding. Containers have a limited number of subtitles that are supported. If subtitles need to be transcoded, it will happen one of two ways. They can be converted into another supported format (text-based subtitles) or burned into the video (image/lossless based and ASS based) due to the subtitles transcoding not being supported. This is the most intenstive method of transcoding due to two transcodings happening at once; applying the subtitle layer on top of the video layer. 

||Format|TS|MP4|MKV|AVI|
|:---:|:---:|:---:|:---:|:---:|:---:|
|SubRip Text (SRT)|Formatted Text|❌|🔶|✅|🔶|
|ASS/SSA<sup>1</sup>|Formatted Text|❌|❌|✅|🔶|
|VobSub|Picture|❌|✅|✅|🔶|
|DVB-SUB|Picture|✅|❌|✅|❌|
|MP4TT/TXTT|XML|❌|✅|❌|❌|
|PGSSUB|Picture|❌|❌|✅|❌|


<sup>1</sup>ASS Subtitles are only supported by mkv files. Mkv files can't natively be streamed therefore ASS subtitles will always inherently be burned into the video. This is not a limitation of JF. 

## [Container Compatibility](https://developer.mozilla.org/en-US/docs/Web/Media/Formats/Containers)

If the container is unsupported, this will result in remuxing. The video and audio codec will remain intact, but wrapped in a container that is supported. This is the least intensive process. Most video containers will be remuxed to use the hls streaming protocol and ts containers. Remuxing shouldn't be a concern even for a Rpi3.

||Browser|Android|AndroidTV|Kodi|Roku
|:---:|:---:|:---:|:---:|:---:|:---:
|[MP4](https://en.wikipedia.org/wiki/MPEG-4_Part_14)<sup>1</sup>|✅|✅|✅|✅|✅
|[MKV](https://en.wikipedia.org/wiki/Matroska)<sup>2, 3</sup>|❌|✅|🔶|✅|🔶
|[TS](https://en.wikipedia.org/wiki/MPEG_transport_stream)|✅|✅|✅|✅|✅
|[webM](https://en.wikipedia.org/wiki/WebM)<sup>3</sup>|||||

<sup>1</sup>MP4 containers are one of the few containers that will not remux.

<sup>2</sup>MKV containers can hold nearly any codec, but are not compatible with streaming in browsers and will remux.

<sup>3</sup>MKV containers are improperly labeled as webM during playback. 
