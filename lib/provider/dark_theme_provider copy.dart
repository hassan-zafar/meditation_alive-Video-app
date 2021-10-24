import 'package:flutter/material.dart';
import 'package:meditation_alive/database/local_database.dart';

class AutoPlayProvider with ChangeNotifier {
UserLocalData().
  bool _darkTheme = true;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    // darkThemePreferences.setDarkTheme(value);
    notifyListeners();
  }
}
