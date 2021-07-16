import "package:flutter/material.dart";
import 'package:snapping_sheet/snapping_sheet.dart';
import "dart:async";
import 'package:virtual_size_app/navigationPages/displayQRs.dart';

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



  TextFormField customTextFormField(String name,double myVar){
    return TextFormField(
      style: TextStyle(
          color: Colors.black
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        labelText: name ,
        labelStyle: TextStyle(
            color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        errorStyle: TextStyle(height: 0),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if(value.isEmpty) {
          return "";
        }
        return null;
      },
      onSaved: (String value) {
        ownData[name.toLowerCase()] = double.parse(value);
      },
    );

  }

  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: [
        Image.asset("assets/imageUpperbody.jpg"),
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
                positionFactor: 0.67,
              ),
              SnappingPosition.factor(
                positionFactor: 0.67
              ),
            ],
            grabbingWidth: 40,
            grabbing: _GrabbingWidget(),
            sheetRight: SnappingSheetContent(
              draggable: true,
              childScrollController: _scrollController,
              child: Container(
                color: Colors.white,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  padding: EdgeInsets.all(15),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width:80,
                      height: 200,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customTextFormField("Neck", neck),
                            SizedBox(height: 12,),
                            customTextFormField("Chest", chest),
                            SizedBox(height: 12,),
                            customTextFormField("Shoulder", shoulder),
                            SizedBox(height: 12,),
                            customTextFormField("Length", length),
                            SizedBox(height: 12,),
                            customTextFormField("Sleeve", sleeve),
                            SizedBox(height: 12,),
                            customTextFormField("Biceps", biceps),
                            SizedBox(height: 12,),
                            customTextFormField("Waist", waist),

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
                                color: Colors.blue,
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
        color: Colors.white,
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
              color: Colors.grey,
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

