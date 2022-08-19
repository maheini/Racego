import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/exceptions/racego_exception.dart';

import '../../data/models/racedetails.dart';
import '../../generated/l10n.dart';

part 'race_details_state.dart';

class RaceDetailsCubit extends Cubit<RaceDetailsState> {
  RaceDetailsCubit(this._api) : super(RaceDetailsLoading());

  final RacegoApi _api;

  Future<void> loadDetails(int raceID) async {
    try {
      emit(RaceDetailsLoading());
      RaceDetails details = await _api.getRaceDetails(raceID);
      emit(RaceDetailsLoaded(details));
    } catch (e) {
      if (e is RacegoException) {
        emit(RaceDetailsError(e));
      } else {
        UnknownException error = UnknownException(
            S.current.unknown_error, e.toString(), e.runtimeType.toString());
        emit(RaceDetailsError(error));
      }
    }
  }

  Future<void> saveDetails(RaceDetails raceDetails) async {
    try {
      emit(RaceDetailsSaving());
      await _api.setRaceDetails(raceDetails);
      emit(RaceDetailsSaveSuccess());
    } catch (e) {
      if (e is RacegoException) {
        emit(RaceDetailsSaveFailure(e));
      } else {
        UnknownException error = UnknownException(
            S.current.unknown_error, e.toString(), e.runtimeType.toString());
        emit(RaceDetailsSaveFailure(error));
      }
    }
  }
}
