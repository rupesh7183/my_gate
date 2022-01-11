import 'package:flutter/material.dart';
import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
import 'package:mygate_app/src/modules/send_notification/bloc/send_notification_event.dart';
import 'package:mygate_app/src/modules/send_notification/ui/send_notification.dart';
import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_app/src/modules/user/field_validation/field_validation.dart';
import 'package:mygate_app/src/modules/user/ui/registration.dart';
import 'package:mygate_app/src/modules/user_profile_module/ui/profile_update.dart';
import 'package:mygate_app/src/style.dart';

import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

Styles styles = Styles();
FieldValidation fieldValidation = FieldValidation();

class _LoginPageState extends State<LoginPage> {
  final String assetName = 'assets/google.svg';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;
  String email = '', password = '';
  UserBloc bloc = UserBloc();
  UserBloc bloc1 = UserBloc();

  bool _isVisible = true;

  login() async {
    bloc.add(PerfomLogin(
      email: email,
      password: password,
    ));
  }

  googlelogin() async {
    bloc.add(PerfomGoogleLogin());
  }

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 90, 0, 12),
            child: Text('Login',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(16, 10, 20, 0),
            child: Form(
              key: _formKey,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                    padding: EdgeInsets.fromLTRB(16, 10, 20, 0),
                    child: Column(children: [
                      TextFormField(
                        onSaved: (value) {
                          email = value!;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username',
                          // suffixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          // FieldValidation.validateEmail(value!);
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(value)) {
                            return "Enter correct email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: _isVisible ? false : true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () => updateStatus(),
                              icon: Icon(_isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )),
                        validator: (value) {
                          fieldValidation.validatePassword(value!);
                          // if (value.isEmpty) {
                          //   return "Enter correct password";
                          // } else if (value.length < 6) {
                          //   return "Must be more than 6 character";
                          // } else {
                          //   return null;
                          // }
                        },
                      ),
                    ])),
                Container(
                  padding: EdgeInsets.fromLTRB(80, 15, 16, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                BlocConsumer<UserBloc, UserState>(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      // bloc.add(AutoLogin());
                      // go to where ever

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePageManager()),
                          (Route<dynamic> route) => false);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomePageManager()));
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return _widbuttton();
                    //_widbuttton();
                  },
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Or continue with",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                BlocConsumer<UserBloc, UserState>(
                  bloc: bloc1,
                  listener: (context, state) {
                    if (state is GoogleLogin) {
                      // go to where ever
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePageManager()),
                          (Route<dynamic> route) => false);
                    }
                    if (state is GoogleLoginUpdateProfile) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UpdateProfilePage()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return _googleFacebookButton();
                    //_widbuttton();
                  },
                  //_widbuttton();
                ),
              ]),
            ),
          ),
        ],
      )),
      bottomSheet: Container(
        child: Row(
          children: <Widget>[
            Text(
              'Does not have account?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => RegistrationPage()),
                  ModalRoute.withName('/'),
                );
              },
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(23, 195, 131, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  Widget _googleFacebookButton() {
    return Container(
        padding: EdgeInsets.only(top: 24),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 60,
            width: 70,
            child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(width: 0, color: Colors.grey)),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      bloc1.add(PerfomGoogleLogin());
                    },
                    icon: Image.asset(
                      'assets/facebook.jpg',
                    ),
                  ),
                )),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            height: 60,
            width: 70,
            child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(width: 0, color: Colors.grey)),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      bloc1.add(PerfomGoogleLogin());
                    },
                    icon: Image.asset(
                      'assets/google.png',
                    ),
                  ),
                )),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            height: 60,
            width: 70,
            child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(width: 0, color: Colors.grey)),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      bloc1.add(PerfomGoogleLogin());
                    },
                    icon: Image.asset(
                      'assets/email.jpg',
                    ),
                  ),
                )),
          ),
        ]));
  }

  Widget _headerText(
    header,
  ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header,
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _widbuttton() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 30),
      child: SizedBox(
          width: 450,
          height: 52,
          child: ElevatedButton(
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              style: styles.button(),
              onPressed: () {
                if (vaildateandSaved()) {
                  login();
                } else {
                  print("not login");
                }
              })),
    );
  }

  bool vaildateandSaved() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
