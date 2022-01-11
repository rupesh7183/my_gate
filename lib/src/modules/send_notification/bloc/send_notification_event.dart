import 'dart:ui';

import 'package:camera/camera.dart';

abstract class SendNotificationEvent {
  const SendNotificationEvent();
}

class SendNotification extends SendNotificationEvent {
  @override
  final title;
  final body;
  final room;
 final XFile? url;

  // final picture;
  // final photo;
  const SendNotification({
    required this.title,
    required this.body,
    required this.room,
    required this.url

    //required this.picture
    //required this.photo
  });
  @override
  List<Object> get props => [];
}
class AddData extends  SendNotificationEvent {
  
 final XFile? url;

  const AddData({
     
      required this.url});

  @override
  List<Object> get props => [];
}

class Notificationdispose extends SendNotificationEvent {}
