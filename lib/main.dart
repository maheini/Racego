import 'package:flutter/material.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/data/locator/locator.dart';
import 'package:racego/ui/pages/homepage.dart';
import 'package:racego/ui/pages/userscreen.dart';
import 'ui/pages/loginpage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/data/api/racego_api.dart';

void main() {
  setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                LoginBloc(locator<RacegoApi>())..add(RegenerateSession())),
      ],
      child: const Racego(),
    ),
  );
}

class Racego extends StatelessWidget {
  const Racego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          if (context.read<LoginBloc>().state is LoggedIn) {
            return MaterialPageRoute(builder: (_) => const HomePage());
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
            return MaterialPageRoute(builder: (_) => UserScreen());
          }
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
