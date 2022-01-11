import 'package:equatable/equatable.dart';


abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  get data2 => null;
}

class ProfileInitial extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class ProfileUpdateSuccess extends UpdateProfileState {
  
  @override
  List<Object> get props => [];
}

class UpdateLoading extends UpdateProfileState {
  @override
  List<Object> get props => [];
}
class UpdateCancel extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class UpdateErrorReceived extends UpdateProfileState {
  final err;
  const UpdateErrorReceived({this.err});
  UpdateErrorReceived copyWith({var err}) {
    return UpdateErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object?> get props => [err];
}
