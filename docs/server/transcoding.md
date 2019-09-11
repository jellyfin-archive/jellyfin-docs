## Transcoding

These settings will relate to backend options that modify how the server transcodes media. Some improve or change the media quality while others reduce the resources required to transcode the media from its original format.

#### Hardware Acceleration

If your hardware supports this you can enable [hardware acceleration](/docs/administration/hardware-acceleration.md) for much faster transcoding. Some of the supported methods are listed below.

  * VAAPI
  * NVENC

#### Thread Count

This option will manually set the amount of threads to use when transcoding. If you're not using the server for anything else it's best to leave this option alone.
