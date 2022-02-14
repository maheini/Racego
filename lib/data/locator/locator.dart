import 'package:get_it/get_it.dart';
import 'package:racego/business_logic/blocs/login/login_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(LoginBloc());
}
