import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/race_manager.dart';

part 'racemanagerlist_state.dart';

class RaceManagerListCubit extends Cubit<RaceManagerListState> {
  RaceManagerListCubit(this._manager, this._selectedUserName)
      : super(ManagerListItemChanged(_manager, _selectedUserName));

  List<RaceManager> _manager;
  String _filter = '';
  String _selectedUserName = '';

  String get selection => _selectedUserName;
  List<RaceManager> get manager => _manager;

  set items(List<RaceManager> manager) {
    _manager = manager;
    _emitFilteredList();
  }

  void select(String userName) {
    var manager = _manager.where((manager) => manager.username == userName);
    if (manager.isNotEmpty) {
      String prev = _selectedUserName;
      _selectedUserName = userName;
      emit(ManagerListSelectionChanged(userName, prev));
    }
  }

  void unSelect() {
    if (_selectedUserName.isNotEmpty) {
      String prev = _selectedUserName;
      _selectedUserName = '';
      emit(ManagerListSelectionChanged(_selectedUserName, prev));
    }
  }

  void addManager(RaceManager manager) {
    var contained = _manager.where((element) =>
        element.username.toLowerCase() == manager.username.toLowerCase());
    if (contained.isNotEmpty) return;

    _manager.add(manager);
    _selectedUserName = manager.username;
    _emitFilteredList();
  }

  void removeManager(String userName) {
    var contained = _manager.where(
        (element) => element.username.toLowerCase() == userName.toLowerCase());
    if (contained.isEmpty) return;

    _manager.removeWhere(
        (element) => element.username.toLowerCase() == userName.toLowerCase());
    if (_selectedUserName.toLowerCase() == userName) {
      _selectedUserName = '';
    }
    _emitFilteredList();
  }

  void changeRole(String userName) {
    final int index =
        _manager.indexWhere((element) => element.username == userName);
    _manager[index].isAdmin = !_manager[index].isAdmin;
    _emitFilteredList();
  }

  void changeFilter(String filter) {
    _filter = filter.toLowerCase();
    _emitFilteredList();
  }

  _emitFilteredList() {
    if (_filter.isEmpty) {
      // Check if the selected user is still in the list -> in case of a refresh
      var selectionContained =
          _manager.where((element) => element.username == _selectedUserName);
      if (selectionContained.isEmpty) {
        _selectedUserName = '';
      }

      // Emit all managers without further filtering
      emit(ManagerListItemChanged(_manager, _selectedUserName));
    } else {
      // Filter the List for the username
      final List<RaceManager> items = _manager
          .where((element) => element.username.toLowerCase().contains(_filter))
          .toList();

      // Check if selection is still valid with the filter... Otherwhise the filter needs to be reset
      var selectionContained =
          _manager.where((element) => element.username == _selectedUserName);
      if (selectionContained.isEmpty) {
        _selectedUserName = '';
      }

      // Emit the new state
      emit(
        ManagerListItemChanged(
          items,
          _selectedUserName,
        ),
      );
    }
  }
}
