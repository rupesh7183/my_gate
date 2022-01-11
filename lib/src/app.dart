import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mygate_app/main.dart';
import 'package:mygate_app/src/modules/inbox_module/ui/notification.dart';
import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
import 'package:mygate_app/src/modules/user/ui/setup.dart';
import 'package:mygate_app/src/modules/user/ui/splashscreen.dart';
import 'package:overlay_support/overlay_support.dart';

import 'globals.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

UserBloc _user = UserBloc();

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
          theme: ThemeData(
              fontFamily: 'Raleway',
              primarySwatch: Colors.green,
              iconTheme: IconThemeData(color: Colors.orange),
              buttonTheme: ButtonThemeData(
                  focusColor: Colors.orange, buttonColor: Colors.orange),
              primaryColor: Colors.orange.shade400,
              focusColor: Colors.orange),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: SplashScreen()),
    );
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
      Globals.currentUserid = token;
      Globals.administratorPhoneId = token;
    });
    print(token);
  }
}
