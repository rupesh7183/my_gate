abstract class NotificationDataEvent {
  const NotificationDataEvent();
}


class NotificationData extends NotificationDataEvent {
  @override
  String toString() => 'InitLogin';
  @override
  List<Object> get props => [];
}

class GetNotificationData extends NotificationDataEvent {
  @override
  List<Object> get props => [];
}
class PositiveRespoance extends NotificationDataEvent {
  
  @override
  List<Object> get props => [];
}
class NegativeRespoance extends NotificationDataEvent {
  @override
  List<Object> get props => [];
}