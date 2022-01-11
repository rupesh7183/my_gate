import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygate_app/src/globals.dart';

import 'update_profile_event.dart';
import 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(ProfileInitial());

  @override
  Stream<UpdateProfileState> mapEventToState(
    UpdateProfileEvent event,
  ) async* {
    if (event is UpdateProfileInfo) {
      try {
        yield UpdateLoading();
        bool result =
            await updateProfileInfo(event.phone, event.flatno, event.type);
        if (result) {
          yield ProfileUpdateSuccess();
        } else {
          yield UpdateErrorReceived();
        }
      } catch (e) {
        yield UpdateErrorReceived();
      }
    }

    if (event is CancalUpdateProfile) {
      try {
        yield UpdateLoading();
        bool result = await cancelProfileInfo();
        if (result) {
          yield UpdateCancel();
        } else {
          yield UpdateErrorReceived();
        }
      } catch (e) {
        yield UpdateErrorReceived();
      }
    }
  }

  Future<bool> updateProfileInfo(phone, flatno, type) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(Globals.token)
          .update({'phone': phone, 'flatno': flatno, 'type': type});
      Globals.type = type;
      return true;
    } catch (e) {
      return false;
    }
  }
}

Future<bool> cancelProfileInfo() async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Globals.token)
        .delete();
    await FirebaseAuth.instance.currentUser!.delete();

    // Globals.type = type;
    return true;
  } catch (e) {
    return false;
  }
}
