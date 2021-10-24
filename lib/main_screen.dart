import 'package:flutter/material.dart';
import 'package:meditation_alive/screens/homePage.dart';
import 'package:meditation_alive/widgets/bottom_bar.dart';

class MainScreens extends StatelessWidget {
  static const routeName = '/MainScreen';

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        HomePage()
        // BottomBarScreen(),
        // UploadProductForm()
      ],
    );
  }
}
