// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
// import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
// import 'package:mygate_app/src/modules/user/ui/login.dart';
// import 'package:mygate_app/src/modules/user/ui/registration.dart';

// class ForgotPassword extends StatefulWidget {
//   const ForgotPassword({Key? key}) : super(key: key);

//   @override
//   _ForgotPasswordState createState() => _ForgotPasswordState();
// }

// GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
// String email = "";
// TextEditingController emailController = TextEditingController();
// UserBloc bloc = UserBloc();

// class _ForgotPasswordState extends State<ForgotPassword> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height / 4,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.orange,
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(20, 80, 0, 20),
//                   child: _headerText(
//                       'Forgot Password', 'Please enter you email to continue.'),
//                 ),
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
//               child: Form(
//                 key: _formKey3,
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       TextFormField(
//                         onChanged: (value) {
//                           email = value;
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                           suffixIcon: Icon(Icons.email),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty ||
//                               !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
//                                   .hasMatch(value)) {
//                             return "Enter correct email";
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       BlocConsumer<UserBloc, UserState>(
//                         bloc: bloc,
//                         listener: (context, state) {
//                           if (state is LoginSuccess) {
//                             // go to where ever
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => HomePageManager()));
//                           }
//                           if (state is GoogleLogin) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => HomePageManager()));
//                           }
//                           if (state is FacebookLogin) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => HomePageManager()));
//                           }
//                         },
//                         builder: (context, state) {
//                           if (state is Loading) {
//                             return Center(child: CircularProgressIndicator());
//                           }

//                           return _widbuttton();
//                           //_widbuttton();
//                         },
//                       ),
//                     ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomSheet: Container(
//         child: Row(
//           children: <Widget>[
//             Text(
//               'Does not have account ?',
//               style: TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => RegistrationPage()));
//               },
//               child: Text(
//                 ' Register',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.orange,
//                   fontWeight: FontWeight.w300,
//                 ),
//               ),
//             ),
//           ],
//           mainAxisAlignment: MainAxisAlignment.center,
//         ),
//       ),
//     );
//   }

//   Widget _headerText(header, subtitle) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(header,
//               style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
//           Text(subtitle,
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)),
//         ],
//       ),
//     );
//   }

//   Widget _widbuttton() {
//     return SizedBox(
//         width: 450,
//         height: 50,
//         child: ElevatedButton(
//             child: Text(
//               "Enter",
//               style: TextStyle(color: Colors.black),
//             ),
//             // style: styles.button(),
//             onPressed: () {
//               if (vaildateandSaved()) {
//                 bloc.add(PerfomChangePassword(email: email));
//               } else {}
//             }));
//   }

//   bool vaildateandSaved() {
//     final form = _formKey3.currentState;
//     if (form!.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
import 'package:mygate_app/src/modules/user/ui/login.dart';

import 'package:mygate_app/src/modules/user/ui/success.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
String email = "";
TextEditingController emailController = TextEditingController();
UserBloc bloc = UserBloc();

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: (Color.fromRGBO(23, 195, 131, 1)),
              size: 32,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 266,
              width: 275,
              padding: EdgeInsets.fromLTRB(42, 0, 58, 248),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ResetPassword_img.png'),
                ),
              ),
            ),
            Container(
              child: Center(
                  child: Column(
                children: [
                  Container(
                      child: Center(
                          child: Text("Reset Password",
                              style: TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold)))),
                  Container(
                      padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                      child: Text('Please enter your registered email address.',
                          style: TextStyle(
                            fontSize: 16.0,
                          )))
                ],
              )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 48, 16, 20),
              child: Form(
                key: _formKey3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          // suffixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(value)) {
                            return "Enter correct email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      BlocConsumer<UserBloc, UserState>(
                        bloc: bloc,
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            // go to where ever
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageManager()));
                          }
                          if (state is GoogleLogin) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageManager()));
                          }
                          if (state is FacebookLogin) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageManager()));
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
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerText(header, subtitle) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header,
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
          Text(subtitle,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _widbuttton() {
    return SizedBox(
        width: 450,
        height: 52,
        child: ElevatedButton(
            child: Text(
              "Reset Password",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            style: styles.button(),
            onPressed: () {
              if (vaildateandSaved()) {
                bloc.add(PerfomChangePassword(email: email));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SuccessPage()));
              } else {}
            }));
  }

  bool vaildateandSaved() {
    final form = _formKey3.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
