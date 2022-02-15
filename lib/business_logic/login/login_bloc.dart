import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoggedOut()) {
    on<Login>(_login);
    on<Logout>(_logout);
  }

  void _login(Login event, Emitter<LoginState> emit) async {
    emit(Loading());
    await Future.delayed(Duration(seconds: 5));
    emit(LoggedIn(username: 'Martin'));
  }

  void _logout(Logout event, Emitter<LoginState> emit) {
    emit(LoggedOut());
  }
}
