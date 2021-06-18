import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:virtual_size_app/Auth/signIn.dart";
import "package:virtual_size_app/Home.dart";
import 'package:virtual_size_app/models/user.dart';
import 'package:virtual_size_app/services/databaseServices.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  Future<MyUser> getUser(User user) async{
    DocumentSnapshot snapshot = await usersRef.doc(user.uid).get();
    MyUser myuser  = MyUser.fromDoc(snapshot);
    return myuser;
  }

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);
    //print('User: $user');

    if(user == null) {
      return SignIn();
    }
    else {

      return FutureProvider<MyUser>(
        create: (_) => getUser(user),
        child: Home(),
      );
    }
  }
}