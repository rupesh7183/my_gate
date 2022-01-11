import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
import 'package:mygate_app/src/modules/post_module/bloc/information_bloc.dart';
import 'package:mygate_app/src/modules/post_module/bloc/information_event.dart';
import 'package:mygate_app/src/modules/post_module/bloc/information_state.dart';

class EditPost extends StatefulWidget {
  const EditPost({Key? key}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

PostBloc _postBloc = PostBloc();
final ImagePicker _picker = ImagePicker();
TextEditingController titleEditingController = TextEditingController();
TextEditingController descriptionEditingController = TextEditingController();
XFile? _image;

class _EditPostState extends State<EditPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              _image = null;
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            iconSize: 30,
          ),
          title: Text("Edit Post", style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              icon: Icon(Icons.done, color: Colors.black),
              iconSize: 30,
              onPressed: () {
                _postBloc.add(AddPostInfo(
                    title: titleEditingController.text,
                    description: descriptionEditingController.text,
                    image: _image));
              },
            )
          ]),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: _postBloc,
        listener: (context, state) {
          if (state is PostAddedSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageManager()),
            );
          }
        },
        builder: (context, state) {
          if (state is PostLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return postBody();
        },
      ),
    );
  }

  Widget postBody() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            File(_image!.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                controller: titleEditingController,
                autocorrect: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Enter Title',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    // hintText: placeholder,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                controller: descriptionEditingController,
                autocorrect: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Enter Description',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    // hintText: placeholder,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
          ],
        ),
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
        _image = pickedFile;
      });
    } catch (e) {
      throw Exception("");
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }
}
