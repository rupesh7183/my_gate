import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mygate_app/src/globals.dart';
import 'package:mygate_app/src/modules/post_module/bloc/information_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mygate_app/src/modules/post_module/modal/information_modal.dart';

import 'edit_information.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  _InformationPageState createState() => _InformationPageState();
}

PostBloc _postBloc = PostBloc();

class _InformationPageState extends State<InformationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // void initState() {
  //   super.initState();
  //   // _bloc.add(Notificationdispose());
  //   _postBloc.add(GetPostDetails());
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 2,
          title: Text(
            'Home',
            style: TextStyle(
                fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        // backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('PostDetails')
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
                    .map((doc) => PostInfoModel.fromSnapshot(doc))
                    .toList();

                // documents.map((doc) {
                //   data = VisitorDetailsModel.fromSnapshot(doc);
                //   print(data);
                // }).toList();
                print(data);
              } catch (e) {
                print(e);
              }
              if (data.isNotEmpty) {
                return body(data);
              } else {
                return Center(
                  child: Text('No Data found'),
                );
              }
            }
          },
        ),

        // BlocBuilder<PostBloc, PostState>(
        //     bloc: _postBloc,
        //     builder: (context, state) {
        //       if (state is PostDataSuccess) {
        //         return body(state);
        //       }
        //       return Container();
        //     }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Globals.type == 'Administrator'
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditPost()),
                  );
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              )
            : null);
  }

  Widget body(state) {
    if (state.isEmpty) {
      return Center(
        child: Text('No data found'),
      );
    } else {
      return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: state.length,
          itemBuilder: (context, int i) {
            String created1 = state[i].createdAt.toString();
            DateTime tempDate = DateTime.parse(created1);
            String datenew = convertToAgo(tempDate);

            return state == Null
                ? Center(
                    child: Text('No Data Found'),
                  )
                : Container(
                    padding: EdgeInsets.only(top: 7),
                    child: Card(
                        elevation: 4,
                        child: Column(
                          children: [
                            ListTile(
                              // tileColor: Colors.amber,
                              leading: CircleAvatar(
                                child:
                                    state[i].name == null || state[i].name == ''
                                        ? Text('0')
                                        : Text('${state[i].name[0]}'),
                              ),
                              title:
                                  state[i].name == null || state[i].name == ''
                                      ? Text('??')
                                      : Text(
                                          state[i].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                              subtitle: Text(datenew),
                              trailing: Icon(Icons.more_vert),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: state[i].url == null ||
                                              state[i].url == ''
                                          ? NetworkImage(Globals.imageUrl)
                                          : CachedNetworkImageProvider(
                                              state[i].url,
                                            ) as ImageProvider,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          state[i].title == null ||
                                                  state[i].title == ''
                                              ? Text('??')
                                              : Text(
                                                  state[i].title,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 4, bottom: 10),
                                              child: state[i].description ==
                                                          null ||
                                                      state[i].description == ''
                                                  ? Text('??')
                                                  : Text(state[i].description,
                                                      style: TextStyle(
                                                          fontSize: 14))),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )),
                  );
          });
    }
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
