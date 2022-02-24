import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/models/time.dart';

part 'lapeditor_state.dart';

class LapeditorCubit extends Cubit<LapeditorState> {
  LapeditorCubit(List<Time> laps)
      : _laps = laps,
        super(LapsChanged(laps));

  final List<Time> _laps;
  int _currentSelection = -1;
  bool _isValidtime = false;

  int get currentSelection => _currentSelection;
  bool get isValidTime => _isValidtime;
  List<Time> get laps => _laps;

  void addLap(Time lap) {
    _laps.add(lap);
    _currentSelection = _laps.length - 1;
    emit(LapsChanged(_laps));
  }

  void removeLap(int index) {
    if (index < _laps.length) {
      if (index == _currentSelection) _currentSelection = -1;
      _laps.removeAt(index);
      emit(LapsChanged(_laps));
    }
  }

  void selectionChanged(int index) {
    if (index == _currentSelection) {
      _currentSelection = -1;
    } else {
      _currentSelection = index;
    }
    emit(SelectionChanged(_currentSelection));
  }

  void timeInputChanged(Time time) {
    bool initial = _isValidtime;

    _isValidtime = time.isValid;
    if (initial != _isValidtime) emit(TimeInputChanged(_isValidtime));
  }
}
