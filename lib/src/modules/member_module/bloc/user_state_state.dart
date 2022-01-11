import 'package:equatable/equatable.dart';
import 'package:mygate_app/src/modules/user/userModal/signup.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
}

class UserDataInitial extends UserDataState {
  @override
  List<Object> get props => [];
}

class UserDataSuccess extends UserDataState {
  List<UserModel> data2;

  UserDataSuccess({required this.data2});
  @override
  List<UserModel> get props => [];
}

class Loading extends UserDataState {
  @override
  List<Object> get props => [];
}

class ErrorReceived extends UserDataState {
  final err;
  const ErrorReceived({this.err});
  ErrorReceived copyWith({var err}) {
    return ErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object?> get props => [err];
}
