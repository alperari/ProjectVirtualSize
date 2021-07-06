import "package:flutter/material.dart";
import 'package:virtual_size_app/services/databaseServices.dart';
import 'package:virtual_size_app/models/QRcodeTile.dart';

class displayQRs extends StatefulWidget {
  @override
  _displayQRsState createState() => _displayQRsState();
}

class _displayQRsState extends State<displayQRs> {



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: QRsRef.doc(auth.uid).collection("my_QRs").snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightGreen),));
        }
        if(snapshot.connectionState == ConnectionState.done){
        }

        return ListView(
            children: snapshot.data.docs.map<Widget>((doc){
              return ReturnQRcodeTileWidget(QRcodeTile.fromDoc(doc), context);
            }).toList()
        );

      },
    );
  }
}
