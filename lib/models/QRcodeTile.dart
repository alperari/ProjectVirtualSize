import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_size_app/services/databaseServices.dart';

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


  buildQR(){
    return Column(
      children: [
        Row(
          children: [
          Expanded(
            flex:9,
            child: Text(name),
          ),
          Expanded(
            flex: 1,
            child: Text(time),
          ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                width: 300,
                height: 300,
                child: Image.network(mediaURL),
              ),
            ),
            Expanded(
              flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: Icon(Icons.star_border), onPressed: (){}),
                    IconButton(icon: Icon(Icons.restore_from_trash),onPressed: (){},)
                  ],
                )
            )
          ],
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

