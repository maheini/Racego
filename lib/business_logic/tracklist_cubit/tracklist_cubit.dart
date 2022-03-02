import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:racego/data/models/time.dart';
import 'package:racego/data/models/user.dart';

part 'tracklist_state.dart';

class TracklistCubit extends Cubit<TracklistState> {
  TracklistCubit(RacegoApi api)
      : _api = api,
        super(Loading(const [])) {
    reload();
  }

  final RacegoApi _api;
  String _filter = '';
  List<User> _newestList = [];
  bool _syncEnabled = false;

  /// scheduled reload
  ///
  Future<void> startSync() async {
    if (_syncEnabled) {
      return;
    } else {
      _syncEnabled = true;
    }
    while (_syncEnabled) {
      reload();
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void stopSync() => _syncEnabled = false;

  /// reloads all user on track and emit a filtered List
  ///
  Future<void> reload() async {
    try {
      _newestList = await _api.getTrack();
      emit(Loaded(_filter.isNotEmpty
          ? _filterList(_newestList, _filter)
          : _newestList));
    } catch (e) {
      if (e is RacegoException) {
        emit(Error(
          e,
          _filter.isNotEmpty ? _filterList(_newestList, _filter) : _newestList,
          syncError: true,
        ));
      } else {
        UnknownException error = UnknownException(
            'Unbekannter Fehler', e.toString(), e.runtimeType.toString());
        emit(Error(
          error,
          _filter.isNotEmpty ? _filterList(_newestList, _filter) : _newestList,
          syncError: true,
        ));
      }
    }
  }

  /// set/reset filter. Empty filter means no filter
  ///
  void setFilter(String filter) {
    _filter = filter;
    // emit new, filtered list

    if (state is Loaded) {
      emit(Loaded(_filter.isNotEmpty
          ? _filterList(_newestList, _filter)
          : _newestList));
    }
  }

  /// cancel lap and remove user from track
  ///
  Future<void> cancelLap(int userId) async {
    try {
      bool successful = await _api.cancelLap(userId);
      if (!successful) {
        throw DataException(
            'Benutzer konnte nicht von der Rennstrecke entfernt werden: Id ungültig.');
      }
      reload();
    } catch (e) {
      if (e is RacegoException) {
        emit(Error(
            e,
            _filter.isNotEmpty
                ? _filterList(_newestList, _filter)
                : _newestList));
      } else {
        UnknownException error = UnknownException(
            'Unbekannter Fehler', e.toString(), e.runtimeType.toString());
        emit(Error(
            error,
            _filter.isNotEmpty
                ? _filterList(_newestList, _filter)
                : _newestList));
      }
    }
  }

  /// submit lap and remove user from track
  ///
  Future<void> finishLap(int userId, Time time) async {
    try {
      bool successful = await _api.finishLap(userId, time);
      if (!successful) {
        throw DataException(
            'Rundenzeit konnte nicht erfasst werden: Id oder Zeit ungültig.');
      }
      reload();
    } catch (e) {
      if (e is RacegoException) {
        emit(Error(
            e,
            _filter.isNotEmpty
                ? _filterList(_newestList, _filter)
                : _newestList));
      } else {
        UnknownException error = UnknownException(
            'Unbekannter Fehler', e.toString(), e.runtimeType.toString());
        emit(Error(
            error,
            _filter.isNotEmpty
                ? _filterList(_newestList, _filter)
                : _newestList));
      }
    }
  }

  /// function for filtering the list
  ///
  List<User> _filterList(List<User> list, String filter) {
    return _newestList.where(
      (element) {
        String fullName =
            '${element.firstName} ${element.lastName}'.toLowerCase();
        String reverseFullName =
            '${element.lastName} ${element.firstName}'.toLowerCase();
        return fullName.contains(_filter.toLowerCase()) ||
            reverseFullName.contains(_filter.toLowerCase());
      },
    ).toList();
  }
}
