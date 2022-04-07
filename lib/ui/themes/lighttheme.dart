import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  iconTheme: IconThemeData(color: Colors.grey.shade900),
  // background color
  scaffoldBackgroundColor: Colors.white,
  // background for all material widgets
  canvasColor: Colors.white,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    background: Colors.white,
    onBackground: Colors.white,
    primary: Colors.grey.shade700,
    onPrimary: Colors.white,
    secondary: Colors.grey.shade700,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.grey.shade800,
    onSurface: Colors.white,
  ),
  // default hover color (for appbar icons)
  hoverColor: Colors.black.withOpacity(0.1),
  // row selection color
  selectedRowColor: Colors.grey.shade300,
  // text-color for hint-texts
  hintColor: Colors.black,
  // default text sizes and styles
  textTheme: const TextTheme(
    // body text style
    bodyText2: TextStyle(color: Colors.black),
    // title text style
    headline6: TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
    // textfield text-color
    subtitle1: TextStyle(color: Colors.black),
  ),
  // text selection style
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blue.shade800,
  ),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 175, 0, 6),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey.shade400,
    filled: true,
    hoverColor: Colors.grey.shade500,
    labelStyle: const TextStyle(color: Colors.white),
  ),
);
