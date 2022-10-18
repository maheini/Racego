part of 'import_cubit_cubit.dart';

@immutable
abstract class ImportCubitState {}

class ImportCubitLoading extends ImportCubitState {}

class ImportCubitReady extends ImportCubitState {
  ImportCubitReady({this.message});
  final String? message;
}
