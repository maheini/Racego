part of 'race_details_cubit.dart';

@immutable
abstract class RaceDetailsState {}

class RaceDetailsLoading extends RaceDetailsState {}

class RaceDetailsLoaded extends RaceDetailsState {
  RaceDetailsLoaded(this.details);
  final RaceDetails details;
}

class RaceDetailsSaving extends RaceDetailsState {}

class RaceDetailsSaveSuccess extends RaceDetailsState {}

class RaceDetailsSaveFailure extends RaceDetailsState {
  RaceDetailsSaveFailure(this.error);
  final RacegoException error;
}

class RaceDetailsError extends RaceDetailsState {
  RaceDetailsError(this.error);
  final RacegoException error;
}
