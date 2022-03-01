// part of 'tracklist_cubit.dart';

// @immutable
// abstract class TracklistState {}

// class Loading extends TracklistState {}

// class Loaded extends TracklistState {}

// class Error extends TracklistState {}

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
  Error(RacegoException exception, List<User> previousList, {bool? syncStopped})
      : _previousList = previousList,
        _exception = exception,
        syncStopped = syncStopped ?? false;
  final List<User> _previousList;
  final RacegoException _exception;
  final bool syncStopped;

  RacegoException get exception => _exception;
  List<User> get previousList => _previousList;
}
