import 'package:equatable/equatable.dart';

abstract class SendNotificationState extends Equatable {
  const SendNotificationState();
}

class SendNotificartionInitial extends SendNotificationState {
  @override
  List<Object> get props => [];
}

class SendNotificartionSuccess extends SendNotificationState {
  @override
  List<Object> get props => [];
}
class AddDataSuccess extends SendNotificationState {
  @override
  List<Object> get props => [];
}


class LoadingN extends SendNotificationState {
  @override
  List<Object> get props => [];
}

class ErrorReceived extends SendNotificationState {
  final err;
  const ErrorReceived({this.err});
  ErrorReceived copyWith({var err}) {
    return ErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object?> get props => [err];
}

class Dispose extends SendNotificationState {
  List<String>? data;
  Dispose( {this.data});
  @override
  List<Object?> get props => [];
}
