import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/exceptions/racego_exception.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._api) : super(LoggedOut()) {
    on<Login>(_login);
    on<Logout>(_logout);
  }
  final RacegoApi _api;

  void _login(Login event, Emitter<LoginState> emit) async {
    emit(Loading());
    try {
      Map<bool, String> result =
          await _api.login(event._username, event._password);
      if (result.isNotEmpty && result.keys.first) {
        emit(LoggedIn(username: result.values.first));
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
