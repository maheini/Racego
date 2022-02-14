part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Login extends LoginEvent {
  String _username;
  String _password;
  Login(this._username, this._password);
}

class Logout extends LoginEvent {}
