import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygate_app/src/globals.dart';
import 'package:mygate_app/src/modules/inbox_module/modals/notification_modal.dart';
import 'package:mygate_app/src/modules/send_notification/list.dart';
import 'package:mygate_app/src/modules/send_notification/modals/visitor_update.dart';
import 'package:mygate_app/src/modules/user/userModal/signup.dart';
import 'package:mygate_app/src/service/db_service_respoance_modal.dart';
import 'package:mygate_app/src/service/dbservices.dart';

import 'send_notification_event.dart';
import 'send_notification_state.dart';

class SendNotificationBloc
    extends Bloc<SendNotificationEvent, SendNotificationState> {
  SendNotificationBloc() : super(SendNotificartionInitial());

  final DbServices _dbServices = DbServices();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  NotificationModel notificationModel = NotificationModel();
  DropDown dropDown = DropDown();

  VisitorDetailsModel visitorDetailsModel = VisitorDetailsModel();

  @override
  Stream<SendNotificationState> mapEventToState(
    SendNotificationEvent event,
  ) async* {
    //auto login bloc
    if (event is SendNotification) {
      try {
        yield LoadingN();
        await dropdownListSort(event.room);
        await visitorDataUpdate(event.title, event.body, event.room, event.url);
        await sendNotification(event.title, event.body, event.url);

        // await addNotificationdata(event.title, event.body);

        // bool result = await sendNotification(event.title, event.body);
        // // await visitorDataUpdate();
        // if (result) {
        //
        yield SendNotificartionSuccess();
        // } else {
        //   yield ErrorReceived();
        // }
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    } else if (event is AddData) {
      try {
        yield LoadingN();

        // bool data1 = await UpdateProfileData(
        //     event.firstName, event.phone, event.flatno, event.image);
        await AddProfileData(event.url);

        yield SendNotificartionSuccess();
        // } else {
      } catch (e) {
        throw Exception("failed");
      }
    }
    if (event is Notificationdispose) {
      try {
        List<String> dropDown1 = await getDropDownList();
        print(dropDown1);
        yield Dispose(data: dropDown1.toList());
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }
  }

  Future visitorDataUpdate(name, purpose, room, path) async {
    String documentId = '';

    try {
      String? imageUrl;

      Reference reference =
          FirebaseStorage.instance.ref().child("image").child(Globals.token);
      File file = File(path.path);
      UploadTask uploadTask = reference.putFile(file);
      imageUrl = await reference.getDownloadURL();
      // await FirebaseFirestore.instance
      //     .collection('Visitor')
      //     .doc(Globals.token)
      //     .set({
      //   'url': imageUrl,
      // });
      Fluttertoast.showToast(
        msg: "ADD successful",
      );
      // } catch (e) {
      //   print(e);
      //   return false;
      // }

      visitorDetailsModel.name = name;
      visitorDetailsModel.purpose = purpose;
      visitorDetailsModel.administratorPhoneId = Globals.administratorPhoneId;
      visitorDetailsModel.status = "Pending";
      visitorDetailsModel.administratorUid = Globals.token;
      visitorDetailsModel.roomNo = room;
      visitorDetailsModel.picture = imageUrl;
      Timestamp stamp = Timestamp.now();
      visitorDetailsModel.createdAt = stamp.toDate().toString();
      // await firebaseFirestore
      //     .collection("VisitorDetails")
      //     .doc(Globals.token)
      //     .set({
      //   'url': imageUrl,
      // });
      await firebaseFirestore
          .collection("VisitorDetails")
          .add(visitorDetailsModel.toMap())
          .then((value) { 
        documentId = value.id;
        print(value.id);
      });

      await firebaseFirestore
          .collection("document_id")
          .doc(Globals.memberName)
          .set({'documentId': documentId});
      await firebaseFirestore
          .collection(Globals.memberUid)
          .doc(documentId)
          .set(visitorDetailsModel.toMap());
    } catch (e) {
      throw Exception("");
    }
  }

  Future<bool> AddProfileData(url) async {
    bool data;
    try {
      String? imageUrl;

      Reference reference =
          FirebaseStorage.instance.ref().child("image").child(Globals.token);
      File file = File(url.path);
      UploadTask uploadTask = reference.putFile(file);
      imageUrl = await reference.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(Globals.token)
          .set({
        'url': imageUrl,
      });
      Fluttertoast.showToast(
        msg: "ADD successful",
      );
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future dropdownListSort(room) async {
    var data;
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        data = querySnapshot.docs
            .map((doc) => UserModel.fromSnapshot(doc))
            .toList();
        // doc.data()).toList();
        print(data);
        for (int i = 0; i < data.length; i++) {
          if (room == data[i].flatno) {
            Globals.reciverPhoneId = data[i].userid;
            Globals.memberUid = data[i].uid;
            Globals.memberName = data[i].firstName;
          }
        }
      }
    });
  }

  Future<List<String>> getDropDownList() async {
    try {
      var data;
      await FirebaseFirestore.instance
          .collection("users")
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          data = querySnapshot.docs
              .map((doc) => UserModel.fromSnapshot(doc))
              .toList();
          // doc.data()).toList();
          print(data);
          return data;
        }
      });
      dropDown.list.clear();
      for (int i = 0; i < data.length; i++) {
        dropDown.list.add(data[i].flatno);
      }
      return dropDown.list;
    } catch (e) {
      throw Exception("");
    }
  }

  Future<bool> sendNotification(name, purpose, picture) async {
    try {
      const basicAuth =
          "key=AAAAAfLumW0:APA91bFQBAkvdwlDi8O1CLSG7WOquEmfdbbJ-nxirCjgBSTJE7izD7A-bTxD8ln1RF01TCGdfe59hER08cNy_8eJtlVN_U4nYKIqblPVABVOV9K6vGK4mNlshUZanZm85GppS3kO4xqm";
      final ResponseModel response =
          await _dbServices.postapi('fcm/send', headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json'
      }, body: {
        "to": Globals.reciverPhoneId,
        "priority": "high",
        "notification": {
          "title": name,
          "body": purpose,
          "text": "Text",
          "url": visitorDetailsModel.picture
        }
      });

      final data = response.data;
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
