import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart';

import "package:flutter/material.dart";
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:virtual_size_app/services/databaseServices.dart';
import 'package:virtual_size_app/models/customDialogBox.dart';

class createQRcode extends StatefulWidget {
  @override
  _createQRcodeState createState() => _createQRcodeState();
}

class _createQRcodeState extends State<createQRcode> {

  final _formKey = GlobalKey<FormState>();
  double input1, input2, input3, input4, input5;
  bool isset=false;
  String QR_id;
  File imageFile;

  Future<void> CreateQR_Firestore({String mediaURL, String QR_id, String ownerID, String name, var time, }) async{
    await QRsRef.doc(auth.uid).collection("my_QRs").doc(QR_id).set(
      {
        "name" : name,
        "QR_id": QR_id,
        "ownerID": ownerID,
        "mediaURL": mediaURL,
        "time": time,
      }
    );
  }

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

  Future<String> uploadImage(File imageFile, String QR_id, String name) async {
    UploadTask uploadTask = storageRef.child("QRs/qr_$QR_id.jpg").putFile(imageFile);
    TaskSnapshot storageSnap = await uploadTask.whenComplete(() {});
    String downloadUrl = await storageSnap.ref.getDownloadURL();


    await CreateQR_Firestore(
      name: name,
      QR_id: QR_id,
      ownerID: auth.uid,
      mediaURL: downloadUrl,
      time: DateTime.now().toString()
    );


  }





  Future<void> createQR(Map<String,double> data) async{
    setState(()  {
      QR_id = Uuid().v4();
      isset = true;

    });

    imageFile =await Convert_QR_to_File(data.toString());




    imageFile = await compressImage(imageFile);

    String mediaURL = await uploadImage(imageFile, QR_id, "testname");

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
                  width:80,
                  height: 60,
                  child: TextFormField(
                    decoration: new InputDecoration(
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
                      input1 = double.parse(value);
                    },
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width:80,
                  height: 60,
                  child: TextFormField(
                    decoration: new InputDecoration(
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
                      input2 = double.parse(value);
                    },
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width:80,
                  height: 60,
                  child: TextFormField(
                    decoration: new InputDecoration(
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
                      input3 = double.parse(value);
                    },
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width:80,
                  height: 60,
                  child: TextFormField(
                    decoration: new InputDecoration(
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
                      input4 = double.parse(value);
                    },
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width:80,
                  height: 60,
                  child: TextFormField(
                    decoration: new InputDecoration(
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
                      input5 = double.parse(value);
                    },
                  ),
                ),
                SizedBox(height: 10,),
                FlatButton(
                  onPressed: ()  async {
                    if(_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                     if(!isset){
                       Map<String,double> data = {"input1":input1, "input2":input2,"input3":input3,"input4":input4,"input5":input5};

                       showDialog(context: context,
                           builder: (BuildContext context){
                             return CustomDialogBox(
                               title: "Well Done!",
                               descriptions: "You've successfully created a new QR code. You can display your all of your QR codes in Display Section.",
                               text: "OK",
                             );
                           }
                       );

                       await createQR(data);

                       print(QR_id);

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
