import 'package:flutter/material.dart';

import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';

import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
import 'package:mygate_app/src/modules/user/ui/login.dart';


class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

TextEditingController emailController = TextEditingController();
UserBloc bloc = UserBloc();

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 183, 0, 0)),
          Container(
            height: 266,
            width: 275,
            // padding: EdgeInsets.fromLTRB(42, 300, 58, 166),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/Success_img.png',
                ),
              ),
            ),
          ),
          Container(
            child: Center(
                child: Column(
              children: [
                Container(
                    child: Center(
                        child: Text("Success!",
                            style: TextStyle(
                                fontSize: 32.0, fontWeight: FontWeight.bold)))),
                Container(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                    child: Column(children: [
                      Text('Please check your registered email to reset',
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      Center(
                        child: Text('your password.',
                            style: TextStyle(
                              fontSize: 16.0,
                            )),
                      )
                    ]))
              ],
            )),
          ),

          Padding(
              padding: EdgeInsets.fromLTRB(16, 50, 16, 0), child: _widbuttton())
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
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            style: styles.button(),
            onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()));
            }));
  }
}
