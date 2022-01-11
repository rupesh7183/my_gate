// import 'package:image_picker/image_picker.dart';

// abstract class ProfileEvent {
//   const ProfileEvent();
// }

// class InitProfile extends ProfileEvent {
//   @override
//   String toString() => 'InitLogin';
//   @override
//   List<Object> get props => [];
// }

// class GetProfile extends ProfileEvent {
//   @override
//   List<Object> get props => [];
// }

// class UpdateProfile extends ProfileEvent {
//   final String? firstName;
//   final String? phone;
//   final String? flatno;
//  final XFile? url;

//   const UpdateProfile(
//       {required this.firstName,
//       required this.phone,
//       required this.flatno,
//       required this.url});

//   @override
//   List<Object> get props => [];
// }
// class AddData extends ProfileEvent {
  
//  final XFile? url;

//   const AddData({
     
//       required this.url});

//   @override
//   List<Object> get props => [];
// }
import 'package:image_picker/image_picker.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class InitProfile extends ProfileEvent {
  @override
  String toString() => 'InitLogin';
  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class UpdateProfile extends ProfileEvent {
  final String? firstName;
  final String? phone;
  final String? flatno;
 final XFile? url;

  const UpdateProfile(
      {required this.firstName,
      required this.phone,
      required this.flatno,
      this.url});

  @override
  List<Object> get props => [];
}
class AddData extends ProfileEvent {
  
 final XFile? url;

  const AddData({
     
      required this.url});

  @override
  List<Object> get props => [];
}

