import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

import '../models/video.dart';

///[Video Manager] manages all the video operations
class VideoManager with ChangeNotifier {
  List<AssetEntity> _allVideos = [];
  List<Video> _modelVideos = [];
  List<Video> _mVideos = [];

  ///return all videos as in raw form
  List<AssetEntity> get allVideos {
    return [..._allVideos];
  }

  ///return all vidoes in [Video] form
  List<Video> get modelVideos {
    return [..._modelVideos];
  }

  ///[fetchMedia] used to get video data from local device
  Future<void> fetchMedia() async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      //load all file paths to videos
      List<AssetPathEntity> videos = await PhotoManager.getAssetPathList(
          onlyAll: true, type: RequestType.video);

      print('VideoManager: All videos path gotten = $videos');
      print('VideoManager: Value = ${videos[0].assetCount}');

      //get all the videos
      //using videos[0] because it contains all the videos while other indexes contain grouped videos
      List<AssetEntity> allVideos =
          await videos[0].getAssetListPaged(0, videos[0].assetCount);
      print('VideoManager: All videos extracted = $allVideos');

      //package the data gotten
      for (var video in allVideos) {
        _mVideos.add(Video(
          videoTitle: video.title,
          videoDuration: _getTime(video.duration),
          videoData: video.file,
          videoCreationTime: _getFormattedDate(video.createDateTime.toString()),
          videoPath: _getFormattedPath(video.relativePath),
        ));

        print('VideoManager: video title = ${video.title}');
        print('VideoManager: video duration = ${video.duration.toString()}');
        print('VideoManager: video file gotten = ${video.file != null}');
        print('Video Manager: video creation time = ${video.createDateTime}');
        print('Video Manager: video path = ${video.relativePath}');
      }

      _allVideos = allVideos;
      _modelVideos = _mVideos;
    } else {
      //result failed
      PhotoManager.openSetting();
    }

    notifyListeners();
  }

  //get formmatted time
  String _getFormattedDate(String dateTime) {
    var time = dateTime.split('.')[0];
    var formattedTime = time.replaceAll(' ', 'at ');
    print('Created on: $formattedTime');

    return formattedTime;
  }

  //get formatted path
  String _getFormattedPath(String val) {
    var storedPath = val;
    if (val.contains('/storage/emulated/0/')) {
      storedPath =
          storedPath.replaceAll('/storage/emulated/0/', 'Internal Storage > ');
    } else {
      var breaker = val.split('/');
      var location = breaker[breaker.length - 1];
      storedPath = 'SD Card > $location';
    }

    print('VideoManager: Video location = $storedPath');

    return storedPath;
  }

  //get a formatted string of the time for each video
  String _getTime(int inputTime) {
    var timeInSecs = 0;
    var timeInMins = 0;
    var timeInHrs = 0;

    var hrStr = '';
    var minsStr = '';
    var secsStr = '';

    var formattedStr = '';

    if (inputTime < 60) {
      timeInSecs = inputTime % 60;
      secsStr = '${timeInSecs}s';
    } else if (inputTime > 60 && inputTime < 3600) {
      timeInMins = inputTime ~/ 60;
      minsStr = '${timeInMins}m';
      timeInSecs = inputTime % 60;
      secsStr = '${timeInSecs}s';
    } else {
      timeInHrs = (inputTime ~/ 3600);
      hrStr = '${timeInHrs}h';
      var remainder = inputTime % 3600;
      timeInMins = remainder ~/ 60;
      minsStr = '${timeInMins}m';
      timeInSecs = remainder % 60;
      secsStr = '${timeInSecs}s';
    }

    formattedStr = ('$hrStr $minsStr $secsStr').trim();
    print('VideoManager: Formatted video time = $formattedStr');

    return formattedStr;
  }
}
