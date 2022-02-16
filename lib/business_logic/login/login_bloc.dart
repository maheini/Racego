import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/exceptions/racego_exception.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._api) : super(RegeneratingSession()) {
    on<RegenerateSession>(_regenerateSession);
    on<Login>(_login);
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
      emit(LoginError('Melden Sie sich erneut an'));
    }
  }

  void _login(Login event, Emitter<LoginState> emit) async {
    emit(Loading());
    try {
      bool isLoggedIn = await _api.login(event._username, event._password);
      if (isLoggedIn) {
        emit(LoggedIn(username: _api.username));
      } else {
        emit(LoginError('Email oder Passwort ist ungültig'));
      }
    } on RacegoException catch (racegoException) {
      emit(LoginError(racegoException.errorMessage));
    }
  }

  void _logout(Logout event, Emitter<LoginState> emit) {
    emit(LoggedOut());
  }
}
