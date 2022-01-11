// import 'package:equatable/equatable.dart';
// import 'package:mygate_app/src/modules/user/userModal/signup.dart';

// abstract class ProfileState extends Equatable {
//   const ProfileState();

//   get data2 => null;
// }

// class ProfileInitial extends ProfileState {
//   @override
//   List<Object> get props => [];
// }

// class ProfileSucess extends ProfileState {
//   final data2;
//   const ProfileSucess({required this.data2});
//   @override
//   List<Object> get props => [];
// }

// class updatesuccess extends ProfileState {
//   final data2;
//   const updatesuccess({required this.data2});
//   @override
//   List<Object> get props => [];
// }

// class Load extends ProfileState {
//   @override
//   List<Object> get props => [];
// }

// class ErrorReceived extends ProfileState {
//   final err;
//   const ErrorReceived({this.err});
//   ErrorReceived copyWith({var err}) {
//     return ErrorReceived(err: err ?? this.err);
//   }

//   @override
//   List<Object?> get props => [err];
// }
import 'package:equatable/equatable.dart';
import 'package:mygate_app/src/modules/user/userModal/signup.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  get data2 => null;
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSucess extends ProfileState {
  final data2;
  const ProfileSucess({required this.data2});
  @override
  List<Object> get props => [];
}

class Updatesuccess extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  
}

class Load extends ProfileState {
  @override
  List<Object> get props => [];
}

class ErrorReceived extends ProfileState {
  final err;
  const ErrorReceived({this.err});
  ErrorReceived copyWith({var err}) {
    return ErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object?> get props => [err];
}
