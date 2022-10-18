part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class RegenerateSession extends LoginEvent {}

class Login extends LoginEvent {
  final String _username;
  final String _password;
  Login(this._username, this._password);
}

class Register extends LoginEvent {
  final String _username;
  final String _password;
  Register(this._username, this._password);
}

class SwitchLogin extends LoginEvent {
  SwitchLogin({this.register = false});
  final bool register;
}

class Logout extends LoginEvent {}
