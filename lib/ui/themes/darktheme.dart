import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  iconTheme: const IconThemeData(color: Colors.white),
  // background color
  scaffoldBackgroundColor: Colors.grey.shade900,
  // background for all material widgets
  canvasColor: Colors.grey[850]!,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    background: Colors.grey.shade900,
    onBackground: Colors.grey[850]!,
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
  selectedRowColor: Colors.grey.shade700,
  // text-color for hint-texts
  hintColor: Colors.white,
  // default text sizes and styles
  textTheme: const TextTheme(
    // body text style
    bodyText2: TextStyle(color: Colors.white),
    // title text style
    headline6: TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
    // textfield text-color
    subtitle1: TextStyle(color: Colors.white),
  ),
  // text selection style
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.blue.shade800,
  ),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 175, 0, 6),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey.shade800,
    filled: true,
    hoverColor: Colors.grey.shade700,
    labelStyle: const TextStyle(color: Colors.white),
  ),
);
