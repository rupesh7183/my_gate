abstract class HomeDataEvent {
  const HomeDataEvent();
}


class HomeNotificationData extends HomeDataEvent {
  @override
  String toString() => 'InitLogin';
  @override
  List<Object> get props => [];
}

