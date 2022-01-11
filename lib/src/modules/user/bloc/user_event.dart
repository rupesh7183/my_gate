part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class PerfomLogin extends UserEvent {
  final String? email;
  final String? password;

  const PerfomLogin({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  @override
  String toString() => 'PerfomLogin { username: $email, password: $password }';
}

class PerfomGoogleLogin extends UserEvent {
  const PerfomGoogleLogin();

  // @override
  List<Object?> get props => [];

  // @override
  // String toString() => 'PerfomGoogleLogin { }';
}

class PerformFacebookLogin extends UserEvent {
  const PerformFacebookLogin();

  List<Object?> get props => [];
}

class Registration extends UserEvent {
  final String? email;
  final String? name;
  final String? phoneNo;
  final String? password;
  final String? flatNu;
  final String? type;

  const Registration({
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNo,
    required this.flatNu,
    required this.type,
  });

  @override
  List<Object?> get props => [email, password];

  @override
  String toString() => 'PerfomLogin { username: $email, password: $password }';
}

class AutoLogin extends UserEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LogOut extends UserEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class InitLogin extends UserEvent {
  @override
  String toString() => 'InitLogin';
  @override
  List<Object> get props => [];
}

class PerfomChangePassword extends UserEvent {
  final String email;

  const PerfomChangePassword({
    required this.email,
  });

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'PerfomLogin { , email: $email }';
}
class Clear extends UserEvent {}