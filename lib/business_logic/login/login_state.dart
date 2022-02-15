part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoggedOut extends LoginState {}

class Loading extends LoginState {}

class LoggedIn extends LoginState {
  LoggedIn({required this.username});
  final String username;
}

class LoginError extends LoginState {
  LoginError(this.errorMessage);
  final String errorMessage;
}
