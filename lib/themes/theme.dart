
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: Colors.pink.shade100,
  colorScheme: ColorScheme.light(
    primary: Colors.pink.shade800,
    secondary: Colors.pink.shade200,
    tertiary: Colors.pink,
    inversePrimary: Colors.pinkAccent,
  ),
  brightness: Brightness.light,
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: Colors.grey.shade700,
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade900,
    tertiary: Colors.grey,
    inversePrimary: Colors.grey.shade400,
  ),
);
