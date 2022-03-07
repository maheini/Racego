import 'package:flutter/material.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/ui/screens/homescreen.dart';
import 'package:racego/ui/screens/userscreen.dart';
import 'ui/screens/loginscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/data/provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Racego');
    // setWindowMaxSize(const Size(max_width, max_height));
    setWindowMinSize(const Size(950, 650));
  }
  runApp(
    setupProvider(child: Racego()),
  );
}

class Racego extends StatelessWidget {
  Racego({Key? key}) : super(key: key);

  final ThemeData _darkMode = ThemeData(
    iconTheme: IconThemeData(color: Colors.white),
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

  final ThemeData _lightMode = ThemeData(
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          if (context.read<LoginBloc>().state is LoggedIn) {
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          } else {
            return MaterialPageRoute(builder: (_) => const LoginPage());
          }
          // return MaterialPageRoute(builder: (_) => const LoginPage());
        } else if (settings.name == '/user') {
          if (settings.arguments != null) {
            return MaterialPageRoute(
                builder: (_) => UserScreen(
                      userId: settings.arguments as int,
                    ));
          } else {
            return MaterialPageRoute(builder: (_) => const UserScreen());
          }
        }
        return null; // Let `onUnknownRoute` handle this behavior.
      },
      theme: _lightMode,
      darkTheme: _darkMode,
      themeMode: ThemeMode.system,
      title: 'Racego',
    );
  }
}
