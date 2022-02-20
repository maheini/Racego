import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'listtoolbar_state.dart';

class ListToolbarCubit extends Cubit<ListToolbarState> {
  ListToolbarCubit() : super(NoSelection());
  int _currentId = 0;
  bool _isValidLaptime = false;

  void selectionChanged(int id) {
    _currentId = id;
    _isValidLaptime = false;
    emit(UserSelected(id, userHasChanged: true));
  }

  void userUnselected() {
    _currentId = 0;
    _isValidLaptime = false;
    emit(NoSelection());
  }

  void lapTimeChanged(bool isValid) {
    _isValidLaptime = isValid;
    emit(
      UserSelected(_currentId,
          validLaptime: _isValidLaptime, userHasChanged: false),
    );
  }
}
