import 'dart:io';

import 'package:flutter/foundation.dart';

///[Video] models how a particular video object should look like and have in it.
class Video {
  ///[videoTitle] name of the video
  final String videoTitle;
  ///[videoDuration] video duration in minutes
  final String videoDuration;
  ///[videoData] video data
  final Future<File> videoData;
  ///[videoCreationTime] create time for video
  final String videoCreationTime;
  ///[videoCreationTime] video location on device
  final String videoPath; 

  Video({
    @required this.videoTitle,
    @required this.videoDuration,
    @required this.videoData,
    @required this.videoCreationTime,
    @required this.videoPath,
  });
}
