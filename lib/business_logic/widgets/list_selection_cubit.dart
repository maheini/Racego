import 'package:bloc/bloc.dart';

class ListSelectionCubit extends Cubit<int> {
  ListSelectionCubit() : super(-1);
  int _currentSelection = -1;

  void itemPressed(int id) {
    if (id == _currentSelection) {
      _currentSelection = -1;
      emit(-1);
    } else {
      _currentSelection = id;
      emit(id);
    }
  }
}
