import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mygate_app/src/globals.dart';
import 'package:mygate_app/src/modules/inbox_module/modals/notification_modal.dart';

import 'package:mygate_app/src/modules/send_notification/modals/visitor_update.dart';
import 'package:mygate_app/src/service/db_service_respoance_modal.dart';
import 'package:mygate_app/src/service/dbservices.dart';

import 'notification_event.dart';
import 'notification_state.dart';

class NotificationDataBloc
    extends Bloc<NotificationDataEvent, NotificationDataState> {
  NotificationDataBloc() : super(NotificationDataInitial());
  final DbServices _dbServices = DbServices();
  NotificationModel notificationModel = NotificationModel();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  VisitorDetailsModel visitorDetailsModel = VisitorDetailsModel();
  var data;
  @override
  Stream<NotificationDataState> mapEventToState(
    NotificationDataEvent event,
  ) async* {
    //auto login bloc
    if (event is GetNotificationData) {
      try {
        yield NotificationLoading();

        List data = await fatchUserNotificationData();

        yield NotificationDataSuccess(data2: data);
        print(data);
      } catch (e) {
        yield NotificationErrorReceived();
        throw Exception("failed");
      }
    }
    if (event is PositiveRespoance) {
      try {
        yield NotificationLoading();
        await getingAdministratorid();
        await updateNotificationData('approved');
        bool result = await sendPositiveRespoance('approved');
        if (result) {
          yield PositiveSuccess();
        }
      } catch (e) {
        yield NotificationErrorReceived();
        throw Exception("failed");
      }
    }
    if (event is NegativeRespoance) {
      try {
        yield NotificationLoading();
        await getingAdministratorid();
        await updateNotificationData('denied');
        bool result = await sendPositiveRespoance('denied');
        if (result) {
          yield NegitiveSuccess();
        }
        // bool result = await sendPositiveRespoance('denied');
        // data = await fatchNotificationData();
        // if (result) {
        //   yield NotificationDataSuccess(data2: data);
        // } else {
        //   yield NotificationDataSuccess(data2: data);
        // }
      } catch (e) {
        yield NotificationErrorReceived();
        throw Exception("failed");
      }
    }
  }
//  New fatching notification data

  Future fatchUserNotificationData() async {
    var data;
    try {
      // Globals.token
      await FirebaseFirestore.instance
          .collection(Globals.token)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          data = querySnapshot.docs
              .map((doc) => VisitorDetailsModel.fromSnapshot(doc))
              .toList();
          // doc.data()).toList();
          print(data);
          return data;
        }
      });
      // fatching document id //Globals.linkUsername

      // geting administrator details
      return data;
    } catch (e) {
      throw Exception("ds");
    }
  }

// getting sender phone id
  Future getingAdministratorid() async {
    try {
      await FirebaseFirestore.instance
          .collection('document_id')
          .doc(Globals.name)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          data = documentSnapshot.data();
          print(data);
          // data = documentSnapshot.data();
          Globals.notificationDocid = data['documentId'];

          // return data as List<UserModel>;
        } else {
          print('Document does not exist on the database');
        }
      });

      await FirebaseFirestore.instance
          .collection('VisitorDetails')
          .doc(Globals.notificationDocid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          data = documentSnapshot.data();
          print(data);
          // data = documentSnapshot.data();
          Globals.administratorPhoneId = data['senderPhoneId'];
          Globals.visiterName = data['firstName'];

          // return data as List<UserModel>;
        } else {
          print('Document does not exist on the database');
        }
      });
    } catch (e) {
      throw Exception("ds");
    }
  }

  // updating collection
  Future updateNotificationData(respo) async {
    try {
      await FirebaseFirestore.instance
          .collection('VisitorDetails')
          .doc(Globals.notificationDocid)
          .update({'status': respo});
      await FirebaseFirestore.instance
          .collection(Globals.token)
          .doc(Globals.notificationDocid)
          .update({'status': respo});
      await FirebaseFirestore.instance
          .collection('document_id')
          .doc(Globals.linkUsername)
          .delete();
    } catch (e) {
      throw Exception("ds");
    }
  }

// New

  Future<bool> sendPositiveRespoance(respo) async {
    try {
      const basicAuth =
          "key=AAAAAfLumW0:APA91bFQBAkvdwlDi8O1CLSG7WOquEmfdbbJ-nxirCjgBSTJE7izD7A-bTxD8ln1RF01TCGdfe59hER08cNy_8eJtlVN_U4nYKIqblPVABVOV9K6vGK4mNlshUZanZm85GppS3kO4xqm";
      final ResponseModel response =
          await _dbServices.postapi('fcm/send', headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json'
      }, body: {
        "to": Globals.administratorPhoneId,
        "priority": "high",
        "notification": {
          "title": respo,
          "body": Globals.visiterName,
          "text": "Text"
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
