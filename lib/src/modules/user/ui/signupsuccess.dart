import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
import 'package:mygate_app/src/modules/user/ui/login.dart';
import 'package:mygate_app/src/modules/user/ui/registration.dart';

class SignupSuccessPage extends StatefulWidget {
  const SignupSuccessPage({Key? key}) : super(key: key);

  @override
  _SignupSuccessPageState createState() => _SignupSuccessPageState();
}

GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

TextEditingController emailController = TextEditingController();
UserBloc bloc = UserBloc();

class _SignupSuccessPageState extends State<SignupSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 183),
          ),
          Container(
            height: 266,
            width: 275,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/successfully_img.png',
                ),
              ),
            ),
          ),
          Container(
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("You've signed up",
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
                Center(
                  child: Text('successfully',
                      style: TextStyle(
                          fontSize: 32.0, fontWeight: FontWeight.bold)),
                )
              ],
            )),
          ),

          Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(children: [
                Text('Congratulations,your account has been',
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                Center(
                  child: Text('successfully created.',
                      style: TextStyle(
                        fontSize: 16.0,
                      )),
                )
              ])),

          Padding(
              padding: EdgeInsets.fromLTRB(16, 140, 16, 0),
              child: _widbuttton())
          //_widbuttton();
        ]),
      ),
    );
  }

  Widget _widbuttton() {
    return SizedBox(
        width: 450,
        height: 52,
        child: ElevatedButton(
            child: Text(
              "Okay, Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            style: styles.button(),
            onPressed: () {}));
  }
}
