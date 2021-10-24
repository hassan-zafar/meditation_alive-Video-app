import 'package:flutter/material.dart';

class FavsAttr with ChangeNotifier {
  final String? id;
  final String? title;
  final String? videoUrl;
  final String? imageUrl;

  FavsAttr({this.id, this.title, this.videoUrl, this.imageUrl});
}
