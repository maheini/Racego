part of 'lapeditor_cubit.dart';

@immutable
abstract class LapeditorState {}

class LapsChanged extends LapeditorState {
  LapsChanged(this.laps);
  final List<Time> laps;
}

class SelectionChanged extends LapeditorState {
  SelectionChanged(this.currentSelection);
  final int currentSelection;
}

class TimeInputChanged extends LapeditorState {
  TimeInputChanged(this.isValid);
  final bool isValid;
}
