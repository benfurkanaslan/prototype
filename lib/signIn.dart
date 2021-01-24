import 'dart:ui';

import 'package:Feelie/pageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUp/signUp.dart';

class signIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(behavior: MyBehavior(), child: child);
      },
      title: 'Feelie',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        backgroundColor: Colors.black,
        inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(15)), labelStyle: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey.shade900,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white38,
            elevation: 0.0,
            showSelectedLabels: true,
            showUnselectedLabels: false),
        primaryIconTheme: IconThemeData(color: Colors.white),
        outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(primary: Colors.white, onSurface: Colors.black, backgroundColor: Colors.black)),
        cardTheme: CardTheme(color: Colors.black, elevation: 2, shadowColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
        floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.white, backgroundColor: Colors.white12, elevation: 0.0, highlightElevation: 0.0),
        scaffoldBackgroundColor: Colors.grey.shade900,
        appBarTheme: AppBarTheme(elevation: 0.0, color: Colors.grey.shade900, centerTitle: true),
        primaryColor: Colors.white,
        primaryColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      theme: ThemeData(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        backgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.circular(15)), labelStyle: TextStyle(color: Colors.black)),
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black, opacity: 0.9),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey.shade100,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black38,
          elevation: 0.0,
        ),
        primaryIconTheme: IconThemeData(color: Colors.black),
        outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(primary: Colors.black, onSurface: Colors.white, backgroundColor: Colors.white)),
        cardTheme: CardTheme(color: Colors.white, elevation: 10, shadowColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
        floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.black, backgroundColor: Colors.black12, elevation: 0.0, highlightElevation: 0.0),
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: AppBarTheme(elevation: 0.0, color: Colors.grey.shade100, centerTitle: true),
        primaryColor: Colors.black,
        primaryColorBrightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    getData();
  }

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var userName;
  var password;
  var birthDate;
  bool controlled = true;
  bool isSignIn = false;
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var birthDateController = TextEditingController();
  var screenWidth;
  var screenHeight;

  Future<void> setData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userName', userName);
    sharedPreferences.setString('password', password);
    sharedPreferences.setString('birthDate', birthDate);
    sharedPreferences.setBool('isSignIn', true);
  }

  Future<void> getData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isSignIn = sharedPreferences.getBool('isSignIn');
    });
    if (isSignIn == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => pageView(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenInfo = MediaQuery.of(context);
    screenWidth = screenInfo.size.width;
    screenHeight = screenInfo.size.height;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Feelie'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box, color: Theme.of(context).primaryColor),
                          labelText: 'User Name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(screenWidth * 0.05)),
                        ),
                        validator: (value) {
                          return value.isEmpty ? '*Please Enter Your User Name' : null;
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
                          labelText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(screenWidth * 0.05)),
                        ),
                        validator: (value) {
                          return value.isEmpty ? '*Please Enter Your Password' : null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Visibility(
                child: OutlinedButton(onPressed: () {}, child: Text('Forgot Password?')),
                visible: !controlled,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          SizedBox(width: screenWidth * 0.04),
          OutlinedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => signUp(screenWidth: screenWidth, screenHeight: screenHeight)));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.account_circle),
                SizedBox(width: screenWidth * 0.02),
                Text('Sign Up'),
              ],
            ),
          ),
          Spacer(),
          OutlinedButton(
            onPressed: () {
              controlled = formKey.currentState.validate();
              if (controlled == true) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => pageView(screenHeight: screenHeight, screenWidth: screenWidth),
                  ),
                  (Route<dynamic> route) => false,
                );
              } else {
                setState(() {
                  controlled = false;
                });
              }
              userName = userNameController.text;
              password = passwordController.text;
              birthDate = birthDateController.text;
              setData();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sign In'),
                SizedBox(width: screenWidth * 0.02),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
