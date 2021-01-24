import 'package:Feelie/signIn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types, must_be_immutable
class mainPage extends StatefulWidget {
  num screenHeight;
  num screenWidth;

  mainPage({
    @required this.screenHeight,
    @required this.screenWidth,
  });

  @override
  _mainPageState createState() => _mainPageState();
}

// ignore: camel_case_types
class _mainPageState extends State<mainPage> with AutomaticKeepAliveClientMixin {
  var messageController = TextEditingController();
  var userName;
  var password;
  var birthDate;
  var imageWidth;
  var imageHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString('userName');
      password = sharedPreferences.getString('password');
      birthDate = sharedPreferences.getString('birthDate');
    });
  }

  setData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isSignIn', false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Feelie'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              setData();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => signIn(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: false,
            elevation: 0.0,
            title: Text('24 Hours'),
            actions: [],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildCard(),
                buildCard(),
                buildCard(),
                buildCard(),
                buildCard(),
                buildCard(),
                buildCard(),
                buildCard(),
                buildCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(widget.screenWidth * 0.02),
        child: Stack(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(widget.screenWidth * 0.04),
                  child: Image.asset('lib/assets/barbarapalvin_post.png', fit: BoxFit.fill),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(widget.screenWidth * 0.04), bottomRight: Radius.circular(widget.screenWidth * 0.04)),
                      color: (() {
                        var brightness = MediaQuery.of(context).platformBrightness;
                        bool darkModeOn = brightness == Brightness.dark;
                        if (darkModeOn == true) {
                          return Colors.black38;
                        } else {
                          return Colors.white38;
                        }
                      }())),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
                      IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
                      IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
                      IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
                      IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(widget.screenWidth * 0.04), topLeft: Radius.circular(widget.screenWidth * 0.04)),
                  color: (() {
                    var brightness = MediaQuery.of(context).platformBrightness;
                    bool darkModeOn = brightness == Brightness.dark;
                    if (darkModeOn == true) {
                      return Colors.black38;
                    } else {
                      return Colors.white38;
                    }
                  }())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(widget.screenWidth * 0.02),
                    width: widget.screenWidth * 0.08,
                    height: widget.screenWidth * 0.08,
                    decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage('lib/assets/barbarapalvin_profile.jpg'), fit: BoxFit.fill)),
                  ),
                  SizedBox(width: widget.screenWidth * 0.03),
                  Text('Barbara Palvin'),
                  Spacer(),
                  IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
