import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/api/http_client_default.dart'
    if (dart.library.html) 'package:racego/data/api/http_client_web.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart' as prov;

Widget setupProvider({required Widget child}) {
  const storage = FlutterSecureStorage();
  RacegoApi api = RacegoApi(client, storage);
  return prov.Provider<RacegoApi>(
    create: (context) => api,
    child: MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            context.read<RacegoApi>(),
          )..add(RegenerateSession()),
        ),
      ],
      child: child,
    ),
  );
}
