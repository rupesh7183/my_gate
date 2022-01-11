import 'package:image_picker/image_picker.dart';

abstract class PostEvent {
  const PostEvent();
}

class PostInitProfile extends PostEvent {
  @override
  String toString() => 'InitLogin';
  @override
  List<Object> get props => [];
}


class GetPostDetails extends PostEvent{

}



class AddPostInfo extends PostEvent {
  final String? title;
  final String? description;
  final XFile? image;

  const AddPostInfo({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  List<Object> get props => [];
}
