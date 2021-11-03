import 'package:flutter/material.dart';
import 'package:meditation_alive/models/firebase_file.dart';
import 'package:meditation_alive/models/product.dart';
import 'package:meditation_alive/services/firebase_api.dart';
import 'package:meditation_alive/widgets/commentsNChat.dart';
import 'package:meditation_alive/widgets/loadingWidget.dart';
import 'package:meditation_alive/widgets/video_widget.dart';

class VideoPage extends StatefulWidget {
  final Product? product;
  final List<Product>? allProducts;
  VideoPage({required this.product, this.allProducts});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          isLoading
              ? LoadingIndicator()
              : Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: VideoWidget(
                    path: widget.product!.videoUrl,
                    product: widget.product,
                    allFile: allFiles,
                  ),
                ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: CommentsNChat(
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
