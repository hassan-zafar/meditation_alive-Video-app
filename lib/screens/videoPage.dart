import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:meditation_alive/models/firebase_file.dart';
import 'package:meditation_alive/models/product.dart';
import 'package:meditation_alive/screens/payment_screen.dart';
import 'package:meditation_alive/services/firebase_api.dart';
import 'package:meditation_alive/widgets/commentsNChat.dart';
import 'package:meditation_alive/widgets/loadingWidget.dart';
import 'package:meditation_alive/widgets/video_widget.dart';

class VideoPage extends StatefulWidget {
  final Product? product;
  final List<Product>? allProducts;
  final bool? notPaid;
  VideoPage({required this.product, this.allProducts, required this.notPaid});
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late Future<List<FirebaseFile>> futureFiles;
  late FirebaseFile firstFile;
  bool isLoading = false;
  List<FirebaseFile> allFiles = [];
  @override
  void initState() {
    super.initState();
    getStorageFiles();
  }

  getStorageFiles() async {
    if (!widget.notPaid!) {
      setState(() {
        isLoading = true;
      });
      futureFiles =
          FirebaseApi.listAll("videos/${widget.product!.productCategoryName}/");
      await futureFiles.then((value) => firstFile = value.first);
      allFiles = await futureFiles;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          isLoading
              ? LoadingIndicator()
              : Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: widget.notPaid!
                      ? AspectRatio(
                          aspectRatio: 16 / 9,
                          child: BetterPlayer.network(
                              widget.allProducts![0].videoUrl!))
                      : VideoWidget(
                          path: widget.product!.videoUrl,
                          product: widget.product,
                          allFile: allFiles,
                          index: allFiles.indexWhere((element) => element.name == firstFile.name),
                        ),
                ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: widget.notPaid!
                ? PaymentScreen(
                    product: widget.product,
                    allProducts: widget.allProducts,
                  )
                : CommentsNChat(
                    isPostComment: true,
                    isProductComment: false,
                    postId: widget.product!.productId,
                    isAdmin: false,
                  ),
          ),
        ],
      ),
    );
  }
}
