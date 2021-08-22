import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:timeago/timeago.dart" as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:virtual_size_app/custom_icon_icons.dart';
import 'package:virtual_size_app/main.dart';
import 'package:virtual_size_app/models/customDialogBox.dart';

import 'package:virtual_size_app/services/databaseServices.dart';
import 'package:virtual_size_app/showQR.dart';
import 'package:google_fonts/google_fonts.dart';


class QRcodeTile{
  GlobalKey key;

  final String name;
  final String QR_id;
  final String ownerID;
  final String mediaURL;
  final Timestamp time;

  //Constuctor
  QRcodeTile({
    this.key,
    this.name,
    this.QR_id,
    this.ownerID,
    this.mediaURL,
    this.time
  });

  factory QRcodeTile.fromDoc(DocumentSnapshot doc, GlobalKey key){
    return QRcodeTile(
      key: key,
      name: doc.get("name"),
      QR_id: doc.get("QR_id"),
      ownerID: doc.get("ownerID"),
      mediaURL: doc.get("mediaURL"),
      time: doc.get("time"),
    );
  }


}

Widget ReturnQRcodeTileWidget(QRcodeTile myQRcodeTile, BuildContext context){

  Future<void> removeQR()async{
    DocumentSnapshot snapshot = await QRsRef.doc(auth.uid).collection("my_QRs").doc(myQRcodeTile.QR_id).get();

    //remove from db
    if(snapshot.exists){
      snapshot.reference.delete();
    }

    //remove from storage
    await storageRef.child("QRs/qr_${myQRcodeTile.QR_id}.jpg").delete();
  }


  RemoveDialog(BuildContext mainContext) {
    return showDialog(
        context: mainContext,
        builder: (dialogContext) {
          print("You will remove " + myQRcodeTile.QR_id + "    " + myQRcodeTile.name);
          return SimpleDialog(
            title: Text("Do you want to remove QR?", style: GoogleFonts.ptSans(fontSize: 22),),
            children: <Widget>[

              SimpleDialogOption(
                onPressed: () async{
                  Navigator.pop(mainContext);
                  showDialog(context: context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext){
                        return CustomDialogBox(
                          title: "REMOVING QR CODE...",
                          descriptions: "This process will end in seconds.",
                        );
                      }
                  );
                  await removeQR();
                  Navigator.pop(mainContext);
                },
                child: Text(
                  'Remove',
                  style: GoogleFonts.ptSans(color: Colors.deepPurpleAccent,fontSize: 20),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.ptSans(color:Colors.grey[700], fontSize: 20),
                ),
              )
            ],
          );
        });
  }




  Future<Map<String,int>> getIconColors()async{
    // 35-48 neck
    // 80-180 shoulder
    // 60-180 chest
    // 20-55 biceps
    // 45-100 Tlength
    // 50-200 waist
    Map<String,int> icons = {"Hat": 0, "Tshirt": 0 , "Pants": 0, "Necklace": 0};
    DocumentSnapshot snapshot = await QRsRef.doc(auth.uid).collection("my_QRs").doc(myQRcodeTile.QR_id).get();


    var neck = snapshot.get("measureData")["neck"]??0;
    var shoulder = snapshot.get("measureData")["shoulder"] ?? 0;
    var chest = snapshot.get("measureData")["chest"] ?? 0;
    var biceps = snapshot.get("measureData")["biceps"] ?? 0;
    var Tlength = snapshot.get("measureData")["length"] ?? 0;
    var waist = snapshot.get("measureData")["waist"] ?? 0;
    var hip = snapshot.get("measureData")["hip"] ?? 0;
    var inLeg = snapshot.get("measureData")["inLeg"] ?? 0;
    var outLeg = snapshot.get("measureData")["outLeg"] ?? 0;


    //For tshirt
    if(    (30<=neck && neck<=87) &&
        (21<=shoulder && shoulder<=72) &&
        (55<=chest && chest<=155) &&
        (12<=biceps && biceps<=63) &&
        (45<=Tlength && Tlength<=110) &&
        (55<=waist && waist<=161)) {
      icons["Tshirt"] = 1;
    }
    ///TODO continue adding 4 icon constraints
    return icons;
  }


  buildIcons(){
    return FutureBuilder(
      future: getIconColors(),
      builder: ( context,  snapshot){
        if(snapshot.hasData) {
          Map<String, int> iconColors = snapshot.data;
          return Column(
            children: [
              SizedBox(height: 15,),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(CustomIcon.hat, color: iconColors["Hat"] == 1
                    ? Colors.deepPurple[500]
                    : Colors.grey[800]),
              ),
              SizedBox(height: 15,),

              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(CustomIcon.t_shirt_1, color: iconColors["Tshirt"] == 1
                    ? Colors.deepPurple[500]
                    : Colors.grey[800]),
              ),
              SizedBox(height: 15,),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child:  Icon(CustomIcon.black__1_, color: iconColors["Pants"] == 1
                    ? Colors.deepPurple[500]
                    : Colors.grey[800]),
              ),
              SizedBox(height: 15,),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child:Icon(CustomIcon.necklace, color: iconColors["Necklace"] == 1
                    ? Colors.deepPurple[500]
                    : Colors.grey[800],
                  size: 20,)
              ),
              SizedBox(height: 15,),



            ],
          );
        }
        else{
          return  Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightGreen,),)
          );
        }
      },
    );
  }

  buildUpper(){
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 18,),
            Container(
              width: 180,
              child: Text(
                myQRcodeTile.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Text("Created " + timeago.format(myQRcodeTile.time.toDate()), style: TextStyle(fontSize:15 ,color: Colors.grey[600], fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: 180,
                height: 180,
                child: Image(image: CachedNetworkImageProvider(myQRcodeTile.mediaURL)),

              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return showQR(mediaURL: myQRcodeTile.mediaURL,);
                    }
                ));
              },
            ),
          ],
        ),

      ],
    );
  }

  return Column(
    children: [

      Stack(
        overflow: Overflow.clip,
        children: [

          Container(
            margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 30),
            height: 280,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                buildUpper(),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 30,
            child: Container(
              width: 250,
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Colors.grey,),
                      key: myQRcodeTile.key,
                      itemBuilder: (_) => <PopupMenuItem<String>>[
                        new PopupMenuItem<String>(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildIcons(),
                                  ],
                                ),
                              ],
                            ),
                        ),

                      ],
                      onSelected: (_) {}
                      ),

                  // Material(
                  //     borderRadius: BorderRadius.circular(100),
                  //     color: Colors.white,
                  //     child: InkWell(
                  //       borderRadius: BorderRadius.circular(100),
                  //       radius: 25,
                  //       onTap: (){
                  //
                  //
                  //       },
                  //       splashColor: Colors.grey.withOpacity(.5),
                  //       child: Container(
                  //         padding: EdgeInsets.all(8),
                  //         child: Icon(
                  //           Icons.more_vert,
                  //           color: Colors.grey,
                  //           size: 25,
                  //         ),
                  //       ),
                  //     )
                  // ),

                  Material(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        radius: 25,
                        onTap: ()async{
                          return RemoveDialog(context);

                        },
                        splashColor: Colors.grey.withOpacity(.5),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.clear,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ),
                      )
                  ),

                ],
              ),
            ),
          ),
        ]
      )
    ],
  );
}
