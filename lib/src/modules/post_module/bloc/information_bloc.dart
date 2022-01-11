import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygate_app/src/globals.dart';
import 'package:mygate_app/src/modules/post_module/modal/information_modal.dart';

import 'information_event.dart';
import 'information_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  PostInfoModel postInfoModel = PostInfoModel();
  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is AddPostInfo) {
      try {
        yield PostLoading();

        bool result =
            await addPostInfo(event.title, event.description, event.image);

        yield PostAddedSuccess();
      } catch (e) {
        yield PostErrorReceived();
      }
    }

    if (event is GetPostDetails) {
      try {
        yield PostLoading();
        List<PostInfoModel> result = await getPostData();
        yield PostDataSuccess(result);
      } catch (e) {
        throw Exception("Something went wrong");
      }
    }
  }

  Future getPostData() async {
    try {
      Query<Map<String, dynamic>> _collectionRef = await FirebaseFirestore
          .instance
          .collection('PostDetails')
          .orderBy('createdAt', descending: true | false);
      QuerySnapshot querySnapshot = await _collectionRef.get();
      List<PostInfoModel> data = querySnapshot.docs
          .map((doc) => PostInfoModel.fromSnapshot(doc))
          .toList();
      return data;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  Future<bool> addPostInfo(title, des, image) async {
    try {
      String? imageUrl;
      Reference reference =
          FirebaseStorage.instance.ref().child("PostImages").child(title);
      File file = File(image.path);
      UploadTask uploadTask = reference.putFile(file);

      uploadTask.whenComplete(() async {
        try {
          imageUrl = await reference.getDownloadURL();
          if (imageUrl!.isNotEmpty) {
            postInfoModel.title = title;
            postInfoModel.description = des;
            postInfoModel.url = imageUrl;
            postInfoModel.name = Globals.name;
            Timestamp stamp = Timestamp.now();

            postInfoModel.createdAt = stamp.toDate().toString();
            var one = await firebaseFirestore
                .collection('PostDetails')
                .doc()
                .set(postInfoModel.toMap());

            Fluttertoast.showToast(msg: "post done");
          }
        } catch (onError) {
          print("Error");
        }

        print(imageUrl);
      });

      Fluttertoast.showToast(msg: "post done");

      return true;
    } catch (e) {
      throw Exception("");
    }
  }
}
