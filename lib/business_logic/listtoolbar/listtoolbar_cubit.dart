import 'package:racego/ui/widgets/timeinput.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'listtoolbar_state.dart';

class ListToolbarCubit extends Cubit<ListToolbarState> {
  ListToolbarCubit() : super(NoSelection());
  int _currentId = 0;
  bool _isValidLaptime = false;
  Time _currentTime = Time();

  int getSelectedId() => _currentId;
  Time getCurrentTime() => _currentTime;

  void selectionChanged(int id) {
    _currentId = id;
    _isValidLaptime = false;
    _currentTime = Time();
    emit(UserSelected(id, userHasChanged: true));
  }

  void userUnselected() {
    _currentId = 0;
    _isValidLaptime = false;
    emit(NoSelection());
  }

  void lapTimeChanged(Time time) {
    _currentTime = time;
    if (time.isValid == _isValidLaptime) return;
    _isValidLaptime = !_isValidLaptime;
    emit(
      UserSelected(_currentId,
          validLaptime: _isValidLaptime, userHasChanged: false),
    );
  }
}
