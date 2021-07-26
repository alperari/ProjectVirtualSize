import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:virtual_size_app/services/databaseServices.dart";

class Cart extends StatelessWidget {

  final user;
  Cart({this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Viewing Cart"),
          centerTitle: true,
        ),
        body: Center(child: Text("h"),),
      ),
    );
  }
}
