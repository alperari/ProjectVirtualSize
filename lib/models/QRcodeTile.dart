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


class QRcodeTile{
  final String name;
  final String QR_id;
  final String ownerID;
  final String mediaURL;
  final Timestamp time;

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


  ShowOptions(BuildContext mainContext) {
    return showDialog(
        context: mainContext,
        builder: (dialogContext) {
          print("You will remove " + myQRcodeTile.QR_id + "    " + myQRcodeTile.name);
          return SimpleDialog(
            title: Text("Do you want to remove QR?", style: TextStyle(fontSize: 20),),
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
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text('Cancel'),
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


  Future<bool> isFavorited()async{
    DocumentSnapshot snapshot = await QRsRef.doc(auth.uid).collection("my_QRs").doc(myQRcodeTile.QR_id).get();
    if(snapshot.exists){
      return snapshot.get("favorited");
    }
    return false;
  }

  Future<void> Favorite()async{
    DocumentSnapshot snapshot = await QRsRef.doc(auth.uid).collection("my_QRs").doc(myQRcodeTile.QR_id).get();
    if(snapshot.exists){
      if(snapshot.get("favorited") == true){
        await snapshot.reference.update({"favorited":false});
      }
      else{
        await snapshot.reference.update({"favorited":true});
      }
    }
  }

  buildIcons(){
    return FutureBuilder(
      future: getIconColors(),
      builder: ( context,  snapshot){
        if(snapshot.hasData){
          Map<String, int> iconColors = snapshot.data;
          return Container(

              padding: EdgeInsets.symmetric(horizontal: 100,vertical: 0),
              child: Container(
                //color: Colors.grey[500],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Icon(CustomIcon.hat, color: iconColors["Hat"] == 1 ? Colors.lightGreenAccent : Colors.redAccent,),
                    Icon(CustomIcon.t_shirt_1 , color: iconColors["Tshirt"] == 1 ? Colors.lightGreenAccent : Colors.redAccent,),
                    Icon(CustomIcon.black__1_ , color: iconColors["Pants"] == 1 ? Colors.lightGreenAccent : Colors.redAccent,),
                    Icon(CustomIcon.necklace,  color: iconColors["Necklace"] == 1 ? Colors.lightGreenAccent : Colors.redAccent, size: 20,)
                  ],
                ),
              )
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
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            SizedBox(height: 10,),
            Text(
              myQRcodeTile.name,
              style: TextStyle(
                  fontSize: 25
              ),
            ),

            Text("Created " + timeago.format(myQRcodeTile.time.toDate()), style: TextStyle(color: Colors.greenAccent),),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Stack(
              overflow: Overflow.visible,
              children: [

                Container(
                  width: 300,
                  height: 150,
                ),

                Positioned(
                  top: 0,
                  right: 75,

                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white)
                      ),
                        width: 150,
                        height: 150,
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
                ),



                Positioned(
                  top: 20,
                  right: 20,

                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FutureBuilder(
                            future: isFavorited(),
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              if(snapshot.hasData){
                                bool favorited = snapshot.data;
                                return IconButton(
                                    icon: favorited == true ? Icon(Icons.star, color: Colors.yellow,) : Icon(Icons.star_border),
                                    onPressed: ()async{
                                      await Favorite();

                                    });
                              }
                              else{
                                return  Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightGreen,),)
                                );
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,color: Colors.redAccent),
                            onPressed: (){
                              return ShowOptions(context);
                            },
                          )
                        ],

                      )
                  ),
                )
              ],
            )
          ],
        ),

      ],
    );
  }



  return Column(
    children: [
      buildUpper(),
      SizedBox(height:10),
      buildIcons(),
      SizedBox(height: 10,),
      Divider(thickness: 1,)
    ],
  );
}
//
// class QRcodeTilexxx extends StatefulWidget {
//
//   final String name;
//   final String QR_id;
//   final String ownerID;
//   final String mediaURL;
//   final Timestamp time;
//
//   //Constuctor
//   QRcodeTilexxx({
//     this.name,
//     this.QR_id,
//     this.ownerID,
//     this.mediaURL,
//     this.time
//   });
//
//   factory QRcodeTilexxx.fromDoc(DocumentSnapshot doc){
//     return QRcodeTilexxx(
//       name: doc.get("name"),
//       QR_id: doc.get("QR_id"),
//       ownerID: doc.get("ownerID"),
//       mediaURL: doc.get("mediaURL"),
//       time: doc.get("time"),
//     );
//   }
//   @override
//   _QRcodeTilexxxState createState() => _QRcodeTilexxxState(
//     name: this.name,
//     QR_id: this.QR_id,
//     ownerID: this.ownerID,
//     mediaURL: this.mediaURL,
//     time: this.time
//   );
// }
//
// class _QRcodeTilexxxState extends State<QRcodeTilexxx> {
//
//   final String name;
//   final String QR_id;
//   final String ownerID;
//   final String mediaURL;
//   final Timestamp time;
//
//   //Constuctor
//   _QRcodeTilexxxState({
//     this.name,
//     this.QR_id,
//     this.ownerID,
//     this.mediaURL,
//     this.time
//   });
//
//
//   ShowOptions(BuildContext mainContext) {
//     return showDialog(
//         context: mainContext,
//         builder: (dialogContext) {
//           print("You will remove " + this.QR_id + "    " + this.name);
//           return SimpleDialog(
//             title: Text("Do you want to remove QR?", style: TextStyle(fontSize: 20),),
//             children: <Widget>[
//
//               SimpleDialogOption(
//                 onPressed: () async{
//                   await removeQR();
//                   Navigator.pop(mainContext);
//
//                 },
//                 child: Text(
//                   'Remove',
//                   style: TextStyle(color: Colors.redAccent),
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () => Navigator.pop(dialogContext),
//                 child: Text('Cancel'),
//               )
//             ],
//           );
//         });
//   }
//
//
//   Future<void> removeQR()async{
//     DocumentSnapshot snapshot = await QRsRef.doc(auth.uid).collection("my_QRs").doc(QR_id).get();
//
//     //remove from db
//     if(snapshot.exists){
//       snapshot.reference.delete();
//     }
//
//     //remove from storage
//     await storageRef.child("QRs/qr_$QR_id.jpg").delete();
//   }
//
//
//   Future<Map<String,int>> getIconColors()async{
//     // 35-48 neck
//     // 80-180 shoulder
//     // 60-180 chest
//     // 20-55 biceps
//     // 45-100 Tlength
//     // 50-200 waist
//     Map<String,int> icons = {"Hat": 0, "Tshirt": 0 , "Pants": 0, "Necklace": 0};
//     DocumentSnapshot snapshot = await QRsRef.doc(auth.uid).collection("my_QRs").doc(QR_id).get();
//
//
//     var neck = snapshot.get("measureData")["neck"];
//     var head = snapshot.get("measureData")["head"] ?? 0;
//     var shoulder = snapshot.get("measureData")["shoulder"] ?? 0;
//     var chest = snapshot.get("measureData")["chest"] ?? 0;
//     var biceps = snapshot.get("measureData")["biceps"] ?? 0;
//     var Tlength = snapshot.get("measureData")["Tlength"] ?? 0;
//     var waist = snapshot.get("measureData")["waist"] ?? 0;
//     var hip = snapshot.get("measureData")["hip"] ?? 0;
//     var inLeg = snapshot.get("measureData")["inLeg"] ?? 0;
//     var outLeg = snapshot.get("measureData")["outLeg"] ?? 0;
//
//
//     //For tshirt
//     if(    (35<=neck && neck<=48) &&
//         (80<=shoulder && shoulder<=180) &&
//         (60<=chest && chest<=180) &&
//         (20<=biceps && biceps<=55) &&
//         (45<=Tlength && Tlength<=100) &&
//         (50<=waist && waist<=200)) {
//       icons["Tshirt"] = 1;
//     }
//     ///TODO continue adding 4 icon constraints
//     return icons;
//   }
//
//   Future<bool> isFavorited()async{
//     DocumentSnapshot snapshot = await QRsRef.doc(auth.uid).collection("my_QRs").doc(QR_id).get();
//     if(snapshot.exists){
//       return snapshot.get("favorited");
//     }
//     return false;
//   }
//
//   Future<void> Favorite()async{
//     DocumentSnapshot snapshot = await QRsRef.doc(auth.uid).collection("my_QRs").doc(QR_id).get();
//     if(snapshot.exists){
//       if(snapshot.get("favorited") == true){
//         await snapshot.reference.update({"favorited":false});
//       }
//       else{
//         await snapshot.reference.update({"favorited":true});
//       }
//     }
//   }
//
//   buildIcons(){
//     return FutureBuilder(
//       future: getIconColors(),
//       builder: ( context,  snapshot){
//         if(snapshot.hasData){
//           Map<String, int> iconColors = snapshot.data;
//           return Container(
//
//               padding: EdgeInsets.symmetric(horizontal: 100,vertical: 0),
//               child: Container(
//                 //color: Colors.grey[500],
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//
//                     Icon(CustomIcon.hat, color: iconColors["Hat"] == 1 ? Colors.lightGreenAccent : Colors.redAccent,),
//                     Icon(CustomIcon.t_shirt_1 , color: iconColors["Tshirt"] == 1 ? Colors.lightGreenAccent : Colors.redAccent,),
//                     Icon(CustomIcon.black__1_ , color: iconColors["Pants"] == 1 ? Colors.lightGreenAccent : Colors.redAccent,),
//                     Icon(CustomIcon.necklace,  color: iconColors["Necklace"] == 1 ? Colors.lightGreenAccent : Colors.redAccent, size: 20,)
//                   ],
//                 ),
//               )
//           );
//         }
//         else{
//           return  Container(
//               height: 20,
//               width: 20,
//               child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightGreen,),)
//           );
//         }
//       },
//     );
//   }
//
//
//
//   buildUpper(){
//     return Column(
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//
//           children: [
//             SizedBox(height: 10,),
//             Text(
//               name,
//               style: TextStyle(
//                   fontSize: 25
//               ),
//             ),
//
//             Text("Created " + timeago.format(time.toDate()), style: TextStyle(color: Colors.greenAccent),),
//           ],
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             Stack(
//               overflow: Overflow.visible,
//               children: [
//
//                 Container(
//                     width: 300,
//                     height: 150,
//                     child: Image(image: CachedNetworkImageProvider(mediaURL))
//
//                 ),
//
//
//
//                 Positioned(
//                   top: 20,
//                   right: 20,
//
//                   child: Container(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           FutureBuilder(
//                             future: isFavorited(),
//                             builder: (BuildContext context, AsyncSnapshot snapshot){
//                               if(snapshot.hasData){
//                                 bool favorited = snapshot.data;
//                                 return IconButton(
//                                     icon: favorited == true ? Icon(Icons.star, color: Colors.yellow,) : Icon(Icons.star_border),
//                                     onPressed: ()async{
//                                       await Favorite();
//
//                                     });
//                               }
//                               else{
//                                 return  Container(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightGreen,),)
//                                 );
//                               }
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete,color: Colors.redAccent),
//                             onPressed: (){
//                               return ShowOptions(context);
//                             },
//                           )
//                         ],
//
//                       )
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//
//       ],
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     print("idxx: " + this.QR_id + " name: " + this.name);
//     return Column(
//       children: [
//         buildUpper(),
//         SizedBox(height:10),
//         buildIcons(),
//         SizedBox(height: 10,),
//         Divider(thickness: 1,)
//       ],
//     );
//   }
// }

