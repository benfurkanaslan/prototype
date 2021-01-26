import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class cameraPage extends StatefulWidget {
  num screenHeight;
  num screenWidth;
  final CameraDescription camera;

  cameraPage({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.camera,
  });

  @override
  _cameraPageState createState() => _cameraPageState();
}

class _cameraPageState extends State<cameraPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  void showInSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<XFile> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (controller.value.isTakingPicture) {
      return null;
    }

    XFile file = await controller.takePicture();
    return file;
  }

  CameraController controller;
  Future<void> _initializeControllerFuture;
  void initState() {
    super.initState();
    controller = CameraController(
      widget.camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    _initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    XFile xFile;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(controller);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            xFile = await controller.takePicture();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: xFile.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: PinchZoom(
        image: Image.file(File(imagePath)),
        maxScale: 3,
        resetDuration: Duration(seconds: 3),
        zoomedBackgroundColor: (() {
          var brightness = MediaQuery.of(context).platformBrightness;
          bool darkModeOn = brightness == Brightness.dark;
          if (darkModeOn == true) {
            return Colors.black;
          } else {
            return Colors.white;
          }
        }()),
      ),
    );
  }
}
