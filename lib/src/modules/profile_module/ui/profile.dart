import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygate_app/src/globals.dart';
import 'package:mygate_app/src/modules/profile_module/bloc/profile_bloc.dart';
import 'package:mygate_app/src/modules/profile_module/bloc/profile_event.dart';
import 'package:mygate_app/src/modules/profile_module/ui/updateprofile.dart';
import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
import 'package:mygate_app/src/modules/user/ui/login.dart';
import 'package:mygate_app/src/modules/user/userModal/signup.dart';
import 'package:mygate_app/src/style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

Styles styles = Styles();
ProfileBloc profileBloc = ProfileBloc();
UserBloc _userBloc = UserBloc();

class _ProfilePageState extends State<ProfilePage> {
  XFile? url;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    profileBloc.add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    Stream<UserModel> userDocStream = FirebaseFirestore.instance
        .collection('users')
        .doc(Globals.token)
        .snapshots()
        .map((event) => UserModel.fromSnapshot(event));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: (Color.fromRGBO(23, 195, 131, 1)),
              size: 32,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
            icon: Image.asset(
              "assets/edit_ico.jpg",
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: userDocStream,
          // FirebaseFirestore.instance
          //     .collection('users').doc(Globals.token).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data;
              try {
                data = snapshot.data;

                Globals.profileUrl = data.url;

                // final QuerySnapshot<Object?>? documents =
                //     snapshot.data;

                // documents.map((doc) {
                //   data = VisitorDetailsModel.fromSnapshot(doc);
                //   print(data);
                // }).toList();
                print(data);
              } catch (e) {
                print(e);
              }
              if (data != null) {
                return mainBody(data);
              } else {
                return Center(
                  child: Text('No Data found'),
                );
              }
            }
          },
        ),

        // BlocBuilder<ProfileBloc, ProfileState>(
        //     bloc: profileBloc,
        //     builder: (context, state) {
        //       if (state is Loading) {
        //         return Center(
        //           child: Center(child: CircularProgressIndicator()),
        //         );
        //       } else if (state is ProfileSucess) {
        //         // state.data2.url;
        //         return mainBody(state);
        //       }
        //       return Container();
        //     }),
      ),
      bottomSheet: BlocConsumer<UserBloc, UserState>(
        bloc: _userBloc,
        listener: (context, state) {
          if (state is LoggedOut) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()),
                (Route<dynamic> route) => false);
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
    );
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

  Widget mainBody(state) {
    return SafeArea(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
              child: state.url == null || state.url == ""
                  ? SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            child: Text(
                              '${state.firstName[0]}',
                              style:
                                  TextStyle(fontSize: 50, color: Colors.white),
                            ),
                            backgroundColor: Colors.brown.shade200,
                          ),
                          Positioned(
                              bottom: 0,
                              right: -25,
                              child: RawMaterialButton(
                                onPressed: () {
                                  _imgFromGallery();
                                },
                                elevation: 2.0,
                                fillColor: Color.fromRGBO(23, 195, 131, 1),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(15.0),
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
                            backgroundImage: CachedNetworkImageProvider(
                              state.url,
                            ),
                            backgroundColor: Colors.brown.shade200,
                          ),
                          Positioned(
                              bottom: 0,
                              right: -25,
                              child: RawMaterialButton(
                                onPressed: () {
                                  _imgFromGallery();
                                },
                                elevation: 2.0,
                                fillColor: Color.fromRGBO(23, 195, 131, 1),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
                              )),
                        ],
                      ),
                    )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: 20)),
              Text(
                '${state.firstName}',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Member of ",
                  style: TextStyle(fontSize: 20),
                ),
                Text("La Grande Maison",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ]),
              _textWidget("Flat Number", '${state.flatno}'),
              _textWidget("Email Address", '${state.email}'),
              _textWidget("Phone Number", '${state.phone}')
            ],
          ),
        ])));
  }

  Widget _textWidget(String a, String b) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Text(
            a,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          // SizedBox(
          //   height: 5,
          // ),
          Text(
            b,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

Widget _widbuttton() {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
    child: SizedBox(
        width: 343,
        height: 52,
        child: ElevatedButton(
            child: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            style: styles.button(),
            onPressed: () {
              _userBloc.add(LogOut());
            })),
  );
}
