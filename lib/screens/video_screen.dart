import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///[VideoScreen] this will display the video
class VideoScreen extends StatefulWidget {
  static const routeName = '/video-screen';
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  Map<String, Object> _receivedData;
  Future<File> _videoFile;
  String _videoTitle;
  VideoPlayerController _controller;
  bool initialized = false;
  FlickManager _flickManager;

  void _initVideo() async {
    final video = await _videoFile;
    _controller = VideoPlayerController.file(video)
      ..setLooping(true)
      ..initialize()
      ..addListener(() => setState(() {}))
      ..play();
    _flickManager = FlickManager(
      videoPlayerController: _controller,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _receivedData = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    _videoFile = _receivedData['video-file'];
    _videoTitle = _receivedData['video-title'];
    print('Video Screen: _videoFile gotten = ${_videoFile != null}');
    print('Video Screen: _videoTitle gotten = $_videoTitle');
    _initVideo();
  }

  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(_videoTitle),
      ),
      body: _controller.value.initialized
          ? Container(
              child: FlickVideoPlayer(
                flickManager: _flickManager,
                flickVideoWithControls: FlickVideoWithControls(
                  videoFit: BoxFit.contain,
                  controls: FlickPortraitControls(
                    iconSize: 25,
                    fontSize: 14,
                    progressBarSettings: FlickProgressBarSettings(
                      playedColor: Colors.orange,
                      height: 5,
                      handleRadius: 5.3,
                    ),
                  ),
                  playerLoadingFallback: SpinKitPulse(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          : SpinKitPulse(
            color: Theme.of(context).primaryColor,
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    if (_flickManager != null) {
      _controller.removeListener(() => setState(() {}));
      _flickManager.dispose();
    }
  }
}
