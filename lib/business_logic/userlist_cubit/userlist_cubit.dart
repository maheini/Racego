import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'userlist_state.dart';

class UserlistCubit extends Cubit<UserlistState> {
  UserlistCubit() : super(Loading()) {
    reload();
  }
  String _filter = '';

  void reload() async {}

  void setFilter(String filter) {
    _filter = filter;
  }
}
