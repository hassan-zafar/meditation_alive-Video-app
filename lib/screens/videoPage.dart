import 'package:flutter/material.dart';
import 'package:meditation_alive/widgets/commentsNChat.dart';
import 'package:meditation_alive/widgets/video_widget.dart';

class VideoPage extends StatefulWidget {
  final String? path;
  final String? postId;
  VideoPage({this.path, this.postId});
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: VideoWidget(
              path: widget.path!,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: CommentsNChat(
              isPostComment: true,
              isProductComment: false,
              postId: "video1",
              isAdmin: false,
            ),
          ),
        ],
      ),
    );
  }
}
