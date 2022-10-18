part of 'racemanagerlist_cubit.dart';

@immutable
abstract class RaceManagerListState {
  const RaceManagerListState(this.selectedUserName);
  final String selectedUserName;
}

class ManagerListSelectionChanged extends RaceManagerListState {
  const ManagerListSelectionChanged(
      String selectedUserName, this.previousSelectedUserName)
      : super(selectedUserName);

  final String previousSelectedUserName;
}

class ManagerListItemChanged extends RaceManagerListState {
  const ManagerListItemChanged(this.manager, String selectedUserName)
      : super(selectedUserName);
  final List<RaceManager> manager;
}
