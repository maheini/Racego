import 'package:flutter/material.dart';
import 'presentation/pages/homescreen.dart';
import 'presentation/pages/loginscreen.dart';
import 'presentation/pages/userscreen.dart';

void main(){
  runApp(const Racego());
}

class Racego extends StatelessWidget {
  const Racego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/login') {
          // return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
        if (settings.name == '/user') {
          // return MaterialPageRoute(builder: (_) => UserScreen(id: ???));
        }
        else if (settings.name == '/'){
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