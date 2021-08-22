import 'package:flutter/material.dart';
import 'package:virtual_size_app/navigationPages/createQR/createQRcode.dart';

class createQRcode_getName extends StatefulWidget {
  @override
  _createQRcode_getNameState createState() => _createQRcode_getNameState();
}

class _createQRcode_getNameState extends State<createQRcode_getName> {
  String name;
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 300,
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
          child: Image.asset("assets/qr_sample.png"),
        ),
        SizedBox(height: 10,),
        Container(

          decoration: BoxDecoration(
            color: Colors.deepPurple,
              borderRadius: BorderRadius.all(Radius.circular(20),),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple[700].withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 9,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],

          ),
          width: MediaQuery.of(context).size.width*3/4,
          child: TextField(
            style: TextStyle(color: Colors.white, fontSize: 20),
            controller: _nameController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey[300]),
              contentPadding:  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              labelText: "NAME YOUR QR",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            onChanged: (String value){
              setState(() {
                name = value;
              });
            },


          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 9,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(7),),
              color: (name == "" || name==null) ? Colors.grey[700] : Colors.deepPurple
          ),

          child: IconButton(
            icon: Icon(Icons.double_arrow, color: Colors.white,
            ),
            iconSize: 30,
            onPressed: (){
              if(_nameController.text != ""){
                setState(() {
                  name = _nameController.text;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => createQRcode(name)));

              }
            },
          ),
        ),
      ],
    );
  }
}
