import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:racego/data/models/user.dart';

part 'userlist_state.dart';

class UserlistCubit extends Cubit<UserlistState> {
  UserlistCubit(RacegoApi api)
      : _api = api,
        super(Loading(const [])) {
    reload();
  }

  final RacegoApi _api;
  String _filter = '';
  List<User> _newestList = [];

  /// reloads all user and emit a filtered List
  ///
  void reload() async {
    try {
      _newestList = await _api.getUser();
      emit(Loaded(_filter.isNotEmpty
          ? _filterList(_newestList, _filter)
          : _newestList));
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
