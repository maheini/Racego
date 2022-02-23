import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:racego/data/models/userdetails.dart';

part 'userscreen_state.dart';

class UserscreenCubit extends Cubit<UserscreenState> {
  UserscreenCubit(RacegoApi api)
      : _api = api,
        super(UserScreenLoading());
  final RacegoApi _api;

  /// Load Screen to add a new user
  ///
  /// -> use this function if you would like to add a user
  void loadAddScreen() => emit(UserScreenAdd());

  /// Store a new user
  ///
  /// -> use this if you would like to upload the new user
  void addUser(UserDetails user) async {
    emit(UserScreenAddSaving());
    try {
      int id = await _api.addUser(user);
      if (id > 0) {
        loadEditUser(id);
      } else {
        throw UnknownException(
            'Benutzer konnte nicht erstellt werden: Datenbank Id ist ungültig');
      }
    } on RacegoException catch (e) {
      emit(UserScreenAddError(e));
    } catch (error) {
      UnknownException e = UnknownException(
          'Unbekannter Fehler', error.toString(), error.runtimeType.toString());
      emit(UserScreenAddError(e));
    }
  }

  /// Load Screen to edit a existing user
  ///
  /// -> use this function if you would like to edit a user
  void loadEditUser(int id) async {
    emit(UserScreenLoading());

    // true -> UserScreenEdit
    // error -> UserScreenEditError
  }

  /// Store a existing user
  ///
  /// -> use this if you would like to upload the existing user
  void editUser() async {
    emit(UserScreenEditSaving());

    // true -> UserScreenStored
    // error -> UserScreenEditError
  }
}
