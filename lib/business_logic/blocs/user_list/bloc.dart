import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListLoading()){
    on<LoadEvent>(_loadList);
  }

  void _loadList(UserListEvent event, Emitter<UserListState> state) {

  }

  // @override
  // Stream<UserListState> mapEventToState(UserListEvent event) async* {
  //   if (event is LoadEvent) {
  //     yield await init();
  //   }
  // }
}
