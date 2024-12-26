import 'package:calculator/themes/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier{
  // create private variable and assign value
  ThemeData _themeData = lightMode;

  // create getter to get the value
  ThemeData get themeData => _themeData;

  // check if current theme is dark

  bool get isDarkMode => themeData == darkMode;

  // create setter to set a new value
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void changeTheme(){
    if(themeData == lightMode){
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
    print("Theme changed: ${_themeData.brightness}");
    notifyListeners();
  }
}
