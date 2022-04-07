import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:racego/data/models/userdetails.dart';

import '../../generated/l10n.dart';

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
        throw UnknownException(S.current.failed_adding_user_invalid_id);
      }
    } on RacegoException catch (e) {
      emit(UserScreenAddError(e));
    } catch (error) {
      UnknownException e = UnknownException(S.current.unknown_error,
          error.toString(), error.runtimeType.toString());
      emit(UserScreenAddError(e));
    }
  }

  /// Load Screen to edit a existing user
  ///
  /// -> use this function if you would like to edit a user
  void loadEditUser(int id) async {
    emit(UserScreenLoading());
    try {
      UserDetails user = await _api.getUserDetails(id);
      List<String> categories = await _api.getCategories();
      emit(UserScreenEdit(user, categories));
    } on RacegoException catch (e) {
      emit(UserScreenEditError(e));
    } catch (error) {
      UnknownException e = UnknownException(S.current.unknown_error,
          error.toString(), error.runtimeType.toString());
      emit(UserScreenEditError(e));
    }
  }

  /// Store a existing user
  ///
  /// -> use this if you would like to upload the existing user
  void editUser(UserDetails user) async {
    emit(UserScreenEditSaving());
    try {
      bool success = await _api.setUserDetails(user);
      if (success) {
        emit(UserScreenStored());
      } else {
        throw UnknownException(
            S.current.failed_updating_user_unexpected_response);
      }
    } on RacegoException catch (e) {
      emit(UserScreenEditError(e));
    } catch (error) {
      UnknownException e = UnknownException(S.current.unknown_error,
          error.toString(), error.runtimeType.toString());
      emit(UserScreenEditError(e));
    }
  }
}
