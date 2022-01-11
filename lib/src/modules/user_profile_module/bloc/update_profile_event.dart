abstract class UpdateProfileEvent {
  const UpdateProfileEvent();
}

class UpdateInitProfile extends UpdateProfileEvent {
  @override
  String toString() => 'InitLogin';
  @override
  List<Object> get props => [];
}


class CancalUpdateProfile extends UpdateProfileEvent{

}



class UpdateProfileInfo extends UpdateProfileEvent {
  final String? type;
  final String? phone;
  final String? flatno;

  const UpdateProfileInfo({
    required this.type,
    required this.phone,
    required this.flatno,
  });

  @override
  List<Object> get props => [];
}
