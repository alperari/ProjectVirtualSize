import 'dart:ui';

import "package:flutter/material.dart";
import 'package:snapping_sheet/snapping_sheet.dart';
import "dart:async";

class Tshirt extends StatefulWidget {

  Map<String,double> data;
  Stream<Map<String,double>> stream;
  StreamController<Map<String,double>> controller;
  Tshirt({this.data,this.stream,this.controller});


  @override
  _TshirtState createState() => _TshirtState();
}

class _TshirtState extends State<Tshirt> with AutomaticKeepAliveClientMixin<Tshirt>{


  final ScrollController _scrollController = ScrollController();

  final _formKey = GlobalKey<FormState>();
  double neck, chest, shoulder, sleeve, length, biceps, waist;
  Map<String,double> ownData = {
    "neck": 0.0,
    "chest": 0.0,
    "shoulder": 0.0,
    "length": 0.0,
    "sleeve": 0.0,
    "biceps": 0.0,
    "waist": 0.0,
  };


  onPressShowDialog(BuildContext context, String inputName,  int min, int max){
    showDialog(context: context,
        barrierDismissible: true,

        builder: (BuildContext dialogContext){
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(left: 20,top: 20, right: 20,bottom: 20
                ),
                margin: EdgeInsets.only(top: 45),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black,offset: Offset(0,10),
                          blurRadius: 10
                      ),
                    ]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Text(inputName,style: TextStyle(color:Colors.black,fontSize: 22,fontWeight: FontWeight.w600),),
                    SizedBox(height: 15,),
                    Text("The value should be between: ${min} - ${max}",style: TextStyle(color:Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                    SizedBox(height: 22,),

                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget customTextFormField(String name, int min, int max, Color mycolor){

    return Row(
      children: [
        GestureDetector(
          child: Icon(Icons.info_sharp, color: mycolor,),
          onTapDown: (_){
            onPressShowDialog(context, name, min, max);
          },
          onTapUp: (_){
          }
        ),
        SizedBox(width: 8,),
        Expanded(
            child:TextFormField(
              style: TextStyle(
                  color: Colors.white
              ),
              decoration: InputDecoration(

                contentPadding: EdgeInsets.all(8),
                labelText: name ,
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mycolor, width: 1.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
                ),
                errorStyle: TextStyle(height: 0, color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if(value.isEmpty || double.parse(value) < min || double.parse(value) > max ) {
                  return "";
                }
                return null;
              },
              onSaved: (String value) {
                ownData[name.toLowerCase()] = double.parse(value);
              },
            )

        ),
      ],
    );


  }

  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/imageUpperbody.jpg"),
              fit: BoxFit.cover
          )
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 50,
            height: 500,
            child: SnappingSheet.horizontal(
              lockOverflowDrag: true,
              snappingPositions: [
                SnappingPosition.factor(
                  positionFactor: 1.0,
                  grabbingContentOffset: GrabbingContentOffset.bottom,
                ),
                SnappingPosition.factor(
                  positionFactor: 0.60,
                ),
                SnappingPosition.factor(
                  positionFactor: 0.60
                ),
              ],
              grabbingWidth: 40,
              grabbing: _GrabbingWidget(),
              sheetRight: SnappingSheetContent(
                draggable: true,
                childScrollController: _scrollController,
                child: Container(
                  color: Colors.grey[700],
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    padding: EdgeInsets.all(15),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width:110,
                        height: 200,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [


                              customTextFormField("Neck", 30, 87, Colors.lightBlueAccent),
                              SizedBox(height: 12,),
                              customTextFormField("Chest", 55,155, Colors.redAccent),
                              SizedBox(height: 12,),
                              customTextFormField("Shoulder", 21,72, Colors.greenAccent),
                              SizedBox(height: 12,),
                              customTextFormField("Length", 45,110, Colors.yellow),
                              SizedBox(height: 12,),
                              customTextFormField("Sleeve", 0,70, Colors.purple[300]),
                              SizedBox(height: 12,),
                              customTextFormField("Biceps", 12,63, Colors.pinkAccent),
                              SizedBox(height: 12,),
                              customTextFormField("Waist", 55,161, Colors.orangeAccent),

                              FlatButton(
                                  onPressed: (){
                                    if(_formKey.currentState.validate() == true){
                                      _formKey.currentState.save();

                                      ownData["icon1"] = 1.0;
                                      print("OWN DATA tshirt: " + ownData.toString());


                                      //set issetTshirt = true

                                      widget.controller.add(ownData);
                                    }
                                    else{

                                    }
                                  },
                                  color: Colors.grey[300],
                                  child: Text("SAVE"))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}

class _GrabbingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            width: 7,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          Container(
            width: 2,
            color: Colors.grey[300],
            margin: EdgeInsets.only(top: 15, bottom: 15),
          )
        ],
      ),
    );
  }


}

