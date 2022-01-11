import 'package:equatable/equatable.dart';

abstract class HomeDataState extends Equatable {
  const HomeDataState();
}

class HomeDataInitial extends HomeDataState {
  @override
  List<Object> get props => [];
}

class HomeDataSuccess extends HomeDataState {
  final data2;
  const HomeDataSuccess( { required this.data2});
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeDataState {
  @override
  List<Object> get props => [];
}

class NoHomeDataFound extends HomeDataState {
  @override
  List<Object> get props => [];
}



class HomeErrorReceived extends HomeDataState {
  final err;
  const HomeErrorReceived({this.err});
  HomeErrorReceived copyWith({var err}) {
    return HomeErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object?> get props => [err];
}
