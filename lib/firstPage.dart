import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tapandtalk/SignUp/signUp.dart';

import 'SignIn/signIn.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tap&Talk',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        iconTheme: IconThemeData(color: Colors.white),
        outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(primary: Colors.white, onSurface: Colors.black, backgroundColor: Colors.black)),
        cardTheme: CardTheme(color: Colors.white60, elevation: 10, shadowColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
        floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.black, backgroundColor: Colors.white, elevation: 0.0, highlightElevation: 0.0),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(elevation: 0.0, color: Colors.black, centerTitle: true),
        primarySwatch: Colors.blue,
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.black),
        outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(primary: Colors.black, onSurface: Colors.white, backgroundColor: Colors.white)),
        cardTheme: CardTheme(color: Colors.black12, elevation: 10, shadowColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
        floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.white, backgroundColor: Colors.black, elevation: 0.0, highlightElevation: 0.0),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(elevation: 0.0, color: Colors.white, centerTitle: true),
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
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
  }

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var userName;
  var password;
  var birthDate;
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenInfo = MediaQuery.of(context);
    final screenWidth = screenInfo.size.width;
    final screenHeight = screenInfo.size.height;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tap&', style: TextStyle(color: Colors.blue, fontSize: screenWidth * 0.06)),
                Text('Talk', style: TextStyle(color: Colors.red, fontSize: screenWidth * 0.06)),
              ],
            ),
            Text('with someone you never knew', style: TextStyle(fontSize: screenWidth * 0.04)),
          ],
        ),
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
                      width: screenWidth * 0.9,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: TextFormField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_box),
                              labelText: 'User Name',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(screenWidth * 0.05)),
                            ),
                            validator: (value) {
                              return value.isEmpty ? '*Please Enter Your User Name' : null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(screenWidth * 0.05)),
                            ),
                            validator: (value) {
                              return value.isEmpty ? '*Please Enter Your Password' : null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          SizedBox(width: screenWidth * 0.08),
          OutlinedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => signUp(screenWidth: screenWidth, screenHeight: screenHeight)));
            },
            child: Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_circle),
                    SizedBox(width: screenWidth * 0.02),
                    Text('Sign Up'),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          OutlinedButton(
            onPressed: () {
              bool controlled = formKey.currentState.validate();
              if (controlled == true) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => signIn(screenWidth: screenWidth, screenHeight: screenHeight, userName: userName, password: password, birthDate: birthDate)));
              }
              userName = userNameController.text;
              password = passwordController.text;
              birthDate = birthDateController.text;
            },
            child: Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Sign In'),
                    SizedBox(width: screenWidth * 0.02),
                    Icon(Icons.arrow_right),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
