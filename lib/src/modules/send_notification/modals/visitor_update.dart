import 'package:cloud_firestore/cloud_firestore.dart';

class VisitorDetailsModel {
  String? name;
  String? purpose;
  String? administratorUid;
  String? administratorPhoneId;
  String? status;
  String? roomNo;
  String? picture;
  String? createdAt;

  VisitorDetailsModel(
      {this.purpose,
      this.name,
      this.administratorPhoneId,
      this.administratorUid,
      this.status,
      this.roomNo,
      this.picture,
      this.createdAt});
//receving data from server

  factory VisitorDetailsModel.fromMap(map) {
    return VisitorDetailsModel(
        purpose: map['purpose'],
        name: map['firstName'],
        administratorPhoneId: map['senderPhoneId'],
        administratorUid: map['senderUid'],
        status: map['status'],
        roomNo: map['roomNo'],
        picture: map['picture'],
        createdAt: map['createdAt']);
  }
// sending data to our server

  Map<String, dynamic> toMap() {
    return {
      'purpose': purpose,
      'firstName': name,
      'senderPhoneId': administratorPhoneId,
      'senderUid': administratorUid,
      'status': status,
      'roomNo': roomNo,
      'url': picture,
      //url
      'createdAt': createdAt,
    };
  }

  toJson() {}

  static fromJson(i) {}

  VisitorDetailsModel.fromSnapshot(DocumentSnapshot snap)
      :

        //  Video(

        purpose = snap['purpose'],
        name = snap['firstName'],
        administratorPhoneId = snap['senderPhoneId'],
        administratorUid = snap['senderUid'],
        status = snap['status'],
        roomNo = snap['roomNo'],
        picture = snap['url'],
        // url
        createdAt = snap['createdAt'];
}
