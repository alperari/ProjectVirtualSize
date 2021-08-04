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

          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20),),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 9,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.purple, Colors.blue])
          ),
          width: MediaQuery.of(context).size.width*3/4,
          child: TextField(
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
                  color: Colors.orange.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 9,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(7),),
              color: Colors.orangeAccent
          ),

          child: IconButton(
            icon: Icon(Icons.check, color: Colors.white,
            ),
            iconSize: 30,
            onPressed: (){
              setState(() {
                name = _nameController.text;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) => createQRcode(name)));

            },
          ),
        ),
      ],
    );
  }
}
