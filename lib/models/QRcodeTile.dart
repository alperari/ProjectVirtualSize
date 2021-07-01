import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRcodeTile extends StatefulWidget {

  final String name;
  final String QR_id;
  final String ownerID;
  final String mediaURL;
  final String time;

  //Constuctor
  QRcodeTile({
    this.name,
    this.QR_id,
    this.ownerID,
    this.mediaURL,
    this.time
  });

  factory QRcodeTile.fromDoc(DocumentSnapshot doc){
    return QRcodeTile(
      name: doc.get("name"),
      QR_id: doc.get("QR_id"),
      ownerID: doc.get("ownerID"),
      mediaURL: doc.get("mediaURL"),
      time: doc.get("time"),
    );
  }
  @override
  _QRcodeTileState createState() => _QRcodeTileState(
    name: this.name,
    QR_id: this.QR_id,
    ownerID: this.ownerID,
    mediaURL: this.mediaURL,
    time: this.time
  );
}

class _QRcodeTileState extends State<QRcodeTile> {

  final String name;
  final String QR_id;
  final String ownerID;
  final String mediaURL;
  final time;

  //Constuctor
  _QRcodeTileState({
    this.name,
    this.QR_id,
    this.ownerID,
    this.mediaURL,
    this.time
  });


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

