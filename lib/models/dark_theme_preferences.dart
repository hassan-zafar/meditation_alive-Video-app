import 'package:get_storage/get_storage.dart';

class DarkThemePreferences {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    GetStorage prefs = GetStorage();
    prefs.write(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    GetStorage prefs = GetStorage();
    return prefs.read(
          THEME_STATUS,
        ) ??
        true;
  }
}
