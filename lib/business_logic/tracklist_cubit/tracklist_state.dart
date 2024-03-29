part of 'tracklist_cubit.dart';

@immutable
abstract class TracklistState {}

class Loading extends TracklistState {
  Loading(List<User> previousList) : _previousList = previousList;
  final List<User> _previousList;

  List<User> get previousList => _previousList;
}

class Loaded extends TracklistState {
  Loaded(List<User> list) : _list = list;
  final List<User> _list;
  List<User> get list => _list;
}

class Error extends TracklistState {
  Error(RacegoException exception, List<User> previousList, {bool? syncError})
      : _previousList = previousList,
        _exception = exception,
        syncError = syncError ?? false;
  final List<User> _previousList;
  final RacegoException _exception;
  final bool syncError;

  RacegoException get exception => _exception;
  List<User> get previousList => _previousList;
}
