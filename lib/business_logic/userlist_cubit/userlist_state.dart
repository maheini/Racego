part of 'userlist_cubit.dart';

@immutable
abstract class UserlistState {}

class Loading extends UserlistState {
  Loading(List<User> previousList) : _previousList = previousList;
  final List<User> _previousList;

  get previousList => _previousList;
}

class Loaded extends UserlistState {
  Loaded(List<User> list) : _list = list;
  final List<User> _list;
  get list => _list;
}

class Error extends UserlistState {
  Error(RacegoException exception, List<User> previousList)
      : _previousList = previousList,
        _exception = exception;
  final List<User> _previousList;
  final RacegoException _exception;

  get exception => _exception;
  get previousList => _previousList;
}
