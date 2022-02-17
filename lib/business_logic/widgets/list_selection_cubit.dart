import 'package:bloc/bloc.dart';

class ListSelectionCubit extends Cubit<int> {
  ListSelectionCubit() : super(-1);
  int _currentSelection = -1;

  void itemPressed(int index) {
    if (index == _currentSelection) {
      emit(-1);
    } else {
      _currentSelection = index;
      emit(index);
    }
  }
}
