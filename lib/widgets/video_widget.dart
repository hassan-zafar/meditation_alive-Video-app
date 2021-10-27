import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:meditation_alive/consts/consants.dart';
import 'package:meditation_alive/models/firebase_file.dart';
import 'package:meditation_alive/models/product.dart';
import 'package:meditation_alive/provider/favs_provider.dart';
import 'package:meditation_alive/provider/products.dart';
import 'package:meditation_alive/services/firebase_api.dart';
import 'package:meditation_alive/widgets/videoPlayerWidget.dart';
import 'package:provider/provider.dart';

class VideoWidget extends StatefulWidget {
  final String? path;
  final FirebaseFile? file;
  final Product? product;
  VideoWidget({this.path, this.file, required this.product});
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
    final productsData = Provider.of<Products>(context, listen: false);

    final favsProvider = Provider.of<FavsProvider>(context);
    final prodAttr = productsData.findById(widget.product!.productId!);

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
            widget.product!.title!,
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
                child: GestureDetector(
                    onTap: () {
                      print(widget.product!.productId!);
                      favsProvider.addAndRemoveFromFav(
                        widget.product!.productId!,
                        prodAttr.videoUrl!,
                        prodAttr.title!,
                        prodAttr.imageUrl!,
                        prodAttr.productCategoryName!,
                      );
                    },
                    child: favsProvider.getFavsItems
                            .containsKey(widget.product!.productId)
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border)),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              //   child: GestureDetector(
              //       onTap: () {
              //         FirebaseApi.downloadFile(widget.file!.ref);
              //       },
              //       child: Icon(Icons.download_for_offline_outlined)),
              // ),
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
