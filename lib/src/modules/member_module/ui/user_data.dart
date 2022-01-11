import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygate_app/src/modules/member_module/bloc/user_data_bloc.dart';
import 'package:mygate_app/src/modules/member_module/bloc/user_data_event.dart';
import 'package:mygate_app/src/modules/member_module/bloc/user_state_state.dart';
import 'package:mygate_app/src/service/utility.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  _UserDataPageState createState() => _UserDataPageState();
}

TextEditingController titleEditingController = TextEditingController();
TextEditingController bodyEditingController = TextEditingController();
UserDataBloc _userDataBloc = UserDataBloc();

class _UserDataPageState extends State<UserDataPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // _bloc.add(Notificationdispose());
    _userDataBloc.add(GetUserData());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        title: Text(
          'Members',
          style: TextStyle(
              fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(padding: EdgeInsets.only(top: 7), child: body1()),
    );
  }

  Widget body1() {
    return BlocBuilder<UserDataBloc, UserDataState>(
        bloc: _userDataBloc,
        builder: (context, state) {
          if (state is UserDataSuccess) {
            return listWidget(state);
          } else if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }

  Widget listWidget(state) {
    if (state.data2.isEmpty) {
      return Center(
        child: Text('No data found'),
      );
    } else {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
          itemCount: state.data2.length,
          itemBuilder: (context, int i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  title: state.data2[i].firstName == "" ||
                          state.data2[i].firstName == null
                      ? Text('??')
                      : Text(
                          state.data2[i].firstName,
                          style: TextStyle(fontSize: 17),
                        ),
                  subtitle: Row(children: [
                    Icon(Icons.sensor_door, color: Colors.grey),
                    state.data2[i].flatno == "" || state.data2[i].flatno == null
                        ? Text('??')
                        : Text(state.data2[i].flatno,
                            style: TextStyle(fontSize: 14)),
                  ]),
                  leading:state.data2[i].url == '' || state.data2[i].url == null ? CircleAvatar(
                    child: state.data2[i].firstName == "" ||
                            state.data2[i].firstName == null
                        ? Text("0")
                        : Text('${state.data2[i].firstName[0]}'),
                  ) : CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                                          state.data2[i].url,
                                        ),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () {
                          if (state.data2[i].firstName == "" ||
                              state.data2[i].firstName == null) {
                            Fluttertoast.showToast(
                                msg: "Phone number is empty");
                          } else {
                            Utility.launchUrlOnExternalBrowser(
                                "tel:" + state.data2[i].phone);
                          }
                        },
                      ), // icon-1
                      // icon-2
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                )
              ],
            );
          });
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
