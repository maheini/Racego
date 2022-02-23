part of 'userscreen_cubit.dart';

@immutable
abstract class UserscreenState {}

class UserScreenAdd extends UserscreenState {}

class UserScreenAddSaving extends UserscreenState {}

class UserScreenAddError extends UserscreenState {
  UserScreenAddError(this.exception);
  final RacegoException exception;
}

class UserScreenLoading extends UserscreenState {}

class UserScreenEdit extends UserscreenState {}

class UserScreenEditError extends UserscreenState {}

class UserScreenEditSaving extends UserscreenState {}

class UserScreenStored extends UserscreenState {}
