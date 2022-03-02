part of 'lapeditor_cubit.dart';

@immutable
abstract class LapeditorState {
  const LapeditorState(this.selectedIndex, this.isValidTime);
  final int selectedIndex;
  final bool isValidTime;
}

class LapsChanged extends LapeditorState {
  const LapsChanged(this.laps, int selectedIntex, bool isValidTime)
      : super(selectedIntex, isValidTime);
  final List<Time> laps;
}

class SelectionChanged extends LapeditorState {
  const SelectionChanged(int selectedIntex, bool isValidTime)
      : super(selectedIntex, isValidTime);
}

class TimeInputChanged extends LapeditorState {
  const TimeInputChanged(this.isValid, int selectedIntex, bool isValidTime)
      : super(selectedIntex, isValidTime);
  final bool isValid;
}
