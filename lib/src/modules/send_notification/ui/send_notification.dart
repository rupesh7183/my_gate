// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
// import 'package:mygate_app/src/modules/send_notification/bloc/send_notification_bloc.dart';
// import 'package:mygate_app/src/modules/send_notification/bloc/send_notification_event.dart';
// import 'package:mygate_app/src/modules/send_notification/bloc/send_notification_state.dart';
// import 'package:mygate_app/src/modules/send_notification/list.dart';
// import 'package:mygate_app/src/modules/send_notification/modals/visitor_update.dart';
// import 'package:mygate_app/src/modules/send_notification/ui/camera.dart';

// class PopupN extends StatefulWidget {
//   XFile? imagefile;
//   PopupN({Key? key, this.imagefile}) : super(key: key);

//   @override
//   _PopupNState createState() => _PopupNState();
// }

// TextEditingController nameEditingController = TextEditingController();
// TextEditingController purposeEditingController = TextEditingController();
// SendNotificationBloc _bloc = SendNotificationBloc();
// DropDown dropDown = DropDown();
// var _selectedValue;

// class _PopupNState extends State<PopupN> {
//   @override
//   void initState() {
//     super.initState();
//     _bloc.add(Notificationdispose());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20.0))),
//       content: StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return Stack(
//             clipBehavior: Clip.none,
//             children: <Widget>[
//               Positioned(
//                 right: -40.0,
//                 top: -40.0,
//                 child: InkResponse(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: CircleAvatar(
//                     child: Icon(Icons.close),
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//               ),
//               BlocConsumer<SendNotificationBloc, SendNotificationState>(
//                   bloc: _bloc,
//                   listener: (context, state) {
//                     if (state is SendNotificartionSuccess) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => HomePageManager()));
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is LoadingN) {
//                       return Container(
//                         height: MediaQuery.of(context).size.height * 0.4,
//                         child: Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       );
//                     }
//                     if (state is SendNotificartionSuccess) {
//                       return Container(
//                         height: MediaQuery.of(context).size.height * 0.4,
//                         child: Center(
//                           child: Text("Success"),
//                         ),
//                       );
//                     }
//                     if (state is Dispose) {
//                       print(dropDown.list);
//                       return Container(
//                         height: MediaQuery.of(context).size.height,
//                         child: Form(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               DropdownButton(
//                                 menuMaxHeight:
//                                     MediaQuery.of(context).size.height * 0.4,

//                                 autofocus: true,
//                                 hint: Text('Please choose a room'),
//                                 items: state.data!
//                                     .map<DropdownMenuItem<String>>(
//                                         (String value) {
//                                   return DropdownMenuItem(
//                                     child: Text(value),
//                                     value: value,
//                                   );
//                                 }).toList(), // Not necessary for Option 1
//                                 value: _selectedValue,
//                                 onChanged: (value) {
//                                   setState(() => _selectedValue = value);
//                                 },
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                     labelText: 'Visitor Name',
//                                     suffixIcon: Icon(Icons.email),
//                                   ),
//                                   controller: nameEditingController,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: TextFormField(
//                                   controller: purposeEditingController,
//                                   decoration: InputDecoration(
//                                     labelText: 'Purpose',
//                                     suffixIcon: Icon(Icons.email),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: ElevatedButton(
//                                   child: Text("Submit"),
//                                   onPressed: () {
//                                     _bloc.add(SendNotification(
//                                         body: purposeEditingController.text,
//                                         title: nameEditingController.text,
//                                         room: _selectedValue,
//                                         url: widget.imagefile));

//                                     purposeEditingController.clear();
//                                     nameEditingController.clear();
//                                   },
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: ElevatedButton(
//                                   child: Text("Captured Image"),
//                                   onPressed: () async {
//                                     await availableCameras().then((value) =>
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     CameraPage(
//                                                       cameras: value,
//                                                     ))));
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }

//                     return Container(
//                         height: MediaQuery.of(context).size.height * 0.4,
//                         child: Center(child: CircularProgressIndicator()));
//                   })
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
import 'package:mygate_app/src/modules/send_notification/bloc/send_notification_bloc.dart';
import 'package:mygate_app/src/modules/send_notification/bloc/send_notification_event.dart';
import 'package:mygate_app/src/modules/send_notification/bloc/send_notification_state.dart';
import 'package:mygate_app/src/modules/send_notification/list.dart';
import 'package:mygate_app/src/modules/send_notification/modals/visitor_update.dart';
import 'package:mygate_app/src/modules/send_notification/ui/camera.dart';

class PopupN extends StatefulWidget {
  XFile? imagefile;
  PopupN({Key? key, this.imagefile}) : super(key: key);

  @override
  _PopupNState createState() => _PopupNState();
}

TextEditingController nameEditingController = TextEditingController();
TextEditingController purposeEditingController = TextEditingController();
SendNotificationBloc _bloc = SendNotificationBloc();
DropDown dropDown = DropDown();
var _selectedValue;
XFile? imagefile;

class _PopupNState extends State<PopupN> {
  @override
  void initState() {
    super.initState();
    _bloc.add(Notificationdispose());
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePageManager()));
                },
                icon: Icon(
                  Icons.close,
                  color: (Color.fromRGBO(23, 195, 131, 1)),
                  size: 32,
                )),
          ]),
      body: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              BlocConsumer<SendNotificationBloc, SendNotificationState>(
                  bloc: _bloc,
                  listener: (context, state) {
                    if (state is SendNotificartionSuccess) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageManager()));
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingN) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is SendNotificartionSuccess) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Center(
                          child: Text("Success"),
                        ),
                      );
                    }
                    if (state is Dispose) {
                      print(dropDown.list);
                      return Container(
                        padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                        height: MediaQuery.of(context).size.height,
                        child: Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ElevatedButton(
                                child: Text("Captured Image"),
                                onPressed: () async {
                                  await availableCameras()
                                      .then((value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CameraPage(
                                                    cameras: value,
                                                  ))));
                                },
                              ),
                              DropdownButton(
                                menuMaxHeight:
                                    MediaQuery.of(context).size.height * 0.4,

                                autofocus: true,
                                hint: Text('Please choose a room'),
                                items: state.data!
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(), // Not necessary for Option 1
                                value: _selectedValue,
                                onChanged: (value) {
                                  setState(() => _selectedValue = value);
                                },
                                isExpanded: true,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Visitor Name',
                                    suffixIcon: Icon(Icons.email),
                                  ),
                                  controller: nameEditingController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: purposeEditingController,
                                  decoration: InputDecoration(
                                    labelText: 'Purpose',
                                    suffixIcon: Icon(Icons.email),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  _bloc.add(SendNotification(
                                      body: purposeEditingController.text,
                                      title: nameEditingController.text,
                                      room: _selectedValue,
                                      url: widget.imagefile));

                                  purposeEditingController.clear();
                                  nameEditingController.clear();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Center(child: CircularProgressIndicator()));
                  })
            ],
          );
        },
      ),
    );
  }
}
