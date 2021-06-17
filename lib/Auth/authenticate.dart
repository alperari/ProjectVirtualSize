import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:virtual_size_app/Auth/signIn.dart";

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print('User: $user');

    if(user == null) {
      return SignIn();
    }
    else {
      return Container();//Home();
    }
  }
}