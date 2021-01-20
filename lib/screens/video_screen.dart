import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

///[VideoScreen] this will display the video
class VideoScreen extends StatefulWidget {
  static const routeName = '/video-screen';
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  Future<File> _videoFile;
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
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _videoFile = ModalRoute.of(context).settings.arguments as Future<File>;
    print('Video Screen: _videoFile gotten = ${_videoFile != null}');
    _initVideo();
  }

  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: _controller.value.initialized
          ? Container(
              child: FlickVideoPlayer(
                  flickManager: _flickManager,
                  preferredDeviceOrientation: [
                    DeviceOrientation.landscapeRight,
                    DeviceOrientation.landscapeLeft,
                  ]),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
    }

    if (_flickManager != null) {
      _flickManager.dispose();
    }

    //reset app's orientation
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
  }
}
