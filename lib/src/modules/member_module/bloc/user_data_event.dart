abstract class UserDataEvent {
  const UserDataEvent();
}


class InitUserData extends UserDataEvent {
  @override
  String toString() => 'InitLogin';
  @override
  List<Object> get props => [];
}

class GetUserData extends UserDataEvent {
  @override
  List<Object> get props => [];
}