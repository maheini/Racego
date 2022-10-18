part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class RegeneratingSession extends LoginState {}

class LoggedOut extends LoginState {
  LoggedOut({this.registerPage = false});
  final bool registerPage;
}

class Loading extends LoginState {}

class LoggedIn extends LoginState {
  LoggedIn({required this.username});
  final String username;
}

class LoginError extends LoginState {
  LoginError(this.errorMessage);
  final String errorMessage;
}
