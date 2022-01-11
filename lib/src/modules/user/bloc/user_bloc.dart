import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygate_app/src/globals.dart';
import 'package:mygate_app/src/modules/user/ui/login.dart';
import 'package:mygate_app/src/modules/user/userModal/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mygate_app/src/service/shared_preference.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  LoginPage loginPage = LoginPage();
  final _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);
  final SharedPreferencesFn? _sharedPref = SharedPreferencesFn();
  UserModel userModel = UserModel();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    //auto login bloc
    if (event is InitLogin) {
      try {
        if ((Globals.linkUsername != null && Globals.linkUsername != '') &&
            (Globals.linkPassword != null && Globals.linkPassword != '')) {
          // WIll bypass the login screen if the credentials are found in the dynamic link
          bool result =
              await login(Globals.linkUsername, Globals.linkPassword, true);
          yield result ? LoginSuccess() : ErrorReceived();
        } else {
          yield ErrorReceived();
        }
      } catch (e) {
        print(e);
        yield ErrorReceived(err: e);
      }
    }
    // This event is about login
    if (event is PerfomLogin) {
      try {
        yield Loading();
        final cred = PerfomLogin(
          email: event.email,
          password: event.password,
        );
        print(cred);
        bool result = await login(cred.email, cred.password, false);
        if (result != null && result) {
          yield LoginSuccess();
        } else {
          yield InvalidCredentials();
        }
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }

    // this event is about autologin
    if (event is AutoLogin) {
      try {
        yield Loading();
        bool result = await initiateAutoLogin();
        if (result) {
          yield AutoLoginSucess();
        } else {
          yield ErrorReceived();
        }
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }

    if (event is PerfomChangePassword) {
      try {
        yield Loading();

        bool result = await changePassword(event.email);
        print(result);
        yield result ? RecoverSuccess() : ErrorReceived();
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }

    if (event is LogOut) {
      yield Loading();
      // await resetDeviceId();
      bool flag = await louout();
      print(flag);
      yield flag ? LoggedOut() : ErrorReceived();
    }

    if (event is PerfomGoogleLogin) {
      try {
        // await googleSignIn.signIn();
        yield Loading();

        String result = await _signInWithGoogle();

        if (result == '1') {
          yield GoogleLoginUpdateProfile();
        } else if (result == '2') {
          yield GoogleLogin();
        } else {
          yield ErrorReceived();
        }
      } catch (e) {
        print("Google Sign In Failed");
        yield ErrorReceived();
      }
    }
    if (event is PerformFacebookLogin) {
      try {
        yield Loading();

        String? name = await _signInWithFacebook();
        yield FacebookLogin(name: name);
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }

    if (event is Registration) {
      yield Loading();

      bool flag = await (register(event.name, event.email, event.phoneNo,
          event.password, event.flatNu, event.type));
      print(flag);
      yield flag ? RegistrationSuccess() : ErrorReceived();
    }
  }

  Future<bool> register(name, email, phoneNo, password, flateNu, type) async {
    try {
      var res = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(
                    name: name, phone: phoneNo, flatno: flateNu, type: type)
              });
      Fluttertoast.showToast(msg: "account created successfully");
      print(res);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.code);
      return false;
    }
    return true;
  }

  postDetailsToFirestore(
      {required String name,
      required String phone,
      required String flatno,
      required String type}) async {
    User? user = _auth.currentUser;

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.type = type;
    userModel.firstName = name;
    userModel.phone = phone;
    userModel.flatno = flatno;
    userModel.url = '';
    userModel.userid = Globals.currentUserid;

    // Globals.senderUid = user.uid;

    var one = await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "account created successfully");

    return true;
  }

  Future<bool> login(email, password, isOpenedByLink) async {
    print(email);
    print(password);
    var data;
    try {
      Globals.linkUsername = email;
      Globals.linkPassword = password;
      _sharedPref?.getString(
        password,
      );
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Fluttertoast.showToast(msg: "Login Succesful"),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
      User? user = _auth.currentUser;
      UserModel userModel = UserModel();
      Globals.token = user!.uid;
      // await _sharedPref?.getString(
      //   user.email.toString(),
      // );
      // await _sharedPref?.getString(
      //   user.uid.toString(),
      // );
      await _sharedPref?.setString('email', email);
      await _sharedPref?.setString('uid', user.uid);
      await _sharedPref?.setString('password', password);
      await _sharedPref?.setString('profileUrl', '');
      // await _sharedPref?.getString(id);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          data = documentSnapshot.data();
          Globals.name = data["firstName"];
          Globals.type = data['type'];
          Globals.currentUid = data['userid'];
          Globals.profileUrl = data['url'];

          return data;
          // return data as List<UserModel>;
        } else {
          print('Document does not exist on the database');
        }
      });
      await _sharedPref!.setString('token', user.uid);
      await _sharedPref!.setString('name', Globals.name);
      await _sharedPref!.setString('type', Globals.type);
      await _sharedPref?.setString('profileUrl', Globals.profileUrl);
      print(Globals.currentUserid);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'userid': Globals.currentUserid});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> _signInWithGoogle() async {
    String result = '0';
    var data;
    try {
      googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      print(googleSignInAccount);
      await _sharedPref!.setString('id', googleSignInAccount!.id);
      await _sharedPref!.setString('email', googleSignInAccount.email);
      await _sharedPref!.setString('photoUrl', googleSignInAccount.photoUrl!);
      await _sharedPref!.setString('name', googleSignInAccount.displayName!);
      // await _sharedPref?.setString('profileUrl', googleSignInAccount.photoUrl!);
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user1 = authResult.user;
      User? user = _auth.currentUser;
      Globals.token = user!.uid;
      Globals.name = user.displayName!;
      await _sharedPref!.setString('token', user.uid);

      Globals.token = await _sharedPref!.getString('token');

      if (authResult.additionalUserInfo!.isNewUser) {
        userModel.firstName = googleSignInAccount.displayName;
        userModel.email = googleSignInAccount.email;
        userModel.uid = user.uid;

        userModel.userid = Globals.currentUserid;
        userModel.flatno = '';
        userModel.phone = '';
        userModel.type = '';
        userModel.url = '';
        Globals.profileUrl = googleSignInAccount.photoUrl!;
        await _sharedPref?.setString(
            'profileUrl', googleSignInAccount.photoUrl!);

        var one = await firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toMap());
        result = '1';
        return result;
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            data = documentSnapshot.data();
            Globals.name = data["firstName"];
            Globals.type = data['type'];
            Globals.currentUid = data['userid'];
            Globals.profileUrl = data['url'];

            // return data as List<UserModel>;
          } else {
            print('Document does not exist on the database');
          }
        });
        await _sharedPref!.setString('type', Globals.type);
        await _sharedPref?.setString('profileUrl', Globals.profileUrl);
        result = '2';
        return result;
      }
    } on FirebaseAuthException catch (e) {
      (e.message);
      Fluttertoast.showToast(msg: e.code);
      return result;
    }
  }

  Future<String> _signInWithFacebook() async {
    final LoginResult loginResult =
        await FacebookAuth.instance.login(permissions: ['name']);

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final userData = await FacebookAuth.instance.getUserData();
    String userName = userData['name'];
    Globals.name = userName;
    print(userName);
    return userName;
  }

  initiateAutoLogin() async {
    try {
      final _email = await _sharedPref?.getString('email');
      final _password = await _sharedPref?.getString('password');
      final id = await _sharedPref?.getString('id');

      Globals.token = await _sharedPref!.getString('token');
      Globals.name = await _sharedPref!.getString('name');
      Globals.type = await _sharedPref!.getString('type');
      Globals.profileUrl = await _sharedPref!.getString('profileUrl');

      print('Email : $_email');
      if (Globals.token != "" || Globals.token.isNotEmpty) {
        // await _auth.signInWithCustomToken(Globals.token);
        // bool result = await login(_email, _password, false);
        return true;
      } else if (id!.isNotEmpty || _email!.isNotEmpty) {
        return false;
      } else {
        throw ('');
      }
    } catch (e) {
      throw (e);
    }
  }

  Future changePassword(email) async {
    try {
      var res = await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: "Recovery link send to your Email");
      return true;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.code.toString());
      return false;
    }
  }

  Future louout() async {
    try {
      await _auth.signOut();
      _sharedPref!.clear();

      Globals.name = "";
      Globals.linkUsername = "";
      Globals.linkPassword = "";
      Globals.token = "";
      return true;
    } catch (e) {
      // throw (e);
      return false;
    }
  }
}
