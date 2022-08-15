import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/api/racego_api.dart';

import '../../data/exceptions/racego_exception.dart';
import '../../data/models/race.dart';
import '../../generated/l10n.dart';

part 'race_manage_state.dart';

class RaceManageCubit extends Cubit<RaceManageState> {
  RaceManageCubit(RacegoApi api)
      : _api = api,
        super(const RaceManageLoading());

  final RacegoApi _api;

  Future<void> loadRaces() async {
    try {
      emit(const RaceManageLoading());
      final List<Race> races = await _api.getRaces();
      emit(RaceManageLoaded(races));
    } catch (e) {
      if (e is RacegoException) {
        emit(RaceManageError(e));
      } else {
        UnknownException error = UnknownException(
            S.current.unknown_error, e.toString(), e.runtimeType.toString());
        emit(RaceManageError(error));
      }
    }
  }

  Future<void> setRaceId(int id) async {
    await _api.updateRaceId(id);
    return;
  }
}
