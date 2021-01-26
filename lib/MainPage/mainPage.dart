import 'package:Feelie/signIn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';
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
        title: Text('Feelie', style: TextStyle(fontFamily: 'Pacifico', fontSize: widget.screenWidth * 0.08)),
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(widget.screenWidth * 0.02),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(widget.screenWidth * 0.04)),
              color: (() {
                var brightness = MediaQuery.of(context).platformBrightness;
                bool darkModeOn = brightness == Brightness.dark;
                if (darkModeOn == true) {
                  return Colors.grey.shade900;
                } else {
                  return Colors.grey.shade100;
                }
              }()),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(widget.screenWidth * 0.02),
                  width: widget.screenWidth * 0.08,
                  height: widget.screenWidth * 0.08,
                  decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage('assets/barbarapalvin_profile.jpg'), fit: BoxFit.fill)),
                ),
                SizedBox(width: widget.screenWidth * 0.03),
                Text('Barbara Palvin'),
                Spacer(),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
          ),
        ),
        PinchZoomImage(
          image: ClipRRect(
            borderRadius: BorderRadius.circular(widget.screenWidth * 0.04),
            child: Image.asset('assets/barbarapalvin_post.png'),
          ),
          zoomedBackgroundColor: (() {
            var brightness = MediaQuery.of(context).platformBrightness;
            bool darkModeOn = brightness == Brightness.dark;
            if (darkModeOn == true) {
              return Colors.black;
            } else {
              return Colors.white;
            }
          }()),
          hideStatusBarWhileZooming: false,
        ),
        Padding(
          padding: EdgeInsets.all(widget.screenWidth * 0.02),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(widget.screenWidth * 0.04)),
              color: (() {
                var brightness = MediaQuery.of(context).platformBrightness;
                bool darkModeOn = brightness == Brightness.dark;
                if (darkModeOn == true) {
                  return Colors.grey.shade900;
                } else {
                  return Colors.grey.shade100;
                }
              }()),
            ),
            child: SizedBox(
              width: widget.screenWidth * 0.96,
              height: widget.screenWidth * 0.12,
              child: Center(
                child: RatingBar.builder(
                  maxRating: 5,
                  onRatingUpdate: (_) {},
                  itemSize: widget.screenWidth * 0.08,
                  glow: false,
                  wrapAlignment: WrapAlignment.spaceEvenly,
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.055),
                  itemBuilder: (context, _) => Icon(
                    Icons.star_border,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: widget.screenWidth * 0.9,
          child: Divider(
            height: 0.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
