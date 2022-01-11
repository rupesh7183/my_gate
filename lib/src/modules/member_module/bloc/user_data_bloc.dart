import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mygate_app/src/modules/user/userModal/signup.dart';
import 'user_data_event.dart';
import 'user_state_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataInitial());

  @override
  Stream<UserDataState> mapEventToState(
    UserDataEvent event,
  ) async* {
    //auto login bloc
    if (event is GetUserData) {
      try {
        yield Loading();
        var data = await fatchUserData();
        print(data);
        yield UserDataSuccess(data2: data);
      } catch (e) {
        yield ErrorReceived();
        throw Exception("failed");
      }
    }
  }

  Future fatchUserData() async {
    var data;
    try {
      CollectionReference _collectionRef =
          await FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot = await _collectionRef.get();
      data =
          querySnapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
      print(data);
      // await FirebaseFirestore.instance
      //     .collection("users")
      //     .snapshots()
      //     .map((event) => event.docs);
      // QuerySnapshot querySnapshot =
      // await FirebaseFirestore.instance
      //     .collection("users")
      //     .get()
      //     .then((QuerySnapshot querySnapshot) {
      //   if (querySnapshot.docs.isNotEmpty) {
      //     data = querySnapshot.docs.map((doc) => doc.data()).toList();
      //      UserModel.fromSnapshot(doc)).toList();
      //     //  doc.data()).toList();
      //     print(data);
      //     return data;
      //   }
      // });
      // final allData =

      // querySnapshot.docs.map((doc) => Video.fromSnapshot(doc)).toList();
      return data;
    } catch (e) {
      print(e);
      throw Exception("e");
    }
  }
}
