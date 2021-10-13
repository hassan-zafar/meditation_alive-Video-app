import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meditation_alive/widgets/video_widget.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

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
              path: File("asdsd"),
            ),
          ),
          ListView(
            children: [
              
            ],
          ),
        ],
      ),
    );
  }
}
