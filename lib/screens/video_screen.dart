import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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

  void _initVideo() async {
    final video = await _videoFile;
    _controller = VideoPlayerController.file(video)
      //play video again when it ends
      ..setLooping(true)
      // initialize the controller and notify UI when done
      ..initialize().then(
        (_) => setState(() {
          initialized = true;
        }),
      )
      ..play();
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
    return Scaffold(
      body: initialized
          ? Scaffold(
              body: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      // If the video is paused, play it.
                      _controller.play();
                    }
                  });
                },
                // Display the correct icon depending on the state of the player.
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            )
          // If the video is not yet initialized, display a spinner
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
    }
  }
}
