import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:meditation_alive/widgets/videoPlayerWidget.dart';

class VideoWidget extends StatefulWidget {
  final String? path;
  VideoWidget({this.path});
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  final asset = 'assets/video.mp4';
  BetterPlayerController? _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  void dispose() {
    _betterPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final isMuted = _betterPlayerController.value.volume == 0;

    return Column(
      children: [
        Expanded(
            child: VideoPlayerWidget(controller: _betterPlayerController!)),
        // const SizedBox(height: 32),
        // if (controller != null && controller.value.isInitialized)
        //   CircleAvatar(
        //     radius: 30,
        //     backgroundColor: Colors.red,
        //     child: IconButton(
        //       icon: Icon(
        //         isMuted ? Icons.volume_mute : Icons.volume_up,
        //         color: Colors.white,
        //       ),
        //       onPressed: () => controller.setVolume(isMuted ? 1 : 0),
        //     ),
        //   )
      ],
    );
  }
}
