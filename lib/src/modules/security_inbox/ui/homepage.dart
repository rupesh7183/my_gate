import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygate_app/src/modules/security_inbox/bloc/home_bloc.dart';
import 'package:mygate_app/src/modules/send_notification/bloc/send_notification_bloc.dart';
import 'package:mygate_app/src/modules/send_notification/bloc/send_notification_event.dart';
import 'package:mygate_app/src/modules/send_notification/modals/visitor_update.dart';
import 'package:mygate_app/src/modules/send_notification/ui/send_notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

HomeDataBloc _bloc1 = HomeDataBloc();
SendNotificationBloc _bloc = SendNotificationBloc();

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // _bloc1.add(HomeNotificationData());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Inbox',
          style: TextStyle(
              fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('VisitorDetails')
            .orderBy('createdAt', descending: true | false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data;
            try {
              // final QuerySnapshot<Object?>? documents =
              //     snapshot.data;
              data = snapshot.data!.docs
                  .map((doc) => VisitorDetailsModel.fromSnapshot(doc))
                  .toList();

              // documents.map((doc) {
              //   data = VisitorDetailsModel.fromSnapshot(doc);
              //   print(data);
              // }).toList();

              print(data);
            } catch (e) {
              Fluttertoast.showToast(msg: "Unable to fatch data");
            }

            if (data.isNotEmpty) {
              return visitorList(data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        onPressed: () {
          popup();
          _bloc.add(Notificationdispose());
        },
      ),
    );
  }

  Widget visitorList(state) {
    return ListView.builder(
        itemCount: state.length,
        itemBuilder: (context, int i) {
          String created1 =
              state[i].createdAt == null || state[i].createdAt == ''
                  ? '?? ??'
                  : state[i].createdAt.toString();

          DateTime tempDate = DateTime.parse(created1);
          String datenew = convertToAgo(tempDate);

          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Card(
                    elevation: 1,
                    child: ListTile(
                      title: state[i].name == null || state[i].name == ''
                          ? Text('??')
                          : Text(state[i].name),
                      subtitle:
                          state[i].purpose == null || state[i].purpose == ''
                              ? Text('??')
                              : Text(state[i].purpose),
                      leading: CircleAvatar(
                        child: state[i].roomNo == null || state[i].roomNo == ''
                            ? Text('??')
                            : Text(state[i].roomNo),
                      ),
                      trailing: state[i].status == null || state[i].status == ''
                          ? Text('??')
                          : Text(state[i].status),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [Text(datenew)],
                    ),
                  )
                ],
              ));
        });
  }

  popup() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopupN();
        });
  }

  getdata() async {
    var data;
    await FirebaseFirestore.instance
        .collection('VisitorDetails')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        data = querySnapshot.docs
            .map((doc) => VisitorDetailsModel.fromSnapshot(doc))
            .toList();
        // doc.data()).toList();
        print(data);
        return data;
      }
    });
  }

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second ago';
    } else {
      return 'just now';
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
