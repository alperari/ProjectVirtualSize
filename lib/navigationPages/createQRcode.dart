import "package:flutter/material.dart";
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:virtual_size_app/services/databaseServices.dart';

class createQRcode extends StatefulWidget {
  @override
  _createQRcodeState createState() => _createQRcodeState();
}

class _createQRcodeState extends State<createQRcode> {

  final _formKey = GlobalKey<FormState>();
  double input1, input2, input3, input4, input5;
  bool isset=false;
  QrImage image = null;
  String QR_id;


  Future<void> createQR_FireStore(Map<String,double> data) async{
    await usersRef.doc()
  }

  void createQR(Map<String,double> data){
    setState(() {
      image = QrImage(
        data: data.toString(),
        version: QrVersions.auto,
        size: 200.0,
      );
      QR_id = Uuid().v4();
      isset = true;
    });
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
                  onPressed: ()  {
                    if(_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                     if(!isset){
                       Map<String,double> data = {"input1":input1, "input2":input2,"input3":input3,"input4":input4,"input5":input5};

                       createQR(data);

                       print(QR_id);
                     }
                    }
                  },
                  child: Text("Create QR Code", style: TextStyle(color:Colors.black),),
                  color: Colors.lightGreen,
                ),

                Container(
                  child: !isset? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                  ):
                 image
                )
              ],

            ),

          ),


        ],
      ),
    );
  }
}
