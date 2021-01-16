import 'package:flutter/material.dart';
import 'package:tapandtalk/SignIn/signIn.dart';

// ignore: camel_case_types, must_be_immutable
class signUp extends StatefulWidget {
  num screenHeight;
  num screenWidth;

  signUp({@required this.screenHeight, @required this.screenWidth});

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

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Tap&', style: TextStyle(color: Colors.blue, fontSize: widget.screenWidth * 0.06)),
                Text('Talk', style: TextStyle(color: Colors.red, fontSize: widget.screenWidth * 0.06)),
              ],
            ),
            Text('with someone you never knew', style: TextStyle(fontSize: widget.screenWidth * 0.04)),
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
                      width: widget.screenWidth * 0.9,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(widget.screenWidth * 0.04),
                          child: TextFormField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_box),
                              labelText: 'User Name',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.screenWidth * 0.05)),
                            ),
                            validator: (value) {
                              return value.isEmpty ? '*Please Enter Your User Name' : null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: widget.screenWidth * 0.9,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(widget.screenWidth * 0.04),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
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
                      ),
                    ),
                    SizedBox(
                      width: widget.screenWidth * 0.9,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(widget.screenWidth * 0.04),
                          child: TextFormField(
                            controller: passwordAgainController,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Again',
                              prefixIcon: Icon(Icons.lock),
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
                      ),
                    ),
                    SizedBox(
                      width: widget.screenWidth * 0.9,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(widget.screenWidth * 0.04),
                          child: TextFormField(
                            controller: birthDateController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              helperText: '''Users are matched by age,
Please enter your birth date correctly.''',
                              hintText: 'mm/dd/yyyy',
                              prefixIcon: Icon(Icons.date_range),
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          signIn(screenWidth: widget.screenWidth, screenHeight: widget.screenHeight, userName: userName, password: password, birthDate: birthDate)));
              userName = userNameController.text;
              password = passwordController.text;
              birthDate = birthDateController.text;
            }
          }),
    );
  }
}
