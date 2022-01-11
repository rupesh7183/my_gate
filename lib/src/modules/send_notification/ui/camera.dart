import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mygate_app/src/modules/send_notification/ui/cameraview.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  CameraPage({Key? key, this.cameras}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? pictureFile;
  @override
  void initState() {
    controller = CameraController(widget.cameras![0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return SizedBox(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Stack(children: [
      Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              //height: 400,
              //width: 400,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CameraPreview(controller),
            ),
          )),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 700, 0, 5),
        child: ElevatedButton(
            onPressed: () async {
              pictureFile = await controller.takePicture();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CameraViewPage(
                            path: pictureFile!,
                          )));
            },
            child: Text("captured picture")),
      ),
      if (pictureFile != null)
        // Image.network(
        //   pictureFile!.path,
        //   height: 200,
        // )
        Image.file(File(pictureFile!.path))
    ]);
  }
}
