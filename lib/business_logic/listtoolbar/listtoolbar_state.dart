part of 'listtoolbar_cubit.dart';

@immutable
abstract class ListToolbarState {}

class NoSelection extends ListToolbarState {}

class UserSelected extends ListToolbarState {
  UserSelected(int id, {bool? validLaptime})
      : _id = id,
        _validLaptime = validLaptime ?? false;
  final int _id;
  final bool _validLaptime;

  get id => _id;
  get isValidLaptime => _validLaptime;
}
