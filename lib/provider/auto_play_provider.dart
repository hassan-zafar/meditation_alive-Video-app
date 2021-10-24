import 'package:flutter/material.dart';
import 'package:meditation_alive/models/preferencesFile.dart';

class AutoPlayProvider with ChangeNotifier {
  AutoPlayPreferences _autoPlayPreferences = AutoPlayPreferences();
  bool _autoPlay = true;
  bool get autoPlay => _autoPlay;

  set autoPlay(bool value) {
    _autoPlay = value;
    _autoPlayPreferences.setAutoPlay(value);
    notifyListeners();
  }
}
