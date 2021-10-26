import 'package:flutter/material.dart';
import 'package:flutter_new/constraints.dart';

CustomTheme currentTheme=CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  void toggleTheme() {
    _isDarkTheme=!_isDarkTheme;
    notifyListeners();
  }
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      accentColor: Colors.red,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: primaryColor,
      buttonColor: primaryColor,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
      ),

    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.red,
      backgroundColor: Colors.grey,
      scaffoldBackgroundColor: Colors.grey,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
      ),
    );
  }
}