import 'package:flutter/material.dart';
import 'package:meditation_alive/models/preferencesFile.dart';

class BackgroundPlayProvider with ChangeNotifier {
  BackgroundPlayPreferences backgroundPlayPreferences =
      BackgroundPlayPreferences();
  bool _setBackgroundPlay = true;
  bool get backgroundPlaySet => _setBackgroundPlay;

  set backgroundPlaySet(bool value) {
    _setBackgroundPlay = value;
    backgroundPlayPreferences.setBackgroundPlay(value);
    notifyListeners();
  }
}
