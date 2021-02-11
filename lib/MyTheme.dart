import 'package:flutter/material.dart';

var myTheme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.dark,
  primaryColor: myColor.orange,
  accentColor: myColor.orange,
  // Define the default font family.
  fontFamily: 'NotoSans',

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.w900, height: 1.1)
        .apply(color: myColor.white),
    headline2: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900)
        .apply(color: myColor.white),
    bodyText1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700)
        .apply(color: myColor.white),
    bodyText2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)
        .apply(color: myColor.white),
    subtitle2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal)
        .apply(color: myColor.black),
  ),
);

class myColor {
  static const black = Color(0xff0e0000);
  static const orange = Color(0xffe4721a);
  static const white = Color(0xfff3f3f3);
}
