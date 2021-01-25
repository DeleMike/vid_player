import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';

import '../screens/video_screen.dart';
import '../models/video.dart';

class OptionList extends StatelessWidget {
  final Video mVideo;
  OptionList({
    @required this.mVideo,
  });

  void _getVideoInfo(BuildContext ctx) async {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.0),
        ),
      ),
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Video name: ${mVideo.videoTitle}',
                    style: Theme.of(ctx).textTheme.headline1,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Created on: ${mVideo.videoCreationTime}',
                    style: Theme.of(ctx).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'File location: ${mVideo.videoPath}',
                    style: Theme.of(ctx).textTheme.headline1,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Future<void> _pickSubtitle() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'srt', 'txt', 'sub', 'sbv'],
    );
    if (result != null) {
      PlatformFile pFile = result.files.first;
      Future<ClosedCaptionFile> cFile = File(result.files.single.path) as Future<ClosedCaptionFile>;
      File file = File(result.files.single.path);

      print('Option List: cFile is available = ${cFile != null}');
      print('Option List: PFile name = ${pFile.name}');
      print('Option List: PFile bytes = ${pFile.bytes}');
      print('Option List: PFile size = ${pFile.size}');
      print('Option List: PFile extension = ${pFile.extension}');
      print('Option List: PFile path = ${pFile.path}');
      print('Option List: File path = ${file.path}');
    } else {
      // User canceled the picker
      print('Option List: User canceled the picker');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    'video-title': mVideo.videoTitle,
                    'video-file': mVideo.videoData,
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
                _getVideoInfo(context);
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
                _pickSubtitle();
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
