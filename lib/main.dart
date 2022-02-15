import 'package:flutter/material.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/data/locator/locator.dart';
import 'package:racego/ui/pages/homepage.dart';
import 'ui/pages/loginpage.dart';

void main() {
  runApp(Racego());
}

class Racego extends StatelessWidget {
  Racego({Key? key}) : super(key: key) {
    setupLocator();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          if (locator.get<LoginBloc>().state is LoggedIn) {
            return MaterialPageRoute(builder: (_) => const HomePage());
          } else {
            return MaterialPageRoute(builder: (_) => const LoginPage());
          }
          // return MaterialPageRoute(builder: (_) => const LoginPage());
        }
        if (settings.name == '/user') {
          // return MaterialPageRoute(builder: (_) => UserScreen(id: ???));
        } else if (settings.name == '/') {
          // return MaterialPageRoute(builder: (_) => const homepage
          //());
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
