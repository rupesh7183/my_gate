import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
import 'package:mygate_app/src/modules/user/ui/login.dart';
import 'package:mygate_app/src/modules/user/ui/setup.dart';
import 'package:mygate_app/src/service/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserBloc bloc = UserBloc();
  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/splash.png'), fit: BoxFit.fitWidth),
          ),
        ),
        Positioned(
          top: 266,
          bottom: 299,
          left: 88,
          right: 87,
          child: Container(
            height: 812,
            width: 375,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/arbiter-logo_v2.png',
                ),
                scale: 0.8,
              ),
            ),
          ),
        )
      ]),
    );
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 5), ondoneloading);
  }

  ondoneloading() async {
    var sharedPreferencesFn = SharedPreferencesFn;

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SetupPage()));
  }
}
