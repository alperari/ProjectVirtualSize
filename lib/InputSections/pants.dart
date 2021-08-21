import "package:flutter/material.dart";
import 'dart:async';
import 'package:snapping_sheet/snapping_sheet.dart';

class Pants extends StatefulWidget {

  Map<String,double> data;
  Stream<Map<String,double>> stream;
  StreamController<Map<String,double>> controller;
  Pants({this.data,this.stream,this.controller});

  @override
  _PantsState createState() => _PantsState();
}

class _PantsState extends State<Pants> with AutomaticKeepAliveClientMixin<Pants>{


  final ScrollController _scrollController = ScrollController();

  final _formKey = GlobalKey<FormState>();
  double hip, inLeg, outLeg;
  Map<String,double> ownData = {
    "hip": 0.0,
    "inLeg": 0.0,
    "outLeg": 0.0,
  };


  TextFormField customTextFormField(String name,double myVar){
    return TextFormField(
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
          borderSide: BorderSide(color: Colors.white, width: 1.0),
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
        ownData[name] = double.parse(value);
      },
    );

  }


  bool get wantKeepAlive => true;


  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/imageLowerbody.jpg"),
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
                  color: Colors.grey[700],
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              customTextFormField("hip", hip),
                              SizedBox(height: 12,),
                              customTextFormField("inLeg", inLeg),
                              SizedBox(height: 12,),
                              customTextFormField("outLeg", outLeg),
                              SizedBox(height: 10,),
                              FlatButton(
                                  onPressed: (){
                                    if(_formKey.currentState.validate() == true){
                                      _formKey.currentState.save();

                                      ownData["icon2"] = 1.0;
                                      print("OWN DATA pants: " + ownData.toString());


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

