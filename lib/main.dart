import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/ui/screens/homescreen.dart';
import 'package:racego/ui/screens/importscreen.dart';
import 'package:racego/ui/screens/racedetailscreen.dart';
import 'package:racego/ui/screens/racemanagescreen.dart';
import 'package:racego/ui/screens/rankingscreen.dart';
import 'package:racego/ui/screens/userscreen.dart';
import 'ui/screens/loginscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/data/provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:racego/generated/l10n.dart';
import 'package:racego/ui/themes/darktheme.dart';
import 'package:racego/ui/themes/lighttheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    setWindowTitle('Racego');
    setWindowMinSize(const Size(950, 650));
  }
  runApp(
    setupProvider(child: const Racego()),
  );
}

class Racego extends StatelessWidget {
  const Racego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          if (context.read<LoginBloc>().state is! LoggedIn) {
            return MaterialPageRoute(builder: (_) => const LoginPage());
          } else if (context.read<RacegoApi>().currentRaceId > 0) {
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          } else {
            return MaterialPageRoute(
                builder: (_) => const RaceManagementScreen());
          }
        } else if (settings.name == '/user') {
          if (settings.arguments != null) {
            return MaterialPageRoute(
                builder: (_) => UserScreen(
                      userId: settings.arguments as int,
                    ));
          } else {
            return MaterialPageRoute(builder: (_) => const UserScreen());
          }
        } else if (settings.name == '/ranking') {
          return MaterialPageRoute(builder: (_) => const RankingScreen());
        } else if (settings.name == '/management') {
          return MaterialPageRoute(
              builder: (_) => const RaceManagementScreen());
        } else if (settings.name == '/racedetails') {
          return MaterialPageRoute(
              builder: (_) => RaceDetailScreen(settings.arguments as int));
        } else if (settings.name == '/import') {
          return MaterialPageRoute(builder: (_) => const ImportScreen());
        }

        return null; // Let `onUnknownRoute` handle this behavior.
      },
      builder: (context, child) {
        return child!;
      },
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      title: 'Racego',
    );
  }
}
