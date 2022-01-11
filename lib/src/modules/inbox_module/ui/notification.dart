import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_app/src/globals.dart';
import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
import 'package:mygate_app/src/modules/inbox_module/bloc/notification_bloc.dart';
import 'package:mygate_app/src/modules/inbox_module/bloc/notification_event.dart';
import 'package:mygate_app/src/modules/inbox_module/bloc/notification_state.dart';
import 'package:mygate_app/src/modules/send_notification/modals/visitor_update.dart';

class NotificationPage extends StatefulWidget {
  List<CameraDescription> cameras;

  NotificationPage({Key? key, required this.cameras}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

NotificationDataBloc notificationDataBloc = NotificationDataBloc();
NotificationDataBloc notificationDataBloc2 = NotificationDataBloc();

class _NotificationPageState extends State<NotificationPage>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
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
            .collection(Globals.token)
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
              print(e);
            }
            if (data.length != 0) {
              return visitorListNew(data);
            } else {
              return noDataFound();
            }
          }
        },
      ),
    );
  }

  Widget visitorListNew(state) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: state.length,
        itemBuilder: (context, int i) {
          String created1 = state[i].createdAt.toString();
          DateTime tempDate = DateTime.parse(created1);
          String datenew = convertToAgo(tempDate);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title: state[i].name == null || state[i].name == ''
                    ? Text('??')
                    : Text(
                        state[i].name,
                        style: TextStyle(fontSize: 17),
                      ),
                subtitle: Row(
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      state[i].purpose == null || state[i].purpose == ''
                          ? Text('??')
                          : Text(
                              state[i].purpose,
                              style: TextStyle(fontSize: 14),
                            ),
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                        color: Colors.grey,
                        width: 1,
                        height: 14,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        datenew,
                        style: TextStyle(fontSize: 14),
                      ),
                    ]),
                leading: CircleAvatar(
                  child: state[i].roomNo == null || state[i].roomNo == ''
                      ? Text('??')
                      : Text(state[i].roomNo),
                ),
                trailing: state[i].status == null || state[i].status == ''
                    ? Text('??')
                    : Text(
                        state[i].status,
                        style: TextStyle(
                            fontSize: 17,
                            color: state[i].status == 'Approved'
                                ? Colors.green
                                : state[i].status == 'Denied'
                                    ? Colors.red
                                    : Colors.black),
                      ),
              ),
              state[i].status == "Pending"
                  ? BlocConsumer<NotificationDataBloc, NotificationDataState>(
                      bloc: notificationDataBloc2,
                      listener: (context, state) {
                        if (state is PositiveSuccess ||
                            state is NegitiveSuccess) {
                          // Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        if (state is NotificationLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    notificationDataBloc
                                        .add(PositiveRespoance());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomePageManager()),
                                    );
                                  },
                                  child: Text("Accept")),
                              TextButton(
                                  onPressed: () {
                                    notificationDataBloc
                                        .add(NegativeRespoance());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomePageManager()),
                                    );
                                  },
                                  child: Text("Denied"))
                            ]);
                      })
                  : Container(),
              Container(
                color: Colors.grey,
                height: 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
              )
            ],
          );
        });
  }

  // Widget visitorList(state) {
  //   return ListView.builder(
  //       itemCount: state!.length ?? 0,
  //       itemBuilder: (context, int i) {
  //         String created1 = state[i].createdAt.toString();
  //         DateTime tempDate = DateTime.parse(created1);
  //         String datenew = convertToAgo(tempDate);
  //         return Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(40)),
  //           ),
  //           padding: EdgeInsets.only(left: 10, right: 10),
  //           child: Card(
  //               elevation: 5,
  //               child: Column(children: [
  //                 ListTile(
  //                   title: state[i].name == null || state[i].name == ''
  //                       ? Text('??')
  //                       : Text(state[i].name),
  //                   subtitle: state[i].purpose == null || state[i].purpose == ''
  //                       ? Text('??')
  //                       : Text(state[i].purpose),
  //                   leading: CircleAvatar(
  //                     child: state[i].roomNo == null || state[i].roomNo == ''
  //                         ? Text('??')
  //                         : Text(state[i].roomNo),
  //                   ),
  //                   trailing: state[i].status == null || state[i].status == ''
  //                       ? Text('??')
  //                       : Text(state[i].status),
  //                 ),
  //                 state[i].status == "Pending"
  //                     ? BlocConsumer<NotificationDataBloc,
  //                             NotificationDataState>(
  //                         bloc: notificationDataBloc2,
  //                         listener: (context, state) {
  //                           if (state is PositiveSuccess ||
  //                               state is NegitiveSuccess) {
  //                             // Navigator.pop(context);
  //                           }
  //                         },
  //                         builder: (context, state) {
  //                           if (state is NotificationLoading) {
  //                             return Center(
  //                               child: CircularProgressIndicator(),
  //                             );
  //                           }
  //                           return Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceEvenly,
  //                               children: [
  //                                 TextButton(
  //                                     onPressed: () {
  //                                       notificationDataBloc
  //                                           .add(PositiveRespoance());
  //                                       Navigator.push(
  //                                         context,
  //                                         MaterialPageRoute(
  //                                             builder: (context) =>
  //                                                 HomePageManager()),
  //                                       );
  //                                     },
  //                                     child: Text("Accept")),
  //                                 TextButton(
  //                                     onPressed: () {
  //                                       notificationDataBloc
  //                                           .add(NegativeRespoance());
  //                                       Navigator.push(
  //                                         context,
  //                                         MaterialPageRoute(
  //                                             builder: (context) =>
  //                                                 HomePageManager()),
  //                                       );
  //                                     },
  //                                     child: Text("Denied"))
  //                               ]);
  //                         })
  //                     : Container(),
  //                 Container(
  //                   child: Row(
  //                     children: [Text('Visited At '), Text(datenew)],
  //                   ),
  //                 )
  //               ])),
  //         );
  //       });
  // }

  Widget noDataFound() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              child: Image(
                image: AssetImage('assets/no_data.png'),
              ),
            ),
            Text('No Request yet!!')
          ],
        ),
      ),
    );
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
