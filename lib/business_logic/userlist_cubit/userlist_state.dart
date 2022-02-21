part of 'userlist_cubit.dart';

@immutable
abstract class UserlistState {}

class Loading extends UserlistState {}

class Loaded extends UserlistState {}

class Error extends UserlistState {}
