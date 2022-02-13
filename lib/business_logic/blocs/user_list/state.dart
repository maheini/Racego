class UserListState {
  UserListState init() {
    return UserListState();
  }

  UserListState clone() {
    return UserListState();
  }
}

class UserListLoading extends UserListState{

}

class UserListLoaded extends UserListState{

}