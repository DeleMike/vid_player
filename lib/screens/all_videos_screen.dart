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

  @override
  void initState() {
    super.initState();
    _getVideoData();
  }

  void _getVideoData() async {
    final _vManager = Provider.of<VideoManager>(context, listen: false);
    await _vManager.fetchMedia();
    setState(() {
      _allVideos = _vManager.allVideos;
      _modelVideos = _vManager.modelVideos;
    });
  }

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
