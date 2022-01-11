import 'package:equatable/equatable.dart';
import 'package:mygate_app/src/modules/post_module/modal/information_modal.dart';

abstract class PostState extends Equatable {
  const PostState();

  get data2 => null;
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostAddedSuccess extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostDataSuccess extends PostState {
  List<PostInfoModel>  data;

   PostDataSuccess(this.data);
  @override
  List<Object> get props => [];
}

class PostErrorReceived extends PostState {
  final err;
  const PostErrorReceived({this.err});
  PostErrorReceived copyWith({var err}) {
    return PostErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object?> get props => [err];
}
