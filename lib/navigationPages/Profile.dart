import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart';

import "package:flutter/material.dart";
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_size_app/services/AuthService.dart';

import 'package:virtual_size_app/services/databaseServices.dart';
import 'package:virtual_size_app/models/customDialogBox.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {




  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(child:TextButton(
          onPressed: () async {
            AuthService().signOut();
          },
          child: Text("Log Out", style: TextStyle(color: Colors.black),)))
    );
  }
}
