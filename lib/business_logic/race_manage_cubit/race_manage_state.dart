part of 'race_manage_cubit.dart';

@immutable
abstract class RaceManageState {
  const RaceManageState();
}

class RaceManageLoading extends RaceManageState {
  const RaceManageLoading();
}

class RaceManageError extends RaceManageState {
  const RaceManageError(this.exception);
  final RacegoException exception;
}

class RaceManageLoaded extends RaceManageState {
  const RaceManageLoaded(this.races);
  final List<Race> races;
}
