
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
// import 'package:mygate_app/src/modules/profile_module/bloc/profile_bloc.dart';
// import 'package:mygate_app/src/modules/profile_module/bloc/profile_event.dart';
// import 'package:mygate_app/src/modules/profile_module/bloc/profile_state.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({Key? key}) : super(key: key);

//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final ImagePicker _picker = ImagePicker();
//   ProfileBloc profileBloc = ProfileBloc();
//   String firstName = "", phone = "", flatno = "";
//   XFile? url;

//   TextEditingController firstnameediting = TextEditingController();
//   TextEditingController phoneediting = TextEditingController();
//   TextEditingController flatnumberediting = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     profileBloc.add(GetProfile());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.white,
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.close),
//               iconSize: 30,
//               color: (Color.fromRGBO(23, 195, 131, 1)),
//             ),
//             title: Text("Edit Profile", style: TextStyle(color: Colors.black)),
//             actions: [
//               IconButton(
//                 icon: Icon(Icons.done),
//                 iconSize: 40,
//                 color: Colors.grey,
//                 onPressed: () {
//                   profileBloc.add(UpdateProfile(
//                       firstName: firstnameediting.text,
//                       phone: phoneediting.text,
//                       flatno: flatnumberediting.text,
//                       url: url));
//                 },
//               )
//             ]),
//         body: BlocListener<ProfileBloc, ProfileState>(
//           bloc: profileBloc,
//           listener: (context, state) {
//             if (state is updatesuccess) {
//               Navigator.pop(context);
//             }
//           },
//           child: BlocBuilder<ProfileBloc, ProfileState>(
//               bloc: profileBloc,
//               builder: (context, state) {
//                 if (state is Load) {
//                   return Center(
//                     child: Center(child: CircularProgressIndicator()),
//                   );
//                 } else if (state is ProfileSucess) {
//                   return Container(
//                       padding: EdgeInsets.only(left: 16, top: 25, right: 16),
//                       child: Column(
//                         children: [
//                           Container(
//                             child: url != null
//                                 // ? CircleAvatar(
//                                 //     radius: 50,
//                                 //     child: Image.file(
//                                 //       File(url!.path),
//                                 //       width: 100,
//                                 //       height: 100,
//                                 //       fit: BoxFit.fitHeight,
//                                 //     ),
//                                 //     backgroundColor: Colors.grey,
//                                 //   )
//                                 ? SizedBox(
//                                     height: 115,
//                                     width: 115,
//                                     child: Stack(
//                                       clipBehavior: Clip.none,
//                                       fit: StackFit.expand,
//                                       children: [
//                                         CircleAvatar(
//                                           child: ClipOval(
//                                             child: Image.file(
//                                               File(url!.path),
//                                               width: 100,
//                                               height: 100,
//                                               fit: BoxFit.fitHeight,
//                                             ),
//                                           ),
//                                           backgroundColor:
//                                               Colors.brown.shade200,
//                                         ),
//                                         Positioned(
//                                             bottom: 0,
//                                             //left: -25,
//                                             right: -25,
//                                             child: RawMaterialButton(
//                                               onPressed: () {
//                                                 _imgFromGallery();
//                                               },
//                                               elevation: 2.0,
//                                               fillColor: Color.fromRGBO(
//                                                   23, 195, 131, 1),
//                                               child: Icon(
//                                                 Icons.camera_alt_rounded,
//                                                 color: Colors.white,
//                                               ),
//                                               // padding: EdgeInsets.all(15.0),
//                                               shape: CircleBorder(),
//                                             )),
//                                       ],
//                                     ),
//                                   )
//                                 : SizedBox(
//                                     height: 115,
//                                     width: 115,
//                                     child: Stack(
//                                       clipBehavior: Clip.none,
//                                       fit: StackFit.expand,
//                                       children: [
//                                         CircleAvatar(
//                                           child: Text(
//                                             '${state.data2.firstName[0]}',
//                                             style: TextStyle(
//                                                 fontSize: 50,
//                                                 color: Colors.white),
//                                           ),
//                                           backgroundColor:
//                                               Colors.brown.shade200,
//                                         ),
//                                         Positioned(
//                                             bottom: 0,
//                                             right: -25,
//                                             child: RawMaterialButton(
//                                               onPressed: () {
//                                                 _imgFromGallery();
//                                               },
//                                               elevation: 2.0,
//                                               fillColor: Color.fromRGBO(
//                                                   23, 195, 131, 1),
//                                               child: Icon(
//                                                 Icons.camera_alt_rounded,
//                                                 color: Colors.white,
//                                               ),
//                                               padding: EdgeInsets.all(15.0),
//                                               shape: CircleBorder(),
//                                             )),
//                                       ],
//                                     ),
//                                   ),
//                           ),
//                           buildTextField(
//                               "FullName",
//                               firstnameediting.text = state.data2.firstName,
//                               firstnameediting),
//                           buildTextField(
//                               "Phone Number",
//                               phoneediting.text = state.data2.phone,
//                               phoneediting),
//                           buildTextField(
//                               "Flat Number",
//                               flatnumberediting.text = state.data2.flatno,
//                               flatnumberediting),
//                           SizedBox(
//                             height: 5,
//                           ),
//                         ],
//                       ));
//                 }
//                 return Container();
//               }),
//         ));
//   }

//   _imgFromGallery() async {
//     try {
//       final pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 50,
//       );
//       setState(() {
//         url = pickedFile;
//       });
//     } catch (e) {
//       throw Exception("");
//     }
//   }
//   // Future uploadPic(BuildContext context) async{
//   //     String fileName = basename(_image?.path);
//   //      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
//   //      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
//   //      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
//   //      setState(() {
//   //         print("Profile Picture uploaded");
//   //         Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
//   //      });
//   //   }

//   Widget buildTextField(
//     String labelText,
//     String placeholder,
//     TextEditingController controller,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
//       child: TextField(
//         controller: controller,
//         autocorrect: true,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(bottom: 3),
//             labelText: labelText,
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             // hintText: placeholder,
//             hintStyle: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             )),
//       ),
//     );
//   }
// }
// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
// import 'package:mygate_app/src/modules/profile_module/bloc/profile_bloc.dart';
// import 'package:mygate_app/src/modules/profile_module/bloc/profile_event.dart';
// import 'package:mygate_app/src/modules/profile_module/bloc/profile_state.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({Key? key}) : super(key: key);

//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   ProfileBloc profileBloc = ProfileBloc();
//   String firstName = "", phone = "", flatno = "";

//   TextEditingController firstnameediting = TextEditingController();
//   TextEditingController phoneediting = TextEditingController();
//   TextEditingController flatnumberediting = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     profileBloc.add(GetProfile());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.white,
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomePageManager()),
//                 );
//               },
//               icon: Icon(Icons.close),
//               iconSize: 30,
//               color: Colors.black,
//             ),
//             title: Text("Edit Profile", style: TextStyle(color: Colors.black)),
//             actions: [
//               IconButton(
//                 icon: Icon(Icons.done),
//                 iconSize: 30,
//                 color: Colors.black,
//                 onPressed: () {
//                   profileBloc.add(UpdateProfile(
//                       firstName: firstnameediting.text,
//                       phone: phoneediting.text,
//                       flatno: flatnumberediting.text));
//                 },
//               )
//             ]),
//         body: BlocListener<ProfileBloc, ProfileState>(
//           bloc: profileBloc,
//           listener: (context, state) {
//             if (state is updatesuccess) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomePageManager()),
//               );
//             }
//           },
//           child: BlocBuilder<ProfileBloc, ProfileState>(
//               bloc: profileBloc,
//               builder: (context, state) {
//                 if (state is Loading) {
//                   return Center(
//                     child: Center(child: CircularProgressIndicator()),
//                   );
//                 } else if (state is ProfileSucess) {
//                   return Container(
//                       padding: EdgeInsets.only(left: 16, top: 25, right: 16),
//                       child: ListView(
//                         children: [
//                           CircleAvatar(
//                             radius: 50,
//                             child: Text(
//                               '${state.data2.firstName[0]}',
//                               style:
//                                   TextStyle(fontSize: 50, color: Colors.white),
//                             ),
//                             backgroundColor: Colors.grey,
//                           ),
//                           Center(
//                             child: Text(
//                               "Change profile photo",
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           buildTextField(
//                               "FullName",
//                               firstnameediting.text = state.data2.firstName,
//                               firstnameediting),
//                           buildTextField(
//                               "Phone Number",
//                               phoneediting.text = state.data2.phone,
//                               phoneediting),
//                           buildTextField(
//                               "Flat Number",
//                               flatnumberediting.text = state.data2.flatno,
//                               flatnumberediting),
//                           SizedBox(
//                             height: 5,
//                           ),
//                         ],
//                       ));
//                 }
//                 return Container();
//               }),
//         ));
//   }
// }

// Widget buildTextField(
//   String labelText,
//   String placeholder,
//   TextEditingController controller,
// ) {
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
//     child: TextField(
//       controller: controller,
//       autocorrect: true,
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(bottom: 3),
//           labelText:labelText.isEmpty || labelText == ''? '??' :labelText,
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           // hintText: placeholder,
//           hintStyle: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           )),
//     ),
//   );
// }
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
import 'package:mygate_app/src/modules/profile_module/bloc/profile_bloc.dart';
import 'package:mygate_app/src/modules/profile_module/bloc/profile_event.dart';
import 'package:mygate_app/src/modules/profile_module/bloc/profile_state.dart';
import 'package:mygate_app/src/modules/profile_module/ui/profile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ImagePicker _picker = ImagePicker();
  ProfileBloc profileBloc = ProfileBloc();
  String firstName = "", phone = "", flatno = "";
  XFile? url;

  TextEditingController firstnameediting = TextEditingController();
  TextEditingController phoneediting = TextEditingController();
  TextEditingController flatnumberediting = TextEditingController();

  @override
  void initState() {
    super.initState();

    profileBloc.add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
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
                  if (url == null) {
                    profileBloc.add(UpdateProfile(
                        firstName: firstnameediting.text,
                        phone: phoneediting.text,
                        flatno: flatnumberediting.text));
                  } else {}
                  profileBloc.add(UpdateProfile(
                      firstName: firstnameediting.text,
                      phone: phoneediting.text,
                      flatno: flatnumberediting.text,
                      url: url));
                },
              )
            ]),
        body: BlocListener<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          listener: (context, state) {
            if (state is Updatesuccess) {
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
              bloc: profileBloc,
              builder: (context, state) {
                if (state is Load) {
                  return Center(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ProfileSucess) {
                  return Container(
                      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                      child: Column(
                        children: [
                          Container(
                            child: url != null
                                // ? CircleAvatar(
                                //     radius: 50,
                                //     child: Image.file(
                                //       File(url!.path),
                                //       width: 100,
                                //       height: 100,
                                //       fit: BoxFit.fitHeight,
                                //     ),
                                //     backgroundColor: Colors.grey,
                                //   )
                                ? SizedBox(
                                    height: 115,
                                    width: 115,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      fit: StackFit.expand,
                                      children: [
                                        CircleAvatar(
                                          child: ClipOval(
                                            child: Image.file(
                                              File(url!.path),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          backgroundColor:
                                              Colors.brown.shade200,
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            //left: -25,
                                            right: -25,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                _imgFromGallery();
                                              },
                                              elevation: 2.0,
                                              fillColor: Color.fromRGBO(
                                                  23, 195, 131, 1),
                                              child: Icon(
                                                Icons.camera_alt_rounded,
                                                color: Colors.white,
                                              ),
                                              // padding: EdgeInsets.all(15.0),
                                              shape: CircleBorder(),
                                            )),
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    height: 115,
                                    width: 115,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      fit: StackFit.expand,
                                      children: [
                                        CircleAvatar(
                                          child: Text(
                                            '${state.data2.firstName[0]}',
                                            style: TextStyle(
                                                fontSize: 50,
                                                color: Colors.white),
                                          ),
                                          backgroundColor:
                                              Colors.brown.shade200,
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: -25,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                _imgFromGallery();
                                              },
                                              elevation: 2.0,
                                              fillColor: Color.fromRGBO(
                                                  23, 195, 131, 1),
                                              child: Icon(
                                                Icons.camera_alt_rounded,
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.all(15.0),
                                              shape: CircleBorder(),
                                            )),
                                      ],
                                    ),
                                  ),
                          ),
                          buildTextField(
                              "FullName",
                              firstnameediting.text = state.data2.firstName,
                              firstnameediting),
                          buildTextField(
                              "Phone Number",
                              phoneediting.text = state.data2.phone,
                              phoneediting),
                          buildTextField(
                              "Flat Number",
                              flatnumberediting.text = state.data2.flatno,
                              flatnumberediting),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ));
                }
                return Container();
              }),
        ));
  }

  _imgFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      setState(() {
        url = pickedFile;
      });
    } catch (e) {
      throw Exception("");
    }
  }
  // Future uploadPic(BuildContext context) async{
  //     String fileName = basename(_image?.path);
  //      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
  //      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
  //      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
  //      setState(() {
  //         print("Profile Picture uploaded");
  //         Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
  //      });
  //   }

  Widget buildTextField(
    String labelText,
    String placeholder,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
      child: TextField(
        controller: controller,
        autocorrect: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
