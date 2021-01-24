import 'package:flutter/material.dart';

class camera extends StatefulWidget {
  num screenHeight;
  num screenWidth;

  camera({
    @required this.screenHeight,
    @required this.screenWidth,
  });

  @override
  _cameraState createState() => _cameraState();
}

class _cameraState extends State<camera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            forceElevated: false,
            elevation: 0.0,
            pinned: false,
            floating: true,
            title: Text('Camera'),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[],
            ),
          ),
        ],
      ),
    );
  }
}
