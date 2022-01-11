import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? firstName;
  String? email;
  String? uid;
  String? phone;
  String? flatno;
  String? userid;
  String? type;
  String? url;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.phone,
    this.flatno,
    this.userid,
    this.type,
    this.url,
  });

//receving data from server

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        phone: map['phone'],
        flatno: map['flatno'],
        userid: map['userid'],
        type: map['type'],
        url: map['url']);
  }
// sending data to our server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'phone': phone,
      'flatno': flatno,
      'userid': userid,
      'type': type,
      'url': url
    };
  }

  toJson() {}

  static fromJson(i) {}

  UserModel.fromSnapshot(DocumentSnapshot snap)
      :

        //  Video(

        uid = snap['uid'],
        flatno = snap['flatno'],
        phone = snap['phone'],
        email = snap['email'],
        userid = snap['userid'],
        firstName = snap['firstName'],
        type = snap['type'],
        url = snap['url'];

  // percentage = snap['percentage'].toDouble(),

  // pic = snap['pic'],

  // position = snap['position'],

  // thumnailUrl = snap['thumnailUrl'],

  // title = snap['title'],

  // viewCount = snap['viewCount'];

  //   );

}
