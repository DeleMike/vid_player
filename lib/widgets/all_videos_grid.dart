import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../screens/video_screen.dart';
import '../models/video.dart';

///[AllVideosGrid] displays all videos on device
class AllVideosGrid extends StatelessWidget {
  final List<AssetEntity> mediaList;
  final List<Video> videoList;
  AllVideosGrid({@required this.mediaList, @required this.videoList});
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: mediaList.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: mediaList[index].thumbData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  InkWell(
                    splashColor: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.of(context).pushNamed(VideoScreen.routeName,
                          arguments: videoList[index].videoData);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5.0,
                      child: Container(
                        height: deviceSize.height * 0.25,
                        width: deviceSize.width * 0.45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: GridTile(
                            child:
                                Image.memory(snapshot.data, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    right: 3.9,
                    bottom: orientation == Orientation.landscape ? 10.9 : 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      margin: const EdgeInsets.only(left: 8, bottom: 8),
                      width: deviceSize.width * 0.37,
                      child: Text(
                        '${videoList[index].videoTitle}',
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //   bottomRight: Radius.circular(15),
                        //   bottomLeft: Radius.circular(15),
                        // ),
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 8),
                      margin: const EdgeInsets.only(left: 4, top: 8),
                      width: deviceSize.width > 600
                          ? deviceSize.width * 0.15
                          : deviceSize.width * 0.3,
                      child: Text(
                        '${videoList[index].videoDuration}',
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 1,
                    right: 4,
                    child: InkWell(
                      splashColor: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        print(
                            'All_Videos_Grid: ${videoList[index].videoTitle} was clicked');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        margin: const EdgeInsets.only(right: 5, top: 8),
                        child: Icon(Icons.more_vert, color: Colors.white),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                child: Center(
                  child: Shimmer.fromColors(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                      ),
                    ),
                    baseColor: Theme.of(context).primaryColor,
                    highlightColor: Theme.of(context).canvasColor,
                ),
                  ),
                
              );
            }
          },
        );
      },
    );
  }
}
