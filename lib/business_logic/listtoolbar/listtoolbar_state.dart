part of 'listtoolbar_cubit.dart';

@immutable
abstract class ListToolbarState {}

class NoSelection extends ListToolbarState {}

class UserSelected extends ListToolbarState {
  UserSelected(int id, {bool? validLaptime, bool? userHasChanged})
      : _id = id,
        _validLaptime = validLaptime ?? false,
        _userHasChanged = userHasChanged ?? false;
  final int _id;
  final bool _validLaptime;
  final bool _userHasChanged;

  get id => _id;
  get isValidLaptime => _validLaptime;
  get userHasChanged => _userHasChanged;
}
