import 'package:Agriculture/helperfunction.dart';
import 'package:Agriculture/signin.dart';
import 'package:Agriculture/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  AuthenticateState createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  Widget build(BuildContext context) {
    if (showSignIn) {
      return Signin(toggleView);
    } else {
      return Signup(toggleView);
    }
  }
}
