import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

import 'basicOverlayWidget.dart';

class VideoPlayerWidget extends StatelessWidget {
  final BetterPlayerController controller;

  const VideoPlayerWidget({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => controller != null
      // && controller.
      ? Container(alignment: Alignment.topCenter, child: buildVideo())
      : Container(
          // height: 200,
          child: Center(child: CircularProgressIndicator()),
        );

  Widget buildVideo() =>
      // Stack(
      // children: <Widget>[
      buildVideoPlayer()
      // Positioned.fill(child: BasicOverlayWidget(controller: controller)),
      // ],
      // )
      ;

  Widget buildVideoPlayer() =>
      // AspectRatio(
      // aspectRatio: controller.value.aspectRatio,
      // child:
      BetterPlayer(controller: controller);
  //   ,
  // );
}
