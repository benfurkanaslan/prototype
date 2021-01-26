import 'package:Feelie/pageView.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types, must_be_immutable
class signUp extends StatefulWidget {
  num screenHeight;
  num screenWidth;
  final CameraDescription camera;

  signUp({@required this.screenHeight, @required this.screenWidth, @required this.camera});

  @override
  _signUpState createState() => _signUpState();
}

// ignore: camel_case_types
class _signUpState extends State<signUp> {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var userNameController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordAgainController = TextEditingController();
    var birthDateController = TextEditingController();
    var userName;
    var password;
    var passwordAgain;
    var birthDate;

    Future<void> setData() async {
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('userName', userName);
      sharedPreferences.setString('password', password);
      sharedPreferences.setString('birthDate', birthDate);
      sharedPreferences.setBool('isSignIn', true);
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Feelie', style: TextStyle(fontFamily: 'Pacifico', fontSize: widget.screenWidth * 0.08)),
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
                      width: widget.screenWidth * 0.8,
                      child: TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box, color: Theme.of(context).primaryColor),
                          labelText: 'User Name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.screenWidth * 0.05)),
                        ),
                        validator: (value) {
                          return value.isEmpty ? '*Please Enter Your User Name' : null;
                        },
                      ),
                    ),
                    SizedBox(height: widget.screenHeight * 0.05),
                    SizedBox(
                      width: widget.screenWidth * 0.8,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
                          labelText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.screenWidth * 0.05)),
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          return value.isEmpty ? '*Please Enter Your Password' : null;
                        },
                      ),
                    ),
                    SizedBox(height: widget.screenHeight * 0.05),
                    SizedBox(
                      width: widget.screenWidth * 0.8,
                      child: TextFormField(
                        controller: passwordAgainController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: 'Again',
                          prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
                          labelText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.screenWidth * 0.05)),
                        ),
                        onChanged: (value) {
                          passwordAgain = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return '*Please Enter Your Password Again';
                          } else if (passwordAgain != password) {
                            return 'Enter Your Password Correctly';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: widget.screenHeight * 0.05),
                    SizedBox(
                      width: widget.screenWidth * 0.8,
                      child: TextFormField(
                        controller: birthDateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          helperText: '''Users are matched by age,
Please enter your birth date correctly.''',
                          hintText: 'mm/dd/yyyy',
                          prefixIcon: Icon(Icons.date_range, color: Theme.of(context).primaryColor),
                          labelText: 'Birth Date',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.screenWidth * 0.05)),
                        ),
                        validator: (value) {
                          return value.isEmpty ? '*Please Enter Your Birth Date' : null;
                        },
                        onTap: () {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                            initialDate: DateTime.now(),
                          ).then(
                            (value) {
                              birthDateController.text = '${value.month}/${value.day}/${value.year}';
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: OutlinedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sign Up'),
            SizedBox(width: widget.screenWidth * 0.02),
            Icon(Icons.arrow_right),
          ],
        ),
        onPressed: () {
          bool controlled = formKey.currentState.validate();
          if (controlled == true) {
            setData();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => pageView(camera: widget.camera, screenHeight: widget.screenHeight, screenWidth: widget.screenWidth),
              ),
              (Route<dynamic> route) => false,
            );

            userName = userNameController.text;
            password = passwordController.text;
            birthDate = birthDateController.text;
            setData();
          }
        },
      ),
    );
  }
}
