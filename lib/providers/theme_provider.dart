import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.blue;
  var accentColor = Colors.indigoAccent[100];


  var tm = ThemeMode.system;
  String themeText = "system defult";

  onChanged(newColor, n) async {
    n == 1
        ? primaryColor = _toMaterialColor(newColor.hashCode)
        : accentColor = _toMaterialColor(newColor.hashCode);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("primaryColor", primaryColor.value);
    prefs.setInt("accentColor", accentColor.value);
  }

  getThemeColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    primaryColor = _toMaterialColor(prefs.getInt("primaryColor") ?? 0xFF3F51B5);
    accentColor = _toMaterialColor(prefs.getInt("accentColor") ?? 0xFF8C9EFF);
    // edit these 0xFF8C9EFF , 0xFF3F51B5  to the primary and accent color hexcode by clicking on the color and copy the value
    notifyListeners();
  }

  MaterialColor _toMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFFCE4EC),
        100: Color(0xFFF8BBD0),
        200: Color(0xFFF48FB1),
        300: Color(0xFFF06292),
        400: Color(0xFFEC407A),
        500: Color(colorVal),
        600: Color(0xFFD81B60),
        700: Color(0xFFC2185B),
        800: Color(0xFFAD1457),
        900: Color(0xFF880E4F),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(tm);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeText", themeText);
    print("Prefs.getStringng (themeText)");
  }

  _getThemeText(ThemeMode tm) {
    if (tm == ThemeMode.dark)
      themeText = "dark theme";
    else if (tm == ThemeMode.light)
      themeText = "light theme";
    else if (tm == ThemeMode.system) themeText = "system defult";
  }

  getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString("themeText") ?? "system defult";
    if (themeText == "dark theme")
      tm = ThemeMode.dark;
    else if (themeText == "light theme")
      tm = ThemeMode.light;
    else if (themeText == "system defult") tm = ThemeMode.system;
    notifyListeners();
  }
}
