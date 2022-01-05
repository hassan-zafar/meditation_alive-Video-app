import 'dart:io';
import 'package:dio/dio.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meditation_alive/consts/consants.dart';
import 'package:meditation_alive/models/firebase_file.dart';
import 'package:meditation_alive/models/product.dart';
import 'package:meditation_alive/provider/favs_provider.dart';
import 'package:meditation_alive/provider/products.dart';
import 'package:meditation_alive/services/firebase_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class VideoWidget extends StatefulWidget {
  final String? path;

  final List<FirebaseFile>? allFile;
  final Product? product;
  VideoWidget({this.path, this.allFile, required this.product});
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> with WidgetsBindingObserver {
  final asset = 'assets/video.mp4';
  double progress = 0;
  final Dio dio = Dio();
  BetterPlayerController? _betterPlayerController;
  BetterPlayerConfiguration? _betterPlayerConfiguration;
  GlobalKey _betterPlayerKey = GlobalKey();
  List<BetterPlayerDataSource> dataSourceList = [];
  bool showProgress = false;
  Future<bool> _requestPermission() async {
    Permission permission = Permission.storage;
    var asd = Permission.accessMediaLocation;
    var zxc = Permission.manageExternalStorage;

    var result = await permission.request();
    if (result.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<bool> saveVideo(String url, String fileName) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission()) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/Meditation Alive";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        //Permission.photos
        await _requestPermission();
        if (await _requestPermission()) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path + "/$fileName.mp4");
        print(saveFile.path);
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            showProgress = true;
            progress = value1 / value2;
            progress = progress * 100;
            print(progress);
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    createDataSet();
    _betterPlayerConfiguration = BetterPlayerConfiguration(
        allowedScreenSleep: true,
        autoPlay: true,
        looping: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
            enableAudioTracks: true,
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
      BetterPlayerDataSourceType.network,
      widget.path!,
    );
    _betterPlayerController = BetterPlayerController(
      _betterPlayerConfiguration!,
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _betterPlayerController!.dispose();

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
  }

  List<BetterPlayerDataSource> createDataSet() {
    widget.allFile!.forEach((element) {
      dataSourceList.add(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          element.url,
        ),
      );
    });

    return dataSourceList;
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
            child: BetterPlayerPlaylist(
                betterPlayerDataSourceList: dataSourceList,
                betterPlayerConfiguration: BetterPlayerConfiguration(),
                betterPlayerPlaylistConfiguration:
                    BetterPlayerPlaylistConfiguration(
                  nextVideoDelay: Duration(seconds: 1),
                ))
            //  VideoPlayerWidget(controller: _betterPlayerController!)
            ),
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
                context: context,
                fontSize: 20,
                color: Theme.of(context).dividerColor),
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
                  onTap: () async {
                    
                    saveVideo(
                        widget.product!.videoUrl!, widget.product!.title!);
                    // await FirebaseApi.downloadFile(
                    //   fileName: widget.product!.title!,
                    //   // path: widget.product!.path!
                    // );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    child: showProgress
                        ? Text('${progress.toInt()}')
                        : Icon(Icons.download_for_offline_outlined),
                  )),
              playInBackground
                  ? InkWell(
                      onTap: () => _betterPlayerController!
                          .enablePictureInPicture(_betterPlayerKey),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: Icon(Icons.picture_in_picture_alt_rounded),
                      ))
                  : SizedBox(),
              InkWell(
                  onTap: () => Share.share(
                      'check out this app https://play.google.com/store/apps/details?id=com.whatsapp',
                      subject: 'Look at this app!'),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    child: Icon(Icons.share),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
