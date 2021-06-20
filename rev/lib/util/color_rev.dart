import 'dart:ui';

import 'package:flutter/material.dart';
class ColorRev {
  static const Color g1 = Color.fromRGBO(102, 239, 156, 1.0);
  static const Color g2 = Color.fromRGBO(157, 255, 205, 1.0);
  static const Color g3 = Color.fromRGBO(37, 188, 109, 1.0);
  static const Color white = Color.fromRGBO(255, 255, 255, 1.0);
  static const Color grey = Color.fromRGBO(100, 100, 100, 1.0);//Color.fromRGBO(200, 200, 200, 1.0);
  static const Color red = Colors.red;
  static ButtonStyle buttonStyle1=TextButton.styleFrom(primary: white,backgroundColor: g3);
  static ButtonStyle buttonStyle2=TextButton.styleFrom(primary: white,backgroundColor: Colors.transparent);
  static ButtonStyle buttonStyle3=TextButton.styleFrom(primary: grey,backgroundColor: Colors.transparent);
  static ButtonStyle buttonStyle4=TextButton.styleFrom(primary: g3,backgroundColor: white);
}
