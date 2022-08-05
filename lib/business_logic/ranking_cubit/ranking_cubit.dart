import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/models/rankinglist.dart';

import '../../data/api/racego_api.dart';
import '../../data/exceptions/racego_exception.dart';
import '../../generated/l10n.dart';

part 'rankingcubit_state.dart';

class RankingCubit extends Cubit<RankingcubitState> {
  RankingCubit(RacegoApi api)
      : _api = api,
        super(const RankingLoading(currentClass: '', classList: [])) {
    loadClasses();
  }
  final RacegoApi _api;

  List<String> _classes = [];
  String _currentClass = '';
  RankingList _currentRanking = RankingList(null);

  Future<void> loadClasses() async {
    try {
      _classes = await _api.getCategories();
      if (!_classes.contains(_currentClass)) {
        _currentClass = '';
      }
      emit(RankingLoaded(_currentRanking,
          currentClass: _currentClass, classList: _classes));
    } catch (e) {
      if (e is RacegoException) {
        emit(RankingError(e, currentClass: _currentClass, classList: _classes));
      } else {
        UnknownException error = UnknownException(
            S.current.unknown_error, e.toString(), e.runtimeType.toString());
        emit(RankingError(error,
            currentClass: _currentClass, classList: _classes));
      }
    }
  }

  Future<void> loadRanking(String? raceClass) async {
    try {
      _currentRanking = await _api.getRankig(raceClass);
      _currentClass = raceClass ?? '';
      emit(RankingLoaded(_currentRanking,
          currentClass: _currentClass, classList: _classes));
    } catch (e) {
      if (e is RacegoException) {
        emit(RankingError(e, currentClass: _currentClass, classList: _classes));
      } else {
        UnknownException error = UnknownException(
            S.current.unknown_error, e.toString(), e.runtimeType.toString());
        emit(RankingError(error,
            currentClass: _currentClass, classList: _classes));
      }
    }
  }
}
