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

import 'package:virtual_size_app/services/databaseServices.dart';
import 'package:virtual_size_app/models/customDialogBox.dart';

class createQRcode extends StatefulWidget {
  @override
  _createQRcodeState createState() => _createQRcodeState();
}

class _createQRcodeState extends State<createQRcode> {

  final _formKey = GlobalKey<FormState>();
  double head, neck, shoulder, chest, biceps, Tlength, waist, hip, inLeg, outLeg;
  String QRname;
  bool isset=false;
  String QR_id;
  File imageFile;

  Future<bool> done;

  Future<void> CreateQR_Firestore({String mediaURL, String QR_id, String ownerID, String name, DateTime time, Map<String,double> mapData}) async{
    await QRsRef.doc(auth.uid).collection("my_QRs").doc(QR_id).set(
      {
        "name" : name,
        "QR_id": QR_id,
        "ownerID": ownerID,
        "mediaURL": mediaURL,
        "time": time,
        "measureData": mapData,
        "favorited": false
      }
    );
  }

  // Future<void> UpdateQR_Firestore({String ownerID, String QR_id, Map<String, double> mapData})async{
  //   DocumentSnapshot snapshot = await usersRef
  //       .doc(ownerID)
  //       .collection("my_QRs")
  //       .doc(QR_id)
  //       .get();
  //
  //   if(snapshot.exists){
  //     print("updated!");
  //     snapshot.reference.update(mapData);
  //   }
  // }

  Future<File> Convert_QR_to_File(String data) async {
    try {
      final image = await QrPainter(
        data: data,
        version: QrVersions.auto,
        gapless: false,
        color: Colors.black,
        emptyColor: Colors.white
      ).toImage(300);

      final bytedata = await image.toByteData(format: ImageByteFormat.png);

      final buffer = bytedata.buffer;

      String tempPath = (await getTemporaryDirectory()).path;

      return File('$tempPath/profile.png').writeAsBytes(buffer.asUint8List(bytedata.offsetInBytes, bytedata.lengthInBytes));

    } catch (e) {
      throw e;
    }
  }

  Future<File> compressImage(File myfile) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    im.Image Imagefile = im.decodeImage(myfile.readAsBytesSync());
    final compressedImageFile = File('$tempPath/qr_$QR_id.jpg')..writeAsBytesSync(im.encodeJpg(Imagefile, quality: 85));

    return compressedImageFile;
  }

  Future<bool> uploadImage(File imageFile, String QR_id, String name, Map<String, double> mapData) async {

    UploadTask uploadTask = storageRef.child("QRs/qr_$QR_id.jpg").putFile(imageFile);
    TaskSnapshot storageSnap = await uploadTask.whenComplete(() {});
    String downloadUrl = await storageSnap.ref.getDownloadURL();


    //Create QRcode in QRs collection
    await CreateQR_Firestore(
      name: name,
      QR_id: QR_id,
      ownerID: auth.uid,
      mediaURL: downloadUrl,
      time: DateTime.now(),
      mapData: mapData
    );


  }





  Future<void> createQR(Map<String,double> data) async{
    setState(()  {
      QR_id = Uuid().v4();
      isset = true;

    });

    imageFile =await Convert_QR_to_File(data.toString());
    imageFile = await compressImage(imageFile);
    await uploadImage(imageFile, QR_id, QRname, data);

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [

          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width:300,
                  height: 50,
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Name Your QR",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),

                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if(value.isEmpty) {
                        return 'Enter name!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      QRname = value;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Column(
                  children: [
                    SizedBox(
                      width:100,
                      height: 30,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "head",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),

                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter value!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          head = double.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:100,
                      height: 30,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "neck",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),

                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter value!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          neck = double.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:100,
                      height: 30,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "shoulder",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),

                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter value!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          shoulder = double.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:100,
                      height: 30,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "chest",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),

                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter value!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          chest = double.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:100,
                      height: 30,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "biceps",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),

                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter value!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          biceps = double.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:100,
                      height: 30,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Tlength",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),

                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter value!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          Tlength = double.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:100,
                      height: 30,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "waist",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),

                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter value!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          waist = double.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:100,
                      height: 30,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "hip",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),

                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter value!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          hip = double.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:100,
                      height: 30,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "inLeg",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),

                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter value!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          inLeg = double.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:100,
                      height: 30,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "outLeg",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),

                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Enter value!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          outLeg = double.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
                FlatButton(
                  onPressed: ()  async {
                    if(_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                     if(!isset){
                       Map<String,double> data = {
                         "head":head,
                         "neck":neck,
                         "shoulder":shoulder,
                         "chest":chest,
                         "biceps":biceps,
                         "Tlength":Tlength,
                         "waist":waist,
                         "hip":hip,
                         "inLeg":inLeg,
                         "outLeg":outLeg
                       };

                       showDialog(context: context,
                           barrierDismissible: false,
                           builder: (BuildContext dialogContext){
                            return CustomDialogBox(
                              title: "GENERATING QR CODE...",
                              descriptions: "This process will end in seconds.",
                            );
                          }
                        );

                        await createQR(data);
                        Navigator.pop(context);
                       _formKey.currentState.reset();
                     }
                    }
                  },
                  child: Text("Create QR Code", style: TextStyle(color:Colors.black),),
                  color: Colors.lightGreen,
                ),

                Container(
                  child:  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                  )
                ),

              ],

            ),

          ),


        ],
      ),
    );
  }
}
