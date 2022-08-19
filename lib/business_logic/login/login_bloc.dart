import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:racego/generated/l10n.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._api) : super(RegeneratingSession()) {
    on<RegenerateSession>(_regenerateSession);
    on<Login>(_login);
    on<SwitchLogin>(_gotoRegister);
    on<Register>(_register);
    on<Logout>(_logout);
  }
  final RacegoApi _api;

  void _regenerateSession(
      RegenerateSession event, Emitter<LoginState> emit) async {
    try {
      bool successful = await _api.regenerateSession();
      if (successful) {
        emit(LoggedIn(username: _api.username));
      } else {
        emit(LoggedOut());
      }
    } on RacegoException catch (_) {
      emit(LoginError(S.current.retry_login));
    }
  }

  void _login(Login event, Emitter<LoginState> emit) async {
    emit(Loading());
    try {
      bool isLoggedIn = await _api.login(event._username, event._password);
      if (isLoggedIn) {
        emit(LoggedIn(username: _api.username));
      } else {
        emit(LoginError(S.current.login_invalid));
      }
    } on RacegoException catch (racegoException) {
      emit(LoginError(racegoException.errorMessage));
    }
  }

  void _logout(Logout event, Emitter<LoginState> emit) async {
    try {
      await _api.logout();
    } catch (e) {
      emit(LoggedOut());
    }
    emit(LoggedOut());
  }

  void _gotoRegister(SwitchLogin event, Emitter<LoginState> emit) {
    emit(LoggedOut(registerPage: event.register));
  }

  void _register(Register event, Emitter<LoginState> emit) async {
    emit(Loading());
    if (event._username.trim().isEmpty) {
      emit(LoginError(S.current.email_too_short));
      return;
    }
    if (event._password.length < 8) {
      emit(LoginError(S.current.password_too_short));
      return;
    }

    try {
      bool isRegistered = await _api.register(event._username, event._password);
      if (isRegistered) {
        emit(LoggedIn(username: _api.username));
      } else {
        emit(LoginError(S.current.login_invalid));
      }
    } on RacegoException catch (racegoException) {
      emit(LoginError(racegoException.errorMessage));
    }
  }
}
