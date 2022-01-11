
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mygate_app/src/globals.dart';
// import 'package:mygate_app/src/modules/profile_module/bloc/profile_state.dart';

// import 'package:mygate_app/src/modules/user/userModal/signup.dart';

// import 'profile_event.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   ProfileBloc() : super(ProfileInitial());
//   UserModel userModel = UserModel();
//   @override
//   Stream<ProfileState> mapEventToState(
//     ProfileEvent event,
//   ) async* {
//     //auto login bloc
//     if (event is GetProfile) {
//       try {
//         yield Load();
//         var data1 = await fatchProfile();
//         print(data1);
//         yield ProfileSucess(data2: data1);
//       } catch (e) {
//         throw Exception("failed");
//       }
//     } else if (event is UpdateProfile) {
//       try {
//         yield Load();

//         // bool data1 = await UpdateProfileData(
//         //     event.firstName, event.phone, event.flatno, event.image);
//         bool data1 = await UpdateProfileData(
//             event.firstName, event.phone, event.flatno, event.url);
//         print(data1);
//         yield data1 ? updatesuccess(data2: data1) : ErrorReceived();
//       } catch (e) {
//         throw Exception("failed");
//       }
//     } else if (event is AddData) {
//       try {
//         yield Load();

//         // bool data1 = await UpdateProfileData(
//         //     event.firstName, event.phone, event.flatno, event.image);
//         bool data1 = await AddProfileData(event.url);
//         print(data1);
//         yield data1 ? updatesuccess(data2: data1) : ErrorReceived();
//       } catch (e) {
//         throw Exception("failed");
//       }
//     }
//   }
// }

// Future fatchProfile() async {
//   var data;
//   try {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(Globals.token)
//         .get()
//         .then((DocumentSnapshot documentSnapshot) {
//       if (documentSnapshot.exists) {
//         data = UserModel.fromSnapshot(documentSnapshot);
//         print(data);
//         // data = documentSnapshot.data();

//         return data;

//         // return data as List<UserModel>;
//       } else {
//         print('Document does not exist on the database');
//       }
//     });
//     return data;
//   } catch (e) {
//     print(e);
//     throw Exception("e");
//   }
// }

// Future<bool> AddProfileData(url) async {
//   bool data;
//   try {
//     String? imageUrl;

//     Reference reference =
//         FirebaseStorage.instance.ref().child("image").child(Globals.token);
//     File file = File(url.path);
//     UploadTask uploadTask = reference.putFile(file);
//     imageUrl = await reference.getDownloadURL();
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(Globals.token)
//         .set({
//       'url': imageUrl,
//     });
//     Fluttertoast.showToast(
//       msg: "ADD successful",
//     );
//   } catch (e) {
//     print(e);
//     return false;
//   }
//   return true;
// }

// Future<bool> UpdateProfileData(firstName, phone, flatno, url) async {
//   bool data;
//   try {
//     String? imageUrl;

//     Reference reference =
//         FirebaseStorage.instance.ref().child("image").child(Globals.token);
//     File file = File(url.path);
//     UploadTask uploadTask = reference.putFile(file);
//     imageUrl = await reference.getDownloadURL();
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(Globals.token)
//         .update({
//       'firstName': firstName,
//       'phone': phone,
//       'flatno': flatno,
//       'url': imageUrl,
//     });
//     Fluttertoast.showToast(
//       msg: "Update successful",
//     );
//   } catch (e) {
//     print(e);
//     return false;
//   }
//   return true;
// }
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygate_app/src/globals.dart';
import 'package:mygate_app/src/modules/profile_module/bloc/profile_state.dart';

import 'package:mygate_app/src/modules/user/userModal/signup.dart';

import 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());
  UserModel userModel = UserModel();
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    //auto login bloc
    if (event is GetProfile) {
      try {
        yield Load();
        var data1 = await fatchProfile();
        print(data1);
        yield ProfileSucess(data2: data1);
      } catch (e) {
        throw Exception("failed");
      }
    } else if (event is UpdateProfile) {
      try {
        yield Load();

        // bool data1 = await UpdateProfileData(
        //     event.firstName, event.phone, event.flatno, event.image);
        bool result;
        if (event.url == null) {
          result =
              await updateProfile(event.firstName, event.phone, event.flatno);
        } else {
          result = await updateProfileWithUrl(
              event.firstName, event.phone, event.flatno, event.url);
        }

        print(result);
        yield result ? Updatesuccess() : ErrorReceived();
      } catch (e) {
        throw Exception("failed");
      }
    }
    //  else if (event is AddData) {
    //   try {
    //     yield Load();

    //     // bool data1 = await UpdateProfileData(
    //     //     event.firstName, event.phone, event.flatno, event.image);
    //     // bool data1 = await AddProfileData(event.url);
    //     print(data1);
    //     yield data1 ? updatesuccess(data2: data1) : ErrorReceived();
    //   } catch (e) {
    //     throw Exception("failed");
    //   }
    // }
  }
}

Future fatchProfile() async {
  var data;
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Globals.token)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        data = UserModel.fromSnapshot(documentSnapshot);
        print(data);
        // data = documentSnapshot.data();

        return data;

        // return data as List<UserModel>;
      } else {
        print('Document does not exist on the database');
      }
    });

    return data;
  } catch (e) {
    print(e);
    throw Exception("e");
  }
}

Future<bool> updateProfile(firstName, phone, flatno) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Globals.token)
        .update({
      'firstName': firstName,
      'phone': phone,
      'flatno': flatno,
    });
    Fluttertoast.showToast(
      msg: "Update successful",
    );
    Globals.name = firstName;
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateProfileWithUrl(firstName, phone, flatno, url) async {
  bool data;
  try {
    String? imageUrl;

    Reference reference =
        FirebaseStorage.instance.ref().child("image").child(Globals.token);
    File file = File(url.path);
    UploadTask uploadTask = reference.putFile(file);
    imageUrl = await reference.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Globals.token)
        .update({
      'firstName': firstName,
      'phone': phone,
      'flatno': flatno,
      'url': imageUrl,
    });

    Fluttertoast.showToast(
      msg: "Update successful",
    );
    Globals.name = firstName;
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
