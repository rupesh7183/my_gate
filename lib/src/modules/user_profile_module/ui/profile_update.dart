import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
import 'package:mygate_app/src/modules/user/ui/login.dart';

import 'package:mygate_app/src/modules/user_profile_module/bloc/update_profile_bloc.dart';
import 'package:mygate_app/src/modules/user_profile_module/bloc/update_profile_event.dart';
import 'package:mygate_app/src/modules/user_profile_module/bloc/update_profile_state.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController flatEditingController = TextEditingController();
  UpdateProfileBloc updateProfileBloc = UpdateProfileBloc();
  String type = 'Member';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icon(Icons.close),
              iconSize: 30,
              color: (Color.fromRGBO(23, 195, 131, 1)),
            ),
            title: Text("Edit Profile", style: TextStyle(color: Colors.black)),
            actions: [
              IconButton(
                icon: Icon(Icons.done),
                iconSize: 40,
                color: Colors.grey,
                onPressed: () {
                  updateProfileBloc.add(UpdateProfileInfo(
                      flatno: flatEditingController.text,
                      phone: phoneEditingController.text,
                      type: type));
                },
              )
            ]),
        body: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
            bloc: updateProfileBloc,
            listener: (context, state) {
              if (state is ProfileUpdateSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageManager()),
                );
              }
            },
            builder: (context, state) {
              if (state is UpdateLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Column(children: [
                  buildTextField('Phone Number', phoneEditingController),
                  buildTextField('Flat Number', flatEditingController),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User Type",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        DropdownButton<String>(
                          value: type,
                          onChanged: (newValue) {
                            setState(() {
                              type = newValue!;
                            });
                          },
                          items: <String>['Security', 'Member', 'Administrator']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text("Select User Type",
                              style: TextStyle(
                                color: Colors.red,
                              )),
                          style: TextStyle(color: Colors.grey.shade900),
                          icon: Icon(Icons.arrow_drop_down_circle),
                          iconDisabledColor: Colors.grey,
                          iconEnabledColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ]),
              );
            }));
  }
}

Widget buildTextField(
  String labelText,
  TextEditingController controller,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
      controller: controller,
      autocorrect: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    ),
  );
}
