import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selectablelist_state.dart';

class SelectablelistCubit extends Cubit<SelectablelistState> {
  SelectablelistCubit(List<String> items, List<String> selection)
      : _items = items,
        _selection = selection,
        super(ListItemChanged(items, selection));
  List<String> _items;
  List<String> _selection;
  String _filter = '';

  List<String> get selection => _selection;

  set items(List<String> items) {
    _items = items;
    _emitFilteredList();
  }

  set selection(List<String> selection) {
    emit(ListSelectionChanged(selection, _selection));
    _selection = selection;
  }

  void selectionChanged(String item, bool isSelected) {
    List<String> oldList = _selection.toList();
    isSelected
        ? _selection.add(item)
        : _selection.removeWhere((selectedItem) => selectedItem == item);
    emit(ListSelectionChanged(_selection, oldList));
  }

  void addItem(String item) {
    if (_items.contains(item)) return;

    _items.add(item);
    _selection.add(item);
    _emitFilteredList();
  }

  void changeFilter(String filter) {
    _filter = filter.toLowerCase();
    _emitFilteredList();
  }

  _emitFilteredList() {
    if (_filter.isEmpty) {
      emit(ListItemChanged(_items, _selection));
    } else {
      emit(
        ListItemChanged(
          _items
              .where((element) => element.toLowerCase().contains(_filter))
              .toList(),
          _selection,
        ),
      );
    }
  }
}
