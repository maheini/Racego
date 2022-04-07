part of 'ranking_cubit.dart';

@immutable
abstract class RankingcubitState {
  const RankingcubitState(
      {required this.currentClass, required this.classList});
  final String currentClass;
  final List<String> classList;
}

class RankingLoading extends RankingcubitState {
  const RankingLoading(
      {required String currentClass, required List<String> classList})
      : super(currentClass: currentClass, classList: classList);
}

class RankingLoaded extends RankingcubitState {
  const RankingLoaded(this.ranking,
      {required String currentClass, required List<String> classList})
      : super(currentClass: currentClass, classList: classList);
  final RankingList ranking;
}

class RankingError extends RankingcubitState {
  const RankingError(this.exception,
      {required String currentClass, required List<String> classList})
      : super(currentClass: currentClass, classList: classList);
  final RacegoException exception;
}
