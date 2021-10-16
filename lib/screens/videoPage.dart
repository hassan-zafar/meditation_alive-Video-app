import 'package:flutter/material.dart';
import 'package:meditation_alive/widgets/commentsNChat.dart';
import 'package:meditation_alive/widgets/video_widget.dart';

class VideoPage extends StatefulWidget {
  final String? path;
  final String? postId;
  final String? videoTitle;
  VideoPage({this.path, this.postId, this.videoTitle});
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
          Text(widget.videoTitle!,style: ,),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: CommentsNChat(
              isPostComment: true,
              isProductComment: false,
              postId: widget.postId!,
              isAdmin: false,
            ),
          ),
        ],
      ),
    );
  }
}
