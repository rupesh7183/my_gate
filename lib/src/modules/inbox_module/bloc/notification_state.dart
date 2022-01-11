import 'package:equatable/equatable.dart';

abstract class NotificationDataState extends Equatable {
  const NotificationDataState();
}

class NotificationDataInitial extends NotificationDataState {
  @override
  List<Object> get props => [];
}

class NotificationDataSuccess extends NotificationDataState {
  final data2;
  const NotificationDataSuccess( { required this.data2});
  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationDataState {
  @override
  List<Object> get props => [];
}

class NoDataFound extends NotificationDataState {
  @override
  List<Object> get props => [];
}
class PositiveSuccess extends NotificationDataState {
  @override
  List<Object> get props => [];
}

class NegitiveSuccess extends NotificationDataState {
  @override
  List<Object> get props => [];
}


class NotificationErrorReceived extends NotificationDataState {
  final err;
  const NotificationErrorReceived({this.err});
  NotificationErrorReceived copyWith({var err}) {
    return NotificationErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object?> get props => [err];
}
