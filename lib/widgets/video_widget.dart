import 'package:flutter/material.dart';
import 'package:meditation_alive/widgets/videoPlayerWidget.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String? path;
  VideoWidget({this.path});
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  final asset = 'assets/video.mp4';
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller =
        // VideoPlayerController.asset(asset)
        VideoPlayerController.network(
            // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            "https://firebasestorage.googleapis.com/v0/b/medication-alive.appspot.com/o/videos%2FDaily%2FEvening_mediation.mp4?alt=media&token=ebd8c676-b1c7-4820-9d36-640aeacfe208")
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize().then((_) => controller.play());
          
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;

    return Column(
      children: [
        Expanded(child: VideoPlayerWidget(controller: controller)),
        const SizedBox(height: 32),
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
