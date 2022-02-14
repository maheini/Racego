part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoggedOut extends LoginState {}

class Loading extends LoginState {}

class LoggedIn extends LoginState {
  LoggedIn({required this.username});
  String username;
}
