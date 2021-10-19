import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:meditation_alive/consts/consants.dart';
import 'package:meditation_alive/widgets/videoPlayerWidget.dart';

class VideoWidget extends StatefulWidget {
  final String? path;
  final String? videoTitle;
  VideoWidget({this.path, this.videoTitle});
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> with WidgetsBindingObserver {
  final asset = 'assets/video.mp4';
  BetterPlayerController? _betterPlayerController;
  BetterPlayerConfiguration? _betterPlayerConfiguration;
  GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _betterPlayerConfiguration = BetterPlayerConfiguration(
        allowedScreenSleep: true,
        autoPlay: true,
        looping: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
            enablePip: true,
            // customControlsBuilder: (BetterPlayerController controller) {
            //   return InkWell(
            //       onTap: () =>
            //           controller.enablePictureInPicture(_betterPlayerKey),
            //       child: Icon(Icons.picture_in_picture_alt_rounded));
            // },
            pipMenuIcon: Icons.picture_in_picture_rounded,
            iconsColor: Colors.white));
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.path!);
    _betterPlayerController = BetterPlayerController(
      _betterPlayerConfiguration!,
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    // final isBackground = state == AppLifecycleState.paused;

    if (state == AppLifecycleState.paused) {
      _betterPlayerController!.enablePictureInPicture(_betterPlayerKey);
    }

    @override
    void dispose() {
      _betterPlayerController!.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final isMuted = _betterPlayerController.value.volume == 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
          child: Text(
            widget.videoTitle!,
            style: titleTextStyle(
                fontSize: 20, color: Theme.of(context).dividerColor),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Icon(Icons.thumb_up_alt_outlined),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Icon(Icons.download_for_offline_outlined),
              ),
              InkWell(
                  onTap: () => _betterPlayerController!
                      .enablePictureInPicture(_betterPlayerKey),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    child: Icon(Icons.picture_in_picture_alt_rounded),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
