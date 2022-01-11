// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
// import 'package:mygate_app/src/modules/user/ui/background.dart';
// import 'package:mygate_app/src/modules/user/ui/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RegistrationPage extends StatefulWidget {
//   const RegistrationPage({Key? key}) : super(key: key);

//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }

// GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

// class _RegistrationPageState extends State<RegistrationPage> {
//   bool _isVisible = true;
//   bool isChecked = false;
//   String type = 'Member';
//   late String newValue;
//   UserBloc bloc = UserBloc();

//   void updateStatus() {
//     setState(() {
//       _isVisible = !_isVisible;
//     });
//   }

//   String email = '',
//       password = '',
//       name = "",
//       phoneNo = "",
//       flatNo = "",
//       url = "";
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//         body: SingleChildScrollView(
//             child: Form(
//                 key: _formKey2,
//                 child: Background(
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         padding: EdgeInsets.symmetric(horizontal: 40),
//                         child: Text(
//                           "REGISTER",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                               fontSize: 35),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.05),
//                       Container(
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.symmetric(horizontal: 40),
//                         child: TextFormField(
//                             onChanged: (value) {
//                               name = value;
//                             },
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Enter correct Name";
//                               } else {
//                                 return null;
//                               }
//                             },
//                             decoration: InputDecoration(
//                               labelText: "FullName",
//                               suffixIcon: Icon(Icons.verified_user),
//                             )),
//                       ),
//                       SizedBox(height: size.height * 0.01),
//                       Container(
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.symmetric(horizontal: 40),
//                         child: TextFormField(
//                           onChanged: (value) {
//                             email = value;
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             suffixIcon: Icon(Icons.email),
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty ||
//                                 !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
//                                     .hasMatch(value)) {
//                               return "Enter correct email";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.01),
//                       Container(
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.symmetric(horizontal: 40),
//                         child: TextFormField(
//                           onChanged: (value) {
//                             phoneNo = value;
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Field Can't be empty";
//                             } else if (value.length < 10) {
//                               return "Must be 10 digits";
//                             } else {
//                               return null;
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Phone Number',
//                             suffixIcon: Icon(Icons.verified_user),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.01),
//                       Container(
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.symmetric(horizontal: 40),
//                         child: TextFormField(
//                           onChanged: (value) {
//                             password = value;
//                           },
//                           obscureText: _isVisible ? false : true,
//                           decoration: InputDecoration(
//                               labelText: 'Password',
//                               suffixIcon: IconButton(
//                                 onPressed: () => updateStatus(),
//                                 icon: Icon(_isVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off),
//                               )),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Enter correct password";
//                             } else if (value.length < 6) {
//                               return "Must be more than 6 character";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.01),
//                       Container(
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.symmetric(horizontal: 40),
//                         child: TextFormField(
//                           onChanged: (value) {
//                             flatNo = value;
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Field can't be empty";
//                             } else if (value.length > 4) {
//                               return "Must be more than 4 character";
//                             } else {
//                               return null;
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Flat Number',
//                             suffixIcon: Icon(Icons.verified_user),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text("User Type",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.w400)),
//                             DropdownButton<String>(
//                               value: type,
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   type = newValue!;
//                                 });
//                               },
//                               items: <String>[
//                                 'Security',
//                                 'Member',
//                                 'Administrator'
//                               ].map<DropdownMenuItem<String>>((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                               hint: Text("Select User Type"),
//                               style: TextStyle(color: Colors.grey.shade900),
//                               icon: Icon(Icons.arrow_drop_down_circle),
//                               iconDisabledColor: Colors.grey,
//                               iconEnabledColor: Colors.grey,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       BlocConsumer<UserBloc, UserState>(
//                           bloc: bloc,
//                           listener: (context, state) {
//                             if (state is RegistrationSuccess) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => LoginPage()),
//                               );
//                             }
//                           },
//                           builder: (context, state) {
//                             if (state is Loading) {
//                               return Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             }
//                             return _button();
//                           }),
//                       //     ],
//                       //   ),
//                       // )),
//                       Container(
//                         padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
//                         child: Row(
//                           children: <Widget>[
//                             Text(
//                               'Already have account ?',
//                               style: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => LoginPage()));
//                               },
//                               child: Text(
//                                 ' Login',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.indigo,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                             ),
//                           ],
//                           mainAxisAlignment: MainAxisAlignment.center,
//                         ),
//                       ),
//                     ])))));
//   }

//   Widget _button() {
//     return SizedBox(
//         width: 300,
//         height: 50,
//         child: ElevatedButton(
//             child: Text(
//               "Register",
//               style: TextStyle(color: Colors.black),
//             ),
//             style: styles.button(),
//             onPressed: () {
//               if (vaildateandSaved()) {
//                 bloc.add(
//                   Registration(
//                       email: email,
//                       password: password,
//                       name: name,
//                       phoneNo: phoneNo,
//                       flatNu: flatNo,
//                       type: type),
//                 );
//               } else {}
//             }));
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

//   bool vaildateandSaved() {
//     final form = _formKey2.currentState;
//     if (form!.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
import 'package:mygate_app/src/modules/user/ui/background.dart';
import 'package:mygate_app/src/modules/user/ui/login.dart';
import 'package:mygate_app/src/modules/user/ui/signupsuccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isVisible = true;
  bool isChecked = false;
  String type = 'Member';
  //late String newValue;
  UserBloc bloc = UserBloc();

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  String email = '',
      password = '',
      name = "",
      phoneNo = "",
      flatNo = "",
      url = "";
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
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
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 2),
            child: ListTile(
              title: Text("Sign up with email",
                  style:
                      TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  "Please enter your basic details for sign up process",
                  style:
                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal)),
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Form(
                  key: _formKey2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          // margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                              onChanged: (value) {
                                name = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter correct Name";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "FullName",
                                //suffixIcon: Icon(Icons.verified_user),
                              )),
                        ),
                        SizedBox(height: size.height * 0.01),

                        Container(
                          alignment: Alignment.center,
                          // margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              //suffixIcon: Icon(Icons.email),
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
                        ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          alignment: Alignment.center,
                          // margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            onChanged: (value) {
                              phoneNo = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field Can't be empty";
                              } else if (value.length < 10) {
                                return "Must be 10 digits";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              //suffixIcon: Icon(Icons.verified_user),
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.01),
                        Container(
                          alignment: Alignment.center,
                          // margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            onChanged: (value) {
                              flatNo = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field can't be empty";
                              } else if (value.length > 4) {
                                return "Must be more than 4 character";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Flat Number',
                              // suffixIcon: Icon(Icons.verified_user),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),

                        Container(
                          alignment: Alignment.center,
                          // margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
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
                              if (value!.isEmpty) {
                                return "Enter correct password";
                              } else if (value.length < 6) {
                                return "Must be more than 6 character";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Text("User Type",
                              //     style: TextStyle(
                              //         fontSize: 15,
                              //         color: Colors.grey,
                              //         fontWeight: FontWeight.w400)),
                              DropdownButton<String>(
                                value: type,
                                onChanged: (newValue) {
                                  setState(() {
                                    type = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Security',
                                  'Member',
                                  'Administrator'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text("Select User Type"),
                                style: TextStyle(color: Colors.grey.shade900),
                                icon: Icon(Icons.arrow_drop_down_circle),
                                iconDisabledColor: Colors.grey,
                                iconEnabledColor: Colors.grey,
                                isExpanded: true,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: size.height * 0.02),
                        BlocConsumer<UserBloc, UserState>(
                            bloc: bloc,
                            listener: (context, state) {
                              if (state is RegistrationSuccess) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is Loading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return _button();
                            }),
                        //     ],
                        //   ),
                        // )),
                        Container(
                          padding: EdgeInsets.only(top: 100),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Have you an account?',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            LoginPage()),
                                    ModalRoute.withName('/'),
                                  );
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => LoginPage()));
                                  // Navigator.pop(context);
                                },
                                child: Text(
                                  'Login',
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
                      ])))
        ])));
  }

  Widget _button() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 12, 0, 30),
      child: SizedBox(
          width: 450,
          height: 52,
          child: ElevatedButton(
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              style: styles.button(),
              onPressed: () {
                if (vaildateandSaved()) {
                  bloc.add(
                    Registration(
                        email: email,
                        password: password,
                        name: name,
                        phoneNo: phoneNo,
                        flatNu: flatNo,
                        type: type),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignupSuccessPage()));
                } else {}
              })),
    );
  }

  bool vaildateandSaved() {
    final form = _formKey2.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
