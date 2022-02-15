import 'package:get_it/get_it.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/api/http_client_default.dart'
    if (dart.library.html) 'package:racego/data/api/http_client_web.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  RacegoApi api = RacegoApi(client);
  locator.registerSingleton(LoginBloc(api));
}
