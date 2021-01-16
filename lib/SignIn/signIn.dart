import 'package:flutter/material.dart';

// ignore: camel_case_types, must_be_immutable
class signIn extends StatefulWidget {
  String userName;
  String password;
  String birthDate;
  num screenHeight;
  num screenWidth;

  signIn({
    @required this.userName,
    @required this.password,
    @required this.birthDate,
    @required this.screenHeight,
    @required this.screenWidth,
  });

  @override
  _signInState createState() => _signInState();
}

// ignore: camel_case_types
class _signInState extends State<signIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {},
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tap&', style: TextStyle(color: Colors.blue, fontSize: widget.screenWidth * 0.06)),
                    Text('Talk', style: TextStyle(color: Colors.red, fontSize: widget.screenWidth * 0.06)),
                  ],
                ),
                Text('with someone you never knew', style: TextStyle(fontSize: widget.screenWidth * 0.04)),
              ],
            ),
          ],
        ),
      ),
      drawer: Container(width: widget.screenWidth * 0.75, color: Colors.white),
      drawerScrimColor: Colors.black54,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: widget.screenHeight * 0.25,
                  width: widget.screenWidth * 0.4,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(widget.screenWidth * 0.03),
                      child: Column(
                        children: [
                          Image.asset('lib/assets/selena-gomez.png', width: widget.screenWidth * 0.3),
                          Text('Selena Gomez'),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: widget.screenHeight * 0.25,
                  width: widget.screenWidth * 0.6,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(widget.screenWidth * 0.03),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Year : 30'),
                            Text('State : California'),
                            Text('City : San Fransisco'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: widget.screenHeight * 0.6,
              child: Card(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Action Box'), TextField()],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
