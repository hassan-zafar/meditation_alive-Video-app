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
      body: Column(
        children: [
          Container(
            height: 200,
            child: VideoWidget(
              path: widget.path!,
            ),
          ),
          // ListView(
          //   children: [CommentsNMessages(postId: widget.postId)],
          // ),
        ],
      ),
    );
  }
}
