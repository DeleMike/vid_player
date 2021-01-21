import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

import '../models/video.dart';

///[Video Manager] manages all the video operations 
class VideoManager with ChangeNotifier{
  List<AssetEntity> _allVideos = [];
  List<Video> _modelVideos = [];
  List<Video> _mVideos = [];

  List<AssetEntity> get allVideos {
    return [..._allVideos];
  }

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

      print('\nAllVideosScreen: All videos path gotten = $videos');
      print('\nAllVideosScreen: Value = ${videos[0].assetCount}');

      //get all the videos
      //using videos[0] because it contains all the videos while other indexes contain grouped videos
      List<AssetEntity> allVideos =
          await videos[0].getAssetListPaged(0, videos[0].assetCount);
      print('\nAllVideosScreen: All videos extracted = $allVideos');

      //package the data gotten
      for (var video in allVideos) {
        _mVideos.add(Video(
          videoTitle: video.title,
          videoDuration: _getTime(video.duration),
          videoData: video.file,
        ));

        print('\nAllVideosScreen: video title = ${video.title}');
        print(
            '\nAllVideosScreen: video duration = ${video.duration.toString()}');
        print('\nAllVideosScreen: video file gotten = ${video.file != null}');

         print('Video Manager: video creation time = ${video.createDateTime}');
        print('Video Manager: video path = ${video.relativePath}');
        print('Video Manager: video path = ${video.size}');
      }
     
        _allVideos = allVideos;
        _modelVideos = _mVideos;
      
    } else {
      //result failed
      PhotoManager.openSetting();
    }

    notifyListeners();
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
      // print('Log: timeInSecs = $timeInSecs');

    } else if (inputTime > 60 && inputTime < 3600) {
      timeInMins = inputTime ~/ 60;
      minsStr = '${timeInMins}m';
      // print('Log: timeInMins = $timeInMins');
      timeInSecs = inputTime % 60;
      secsStr = '${timeInSecs}s';
      // print('Log: timeInSecs = $timeInSecs');
    } else {
      timeInHrs = (inputTime ~/ 3600);
      hrStr = '${timeInHrs}h';
      var remainder = inputTime % 3600;
      timeInMins = remainder ~/ 60;
      minsStr = '${timeInMins}m';
      timeInSecs = remainder % 60;
      secsStr = '${timeInSecs}s';
      // print('Log: timeInHrs = $timeInHrs');
      // print('Log: timeInMins = $timeInMins');
      // print('Log: timeInSecs = $timeInSecs');
    }

    formattedStr = ('$hrStr $minsStr $secsStr').trim();

    return formattedStr;
  }
}