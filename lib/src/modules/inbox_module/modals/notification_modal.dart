// class PushNotification{
//  String? title ;
//  String? body ;
//  String? dataTitle ;
//  String? dataBody ;
//       PushNotification({this.title, this.body, this.dataTitle, this.dataBody});
// }
class NotificationModel {
  String? name;
  String? purpose;
  String? senderUid;
  String? senderPhoneId;

  NotificationModel({
    this.purpose,
    this.name,
    this.senderPhoneId,
    this.senderUid
  });
//receving data from server

  factory NotificationModel.fromMap(map) {
    return NotificationModel(
      purpose: map['purpose'],
      name: map['firstName'],
      senderPhoneId: map['senderPhoneId'],
      senderUid: map['senderUid'],
    );
  }
// sending data to our server

  Map<String, dynamic> toMap() {
    return {
      'purpose': purpose,
      'firstName': name,
      'senderPhoneId': senderPhoneId,
      'senderUid': senderUid,
    };
  }

  toJson() {}

  static fromJson(i) {}
}
