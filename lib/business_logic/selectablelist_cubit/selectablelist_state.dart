part of 'selectablelist_cubit.dart';

@immutable
abstract class SelectablelistState {}

class ListSelectionChanged extends SelectablelistState {
  ListSelectionChanged(this.selection, this.previousSelection);
  final List<String> selection;
  final List<String> previousSelection;
}

class ListItemChanged extends SelectablelistState {
  ListItemChanged(this.items, this.selection);
  final List<String> selection;
  final List<String> items;
}
