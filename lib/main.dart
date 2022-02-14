import 'package:flutter/material.dart';
import 'package:racego/data/locator/locator.dart';
import 'ui/pages/loginscreen.dart';

void main() {
  runApp(const Racego());
}

class Racego extends StatelessWidget {
  const Racego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setupLocator();
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => const LoginPage());
        }
        if (settings.name == '/user') {
          // return MaterialPageRoute(builder: (_) => UserScreen(id: ???));
        } else if (settings.name == '/') {
          // return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
        return null; // Let `onUnknownRoute` handle this behavior.
      },
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      title: 'Racego',
    );
  }
}
