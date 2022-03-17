import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rankingcubit_state.dart';

class RankingcubitCubit extends Cubit<RankingcubitState> {
  RankingcubitCubit()
      : super(const RankingLoading(currentClass: '', classList: [])) {
    loadClasses();
  }
  List<String> _classes = [];
  String _currentClass = '';

  Future<void> loadClasses() async {}
}
