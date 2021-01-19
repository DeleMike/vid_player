import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../models/video.dart';
import '../widgets/all_videos_grid.dart';
import '../screens/settings_screen.dart';
import '../providers/video_manager.dart';

///[AllVideosScreen] will display a grid of all videos on the user's device
class AllVideosScreen extends StatefulWidget {
  @override
  _AllVideosScreenState createState() => _AllVideosScreenState();
}

class _AllVideosScreenState extends State<AllVideosScreen> {
  List<AssetEntity> _allVideos = [];
  final videoManager = VideoManager();
  List<Video> _modelVideos = [];
  List<Video> _mVideos = []; 

  @override
  void initState() {
    super.initState();
     //_fetchMedia();
    _getVideoData();
  }

  void _getVideoData() async {
    final _vManager = Provider.of<VideoManager>(context, listen:false); 
    await _vManager.fetchMedia();
    setState(() {
      _allVideos = _vManager.allVideos;
    _modelVideos = _vManager.modelVideos;
    });
    
  }

  // void _fetchMedia() async {
  //   var result = await PhotoManager.requestPermission();
  //   if (result) {
  //     //load all file paths to videos
  //     List<AssetPathEntity> videos = await PhotoManager.getAssetPathList(
  //         onlyAll: true, type: RequestType.video);

  //     print('\nAllVideosScreen: All videos path gotten = $videos');
  //     print('\nAllVideosScreen: Value = ${videos[0].assetCount}');

  //     //get all the videos
  //     //using videos[0] because it contains all the videos while other indexes contain grouped videos
  //     List<AssetEntity> allVideos =
  //         await videos[0].getAssetListPaged(0, videos[0].assetCount);
  //     print('\nAllVideosScreen: All videos extracted = $allVideos');

  //     //package the data gotten
  //     for (var video in allVideos) {
  //       _mVideos.add(Video(
  //         videoTitle: video.title,
  //         videoDuration: _getTime(video.duration),
  //         videoData: video.file,
  //       ));

  //       print('\nAllVideosScreen: video title = ${video.title}');
  //       print(
  //           '\nAllVideosScreen: video duration = ${video.duration.toString()}');
  //       print('\nAllVideosScreen: video file gotten = ${video.file != null}');
  //     }

  //     //initialize the state data
  //     setState(() {
  //       _allVideos = allVideos;
  //       _modelVideos = _mVideos;
  //     });
  //   } else {
  //     //result failed
  //     PhotoManager.openSetting();
  //   }
  // }

  // String _getTime(int inputTime) {
  //   var timeInSecs = 0;
  //   var timeInMins = 0;
  //   var timeInHrs = 0;

  //   var hrStr = '';
  //   var minsStr = '';
  //   var secsStr = '';

  //   var formattedStr = '';

  //   if (inputTime < 60) {
  //     timeInSecs = inputTime % 60;
  //     secsStr = '${timeInSecs}s';
  //     // print('Log: timeInSecs = $timeInSecs');

  //   } else if (inputTime > 60 && inputTime < 3600) {
  //     timeInMins = inputTime ~/ 60;
  //     minsStr = '${timeInMins}m';
  //     // print('Log: timeInMins = $timeInMins');
  //     timeInSecs = inputTime % 60;
  //     secsStr = '${timeInSecs}s';
  //     // print('Log: timeInSecs = $timeInSecs');
  //   } else {
  //     timeInHrs = (inputTime ~/ 3600);
  //     hrStr = '${timeInHrs}h';
  //     var remainder = inputTime % 3600;
  //     timeInMins = remainder ~/ 60;
  //     minsStr = '${timeInMins}m';
  //     timeInSecs = remainder % 60;
  //     secsStr = '${timeInSecs}s';
  //     // print('Log: timeInHrs = $timeInHrs');
  //     // print('Log: timeInMins = $timeInMins');
  //     // print('Log: timeInSecs = $timeInSecs');
  //   }

  //   formattedStr = ('$hrStr $minsStr $secsStr').trim();

  //   return formattedStr;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Video Player'),
        actions: [
          PopupMenuButton(
            tooltip: 'more options',
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Settings'),
                value: MoreOptions.Settings,
              ),
            ],
            onSelected: (MoreOptions selectedValue) {
              if (selectedValue == MoreOptions.Settings) {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              }
            },
          ),
        ],
      ),
      body: AllVideosGrid(
        mediaList: _allVideos,
        videoList: _modelVideos,
      ),
    );
  }
}

enum MoreOptions { Settings }
