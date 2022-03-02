import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/models/time.dart';

part 'lapeditor_state.dart';

class LapeditorCubit extends Cubit<LapeditorState> {
  LapeditorCubit(List<Time> laps)
      : _laps = laps,
        super(LapsChanged(laps, -1, false));

  final List<Time> _laps;
  int _currentSelection = -1;
  bool _isValidtime = false;

  int get currentSelection => _currentSelection;
  bool get isValidTime => _isValidtime;
  List<Time> get laps => _laps;

  void addLap(Time lap) {
    _laps.add(lap);
    _isValidtime = false;
    _currentSelection = _laps.length - 1;
    emit(LapsChanged(_laps, _currentSelection, _isValidtime));
  }

  void removeLap(int index) {
    if (index < _laps.length) {
      if (index == _currentSelection) _currentSelection = -1;
      _laps.removeAt(index);
      _isValidtime = false;
      emit(LapsChanged(_laps, _currentSelection, _isValidtime));
    }
  }

  void selectionChanged(int index) {
    if (index == _currentSelection) {
      _currentSelection = -1;
      _isValidtime = false;
    } else {
      _currentSelection = index;
      _isValidtime = false;
    }
    emit(SelectionChanged(_currentSelection, _isValidtime));
  }

  void timeInputChanged(Time time) {
    bool initial = _isValidtime;

    _isValidtime = time.isValid;
    if (initial != _isValidtime) {
      emit(TimeInputChanged(_isValidtime, _currentSelection, _isValidtime));
    }
  }
}
