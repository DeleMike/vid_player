import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';

import '../screens/video_screen.dart';

class OptionList extends StatelessWidget {
  final Future<File> videoFile;
  final String videoTitle;
  OptionList({
    @required this.videoFile,
    @required this.videoTitle,
  });

  void _getVideoInfo() async {
    final videoInfo = FlutterVideoInfo();
    final video = await videoFile;
    String videoFilePath = video.path;
    var info = await videoInfo.getVideoInfo(videoFilePath);
    print('Option_list: info = $info');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(
              splashColor: Theme.of(context).splashColor,
              child: Text(
                'Play',
                style: Theme.of(context).textTheme.headline1,
              ),
              onPressed: () {
                Navigator.pop(context);
                 Navigator.of(context).pushNamed(
                        VideoScreen.routeName,
                        arguments: {
                          'video-title': videoTitle,
                          'video-file': videoFile,
                        },
                      );
              },
            ),
            FlatButton(
              splashColor: Theme.of(context).splashColor,
              child: Text(
                'Video information',
                style: Theme.of(context).textTheme.headline1,
              ),
              onPressed: () {
                Navigator.pop(context);
                _getVideoInfo();
              },
            ),
            FlatButton(
              splashColor: Theme.of(context).splashColor,
              child: Text(
                'Add subtitle',
                style: Theme.of(context).textTheme.headline1,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              splashColor: Theme.of(context).splashColor,
              child: Text(
                'Play as audio',
                style: Theme.of(context).textTheme.headline1,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
