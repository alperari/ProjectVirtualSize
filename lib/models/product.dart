import 'dart:math';
import 'dart:ui';
import 'package:virtual_size_app/services/databaseServices.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Product{
  final GlobalKey key;

  final String id;

  final String Company;
  final dynamic Price;
  final Map<String,dynamic> measureData;
  final String mediaUrl;
  //Constructor
  Product({
    this.key,
    this.id,
    this.Company,
    this.Price,
    this.measureData,
    this.mediaUrl
  });


}

class TshirtProduct extends Product{

  final String Size;

  TshirtProduct({
    GlobalKey key,
    String id,

    String Company,
    dynamic Price,
    Map<String,dynamic> measureData,
    String mediaUrl,
    this.Size
  })
  : super(key:key, id: id,Company: Company, Price: Price, measureData: measureData, mediaUrl: mediaUrl);

  factory TshirtProduct.fromDoc(DocumentSnapshot doc, GlobalKey mykey){
    var id = doc.id;
    var company = doc.get("Company");
    var price = doc.get("Price");
    Map<String, dynamic> measures = doc.get("measureData");
    var mediaUrl = doc.get("mediaUrl");
    var size = doc.get("Size");

    //print(company.toString() + price.toString() + measures.toString() + mediaUrl.toString());
    return TshirtProduct(
      key: mykey,
      id: id,
      Company: company,
      Price: price,
      measureData: measures,
      mediaUrl: mediaUrl,
      Size: size,
    );
  }


  ///TODO: finish biceps
  Future<void> getVirtualSize_Biceps(double bicepsValue)async{
    List<String> valuesArray = [];
    DocumentSnapshot pmDoc;
    QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Biceps").get();


    for(DocumentSnapshot doc in snapshot.docs){
      //print(doc.id);

      if(doc.get("PM")[0] <= bicepsValue && doc.get("PM")[1] >= bicepsValue ){
        //this is the document that matches PM interval.
        pmDoc = doc;
        break;
      }
    }

    print("Biceps: " + pmDoc?.id.toString());
  }


  Future<void> getVirtualSize_Chest(double chestValue)async{

    List<String> valuesArray = [];
    List<DocumentSnapshot> PMmatches = [];
    DocumentSnapshot pmDoc;
    QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Chest").get();


    for(DocumentSnapshot doc in snapshot.docs){
      if(doc.get("PM")[0] <= chestValue && doc.get("PM")[1] >= chestValue ){
        //this is the document that matches PM interval.
        //add this doc to PMmatches
        PMmatches.add(doc);
      }
    }
    if(PMmatches.length == 1){
      pmDoc = PMmatches[0];
    }
    else {
      double minDiff = 999;
      for(DocumentSnapshot element in PMmatches){
        double start = element.get("PM")[0].toDouble();
        double end = element.get("PM")[1].toDouble();
        double mid = start+end/2;
        double diff = (mid-chestValue).abs();
        if(diff <= minDiff){
          minDiff = diff;
          pmDoc = element;
        }
      }
    }
    print("Chest: " + pmDoc.id);

  }


  Future<void> getVirtualSize_Shoulder(double shoulderValue)async{

    List<String> valuesArray = [];
    List<DocumentSnapshot> PMmatches = [];
    DocumentSnapshot pmDoc;
    QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Shoulder").get();


    for(DocumentSnapshot doc in snapshot.docs){
      if(doc.get("PM")[0] <= shoulderValue && doc.get("PM")[1] >= shoulderValue ){
        //this is the document that matches PM interval.
        //add this doc to PMmatches
        PMmatches.add(doc);
      }
    }
    if(PMmatches.length == 1){
      pmDoc = PMmatches[0];
    }
    else {
      double minDiff = 999;
      for(DocumentSnapshot element in PMmatches){
        double start = element.get("PM")[0].toDouble();
        double end = element.get("PM")[1].toDouble();
        double mid = start+end/2;
        double diff = (mid-shoulderValue).abs();
        if(diff <= minDiff){
          minDiff = diff;
          pmDoc = element;
        }
      }
    }
    print("Shoulder: " + pmDoc.id);

  }


  Future<void> getVirtualSize_Length(double lengthValue)async{

    List<String> valuesArray = [];
    List<DocumentSnapshot> PMmatches = [];
    DocumentSnapshot pmDoc;
    QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Length").get();


    for(DocumentSnapshot doc in snapshot.docs){
      if(doc.get("PM")[0] <= lengthValue && doc.get("PM")[1] >= lengthValue ){
        //this is the document that matches PM interval.
        //add this doc to PMmatches
        PMmatches.add(doc);
      }
    }
    if(PMmatches.length == 1){
      pmDoc = PMmatches[0];
    }
    else {
      double minDiff = 999;
      for(DocumentSnapshot element in PMmatches){
        double start = element.get("PM")[0].toDouble();
        double end = element.get("PM")[1].toDouble();
        double mid = start+end/2;
        double diff = (mid-lengthValue).abs();
        if(diff <= minDiff){
          minDiff = diff;
          pmDoc = element;
        }
      }
    }
    print("Length: " + pmDoc.id);

  }


  Future<void> getVirtualSize_Neck(double neckValue)async{

    List<String> valuesArray = [];
    List<DocumentSnapshot> PMmatches = [];
    DocumentSnapshot pmDoc;
    QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Neck").get();


    for(DocumentSnapshot doc in snapshot.docs){
      if(doc.get("PM")[0] <= neckValue && doc.get("PM")[1] >= neckValue ){
        //this is the document that matches PM interval.
        //add this doc to PMmatches
        PMmatches.add(doc);
      }
    }
    if(PMmatches.length == 1){
      pmDoc = PMmatches[0];
    }
    else {
      double minDiff = 999;
      for(DocumentSnapshot element in PMmatches){
        double start = element.get("PM")[0].toDouble();
        double end = element.get("PM")[1].toDouble();
        double mid = start+end/2;
        double diff = (mid-neckValue).abs();
        if(diff <= minDiff){
          minDiff = diff;
          pmDoc = element;
        }
      }
    }

    print("Neck: " + pmDoc.id);
  }


  Future<void> getVirtualSize_Waist(double waistValue)async{

    List<String> valuesArray = [];
    List<DocumentSnapshot> PMmatches = [];
    DocumentSnapshot pmDoc;
    QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Waist").get();


    for(DocumentSnapshot doc in snapshot.docs){
      if(doc.get("PM")[0] <= waistValue && doc.get("PM")[1] >= waistValue ){
        //this is the document that matches PM interval.
        //add this doc to PMmatches
        PMmatches.add(doc);
      }
    }
    if(PMmatches.length == 1){
      pmDoc = PMmatches[0];
    }
    else {
      double minDiff = 999;
      for(DocumentSnapshot element in PMmatches){
        double start = element.get("PM")[0].toDouble();
        double end = element.get("PM")[1].toDouble();
        double mid = start+end/2;
        double diff = (mid-waistValue).abs();
        if(diff <= minDiff){
          minDiff = diff;
          pmDoc = element;
        }
      }
    }
    print("Waist: " + pmDoc.id);

  }

  
  Future<void> getVirtualSizes()async {
    double biceps = double.parse(this.measureData["arm"])*2;
    double chest = double.parse(this.measureData["chest"]);
    double shoulder = double.parse(this.measureData["shoulder"]);
    double length = double.parse(this.measureData["length"]);

    double neck_x = double.parse(this.measureData["neck_x"]);
    double neck_y = double.parse(this.measureData["neck_y"]);

    double neck = (neck_x+neck_y)*pi/2;
    double waist = double.parse(this.measureData["waist"]);
    double sleeve = double.parse(this.measureData["sleeve"]);
    
    print( neck);
    print( chest);
    print( shoulder);

    print( biceps);
    print( sleeve);
    print( waist);

    print( length);

    await getVirtualSize_Biceps(biceps);
    await getVirtualSize_Chest(chest);
    await getVirtualSize_Shoulder(shoulder);
    await getVirtualSize_Length(length);
    await getVirtualSize_Neck(neck);
    await getVirtualSize_Waist(waist);
    
    
  }

  onPressShowDialog(BuildContext context, String matchInfo, String tshirtComponent){
    String description = "";
    if(matchInfo=="XUM"){
      description = "This Tshirt's Shoulder Part Will Fit Very Compressed";
    }
    else if(matchInfo=="UM"){
      description = "This Tshirt's Shoulder Part Will Fit Compressed";
    }

    else if(matchInfo=="AH"){
      description = "This Tshirt Will Stand Very Above Your Hip Level";
    }
    else if(matchInfo=="H"){
      description = "This Tshirt Will Stand Above Your Hip Level";
    }
    else if(matchInfo=="PM" && tshirtComponent == "Length"){
      description = "This Tshirt Will Stand At Your Hip Level";
    }
    else if(matchInfo=="LM"&& tshirtComponent == "Length"){
      description = "This Tshirt Will Stand Below Your Hip Level";
    }
    else if(matchInfo=="XLM"&& tshirtComponent == "Length"){
      description = "This Tshirt Will Stand Very Below Your Hip Level";
    }

    else if(matchInfo=="FM"){
      description = "This Tshirt's " + tshirtComponent + " Part Will Fit Well";
    }
    else if(matchInfo=="PM"){
      description = "This Tshirt's " + tshirtComponent + " Part Will Fit Perfectly Well";
    }
    else if(matchInfo=="LM"){
      description = "This Tshirt's " + tshirtComponent + " Part Will Fit Loose";
    }
    else if(matchInfo=="XLM"){
      description = "This Tshirt's " + tshirtComponent + " Part Will Fit Very Loose";
    }
    else if(matchInfo=="SHORT SLEEVE"){
      description = "This Tshirt's Sleeves Will Fit Shorter";
    }
    else if(matchInfo=="PERFECT SLEEVE"){
      description = "This Tshirt's Sleeves Will Fit Perfectly";
    }
    else if(matchInfo=="LONG SLEEVE"){
      description = "This Tshirt's Sleeves Will Fit Longer";
    }


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
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black,offset: Offset(0,6),
                          blurRadius: 10
                      ),
                    ]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(tshirtComponent, style: GoogleFonts.ptSans(color:Colors.black,fontSize: 22, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

                    SizedBox(height: 8,),
                    Text(description,style: GoogleFonts.ptSans(color:Colors.black,fontSize: 17),textAlign: TextAlign.center,),
                    SizedBox(height: 15,),

                  ],
                ),
              ),
            ),
          );
    }
    );
  }



  Widget buildtBottom_Filtered({BuildContext context, List<String> matchData}){

    String info_chest = matchData[0];
    String info_waist = matchData[1];
    String info_neck = matchData[2];
    String info_shoulder = matchData[3];
    String info_biceps = matchData[4];
    String info_length = matchData[5];
    String info_sleeve = matchData[6];


    TextStyle inactiveTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[600]);
    TextStyle activeTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white);


    BoxShadow inactiveBoxShadow = BoxShadow();
    BoxShadow activeBowShadow = BoxShadow(
      color: Colors.deepPurple.withOpacity(0.4),
      spreadRadius: 4,
      blurRadius: 8,
      offset: Offset(0, 0), // changes position of shadow
    );

    Color inactiveColor = Colors.grey[400];
    Color activeColor =  Colors.deepPurple[400];

    return Expanded(
      child: ListView(
        children: [
          //CHEST
          GestureDetector(
            onTap: (){
              onPressShowDialog(context, info_chest, "Chest");
            },
            child: Column(
              children: [
                Text("Chest", style: GoogleFonts.righteous(fontSize: 20),),
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: info_chest == "FM" ? activeColor : inactiveColor,
                          boxShadow: info_chest == "FM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 74,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("FM",style: info_chest == "FM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        width: 74,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_chest == "PM" ? activeColor : inactiveColor,
                          boxShadow: info_chest == "PM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("PM",style: info_chest == "PM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        width: 74,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_chest == "LM" ? activeColor : inactiveColor,
                          boxShadow: info_chest == "LM" ? [activeBowShadow] : [inactiveBoxShadow],


                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("LM",style: info_chest == "LM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),

                          ),
                          color: info_chest == "XLM" ? activeColor : inactiveColor,
                          boxShadow: info_chest == "XLM" ? [activeBowShadow] : [inactiveBoxShadow],


                        ),
                        width: 74,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("XLM",style: info_chest == "XLM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),

          //WAIST
          GestureDetector(
            onTap: (){
              onPressShowDialog(context, info_waist, "Waist");
            },
            child: Column(
              children: [
                Text("Waist", style: GoogleFonts.righteous(fontSize: 20),),
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: info_waist == "FM" ? activeColor : inactiveColor,
                          boxShadow: info_waist == "FM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 74,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("FM",style: info_waist == "FM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        width: 74,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_waist == "PM" ? activeColor : inactiveColor,
                          boxShadow: info_waist == "PM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("PM",style: info_waist == "PM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        width: 74,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_waist == "LM" ? activeColor : inactiveColor,
                          boxShadow: info_waist == "LM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("LM",style: info_waist == "LM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),

                          ),
                          color: info_waist == "XLM" ? activeColor : inactiveColor,
                          boxShadow: info_waist == "XLM" ? [activeBowShadow] : [inactiveBoxShadow],


                        ),
                        width: 74,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("XLM",style: info_waist == "XLM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),

          //NECK
          GestureDetector(
            onTap: (){
              onPressShowDialog(context, info_neck, "Neck");
            },
            child: Column(
              children: [
                Text("Neck", style: GoogleFonts.righteous(fontSize: 20),),
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: info_neck == "NM" ? activeColor : inactiveColor,
                          boxShadow: info_neck == "NM" ? [activeBowShadow] : [inactiveBoxShadow],
                        ),
                        width: 49,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("NM",style: info_neck == "NM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        width: 49,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_neck == "XFM" ? activeColor : inactiveColor,
                          boxShadow: info_neck == "XFM" ? [activeBowShadow] : [inactiveBoxShadow],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("XFM",style: info_neck == "XFM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        width: 49,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_neck == "FM" ? activeColor : inactiveColor,
                          boxShadow: info_neck == "FM" ? [activeBowShadow] : [inactiveBoxShadow],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("FM",style: info_neck == "FM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: info_neck == "PM" ? activeColor : inactiveColor,
                          boxShadow: info_neck == "PM" ? [activeBowShadow] : [inactiveBoxShadow],
                        ),
                        width: 49,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("PM",style: info_neck == "PM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: info_neck == "LM" ? activeColor : inactiveColor,
                          boxShadow: info_neck == "LM" ? [activeBowShadow] : [inactiveBoxShadow],
                        ),
                        width: 49,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("LM",style: info_neck == "LM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),

                          ),
                          color: info_neck == "XLM" ? activeColor : inactiveColor,
                          boxShadow: info_neck == "XLM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 49,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("XLM",style: info_neck == "XLM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),

          //SHOULDER
          GestureDetector(
            onTap: (){
              onPressShowDialog(context, info_shoulder, "Shoulder");
            },
            child: Column(
              children: [
                Text("Shoulder", style: GoogleFonts.righteous(fontSize: 20),),
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: info_shoulder == "XUM" ? activeColor : inactiveColor,
                          boxShadow: info_shoulder == "XUM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 59,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("XUM",style: info_shoulder == "XUM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        width: 59,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_shoulder == "UM" ? activeColor : inactiveColor,
                          boxShadow: info_shoulder == "UM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("UM",style: info_shoulder == "UM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        width: 59,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_shoulder == "PM" ? activeColor : inactiveColor,
                          boxShadow: info_shoulder == "PM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("PM",style: info_shoulder == "PM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        width: 59,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_shoulder == "LM" ? activeColor : inactiveColor,
                          boxShadow: info_shoulder == "LM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("LM",style: info_shoulder == "LM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),

                          ),
                          color: info_shoulder == "XLM" ? activeColor : inactiveColor,
                          boxShadow: info_shoulder == "XLM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 59,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("XLM",style: info_shoulder == "XLM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),

          //BICEPS
          GestureDetector(
            onTap: (){
              onPressShowDialog(context, info_biceps, "Biceps");
            },
            child: Column(
              children: [
                Text("Biceps", style: GoogleFonts.righteous(fontSize: 20),),
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: info_biceps == "FM" ? activeColor : inactiveColor,
                          boxShadow: info_biceps == "FM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 74,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("FM",style: info_biceps == "FM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: info_biceps == "PM" ? activeColor : inactiveColor,
                          boxShadow: info_biceps == "PM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 74,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("PM",style: info_biceps == "PM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        width: 74,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_biceps == "LM" ? activeColor : inactiveColor,
                          boxShadow: info_biceps == "LM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("LM",style: info_biceps == "LM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),

                          ),
                          color: info_biceps == "XLM" ? activeColor : inactiveColor,
                          boxShadow: info_biceps == "XLM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 74,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("XLM",style: info_biceps == "XLM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),

          //LENGTH
          GestureDetector(
            onTap: (){
              onPressShowDialog(context, info_length, "Length");
            },
            child: Column(
              children: [
                Text("Length", style: GoogleFonts.righteous(fontSize: 20),),
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: info_length == "AH" ? activeColor : inactiveColor,
                          boxShadow: info_length == "AH" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 59,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("AH",style: info_length == "AH" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: info_length == "H" ? activeColor : inactiveColor,
                          boxShadow: info_length == "H" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 59,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("H",style: info_length == "H" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        width: 59,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_length == "PM" ? activeColor : inactiveColor,
                          boxShadow: info_length == "PM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("PM",style: info_length == "PM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        width: 59,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_length == "LM" ? activeColor : inactiveColor,
                          boxShadow: info_length == "LM" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("LM",style: info_length == "LM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),

                          ),
                          color: info_length == "XLM" ? activeColor : inactiveColor,
                          boxShadow: info_length == "XLM" ? [activeBowShadow] : [inactiveBoxShadow],


                        ),
                        width: 59,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("XLM",style: info_length == "XLM" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),

          //SLEEVE
          GestureDetector(
            onTap: (){
              onPressShowDialog(context, info_sleeve, "Sleeve");
            },
            child: Column(
              children: [
                Text("Sleeve", style: GoogleFonts.righteous(fontSize: 20),),
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: info_sleeve == "SHORT SLEEVE" ? activeColor : inactiveColor,
                          boxShadow: info_sleeve == "SHORT SLEEVE" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 99,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("SHORT",style: info_sleeve == "SHORT SLEEVE" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),


                      Container(
                        width: 99,
                        height: 25,
                        decoration: BoxDecoration(
                          color: info_sleeve == "PERFECT SLEEVE" ? activeColor : inactiveColor,
                          boxShadow: info_sleeve == "PERFECT SLEEVE" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("PERFECT",style: info_sleeve == "PERFECT SLEEVE" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 25,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: info_sleeve == "LONG SLEEVE" ? activeColor : inactiveColor,
                          boxShadow: info_sleeve == "LONG SLEEVE" ? [activeBowShadow] : [inactiveBoxShadow],

                        ),
                        width: 99,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("LONG",style: info_sleeve == "LONG SLEEVE" ? activeTextStyle : inactiveTextStyle,),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),

        ],
      ),
    );
  }

  Widget ReturnTshirtProductWidget_Filtered(BuildContext context, List<String> matchData, double Rate){
    return Container(
      margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 30),
      height: 600,
      width: 400,
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
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      child: Padding(
        padding: EdgeInsets.fromLTRB(15,15,15,0),
        child: Column(

          children: [

            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(this.Company.toUpperCase(),style: GoogleFonts.bebasNeue(color: Colors.black,fontSize: 25)),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        Text("\$ " + this.Price.toString(), style: GoogleFonts.ruda(color: Colors.deepPurple, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                        icon: Icon(Icons.more_vert, color: Colors.grey,),
                        key: this.key,
                        itemBuilder: (_) => <PopupMenuItem<String>>[
                          new PopupMenuItem<String>(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      width: 230,
                                      height: 300,
                                      //color: Colors.red,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Size", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                                              Text(this.Size, style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400]))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Chest", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                                              Text(this.measureData["chest"].toString(), style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400]))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Waist", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                                              Text(this.measureData["waist"].toString(), style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400]))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Neck", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                                              Text(((double.parse(this.measureData["neck_x"]) + double.parse(this.measureData["neck_y"]))*pi/2).toStringAsFixed(2)
                                                  , style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400]))
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Shoulder", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                                              Text(this.measureData["shoulder"].toString(), style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400]))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Biceps", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                                              Text((double.parse(this.measureData["arm"])*2).toString(), style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400]))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Length", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                                              Text(this.measureData["length"].toString(), style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400]))
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Sleeve", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                                              Text(this.measureData["sleeve"].toString(), style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400]))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                        onSelected: (_) {}
                    ),
                  ],
                ),
              ],
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 280,
                  height: 280,
                  child: Container(
                    child: ClipRRect(
                      child: Image.network(this.mediaUrl, fit: BoxFit.cover,),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            LinearPercentIndicator(
              width: 300,
              animation: true,
              lineHeight: 24.0,
              animationDuration: 2000,
              percent: (Rate/100),
              center: Text(Rate.toStringAsFixed(1)+ "%", style: GoogleFonts.ruda(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.deepOrange,
            ),
            SizedBox(height: 8,),
            buildtBottom_Filtered(context: context, matchData: matchData),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_drop_down_rounded,color: Colors.grey,size:35),
              ],
            ),
          ],
        ),
      )
    );
  }




  PageController _pageController = PageController();

  Widget buildSecondPage_Unfiltered(){
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: 400,
          height: 300,
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios,color: Colors.grey,),
            ],
          )
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Neck_x: ", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                  Text(this.measureData["neck_x"] + " cm", style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Neck_y: ", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                  Text(this.measureData["neck_y"] + " cm", style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Chest: ", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                  Text(this.measureData["chest"] + " cm", style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shoulder: ", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                  Text(this.measureData["shoulder"] + " cm", style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Waist: ", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                  Text(this.measureData["waist"] + " cm", style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Length: ", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                  Text(this.measureData["length"] + " cm", style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Biceps: ", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                  Text(this.measureData["arm"] + " cm", style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sleeve: ", style: GoogleFonts.righteous(fontSize: 20,color: Colors.grey[800])),
                  Text(this.measureData["sleeve"] + " cm", style: GoogleFonts.righteous(fontSize: 24,color: Colors.deepPurple[400])),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget ReturnTshirtProductWidget_UnFiltered(BuildContext context){
    return Container(
        margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 30),
        height: 400,
        width: 400,
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
              color: Colors.grey.withOpacity(1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),

        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Column(

            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(this.Company.toUpperCase(),style: GoogleFonts.bebasNeue(color: Colors.black,fontSize: 25)),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(this.Company.toUpperCase(),style: GoogleFonts.bebasNeue(color: Colors.black,fontSize: 25)),

                    ],
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: 2,
                    itemBuilder: (context,index){
                      if(index == 0){
                        return Container(
                          child: Column(
                            children: [
                              Stack(
                                overflow: Overflow.clip,
                                children: [
                                  Container(
                                    width: 400,
                                    height: 300,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey,)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 400,
                                    height: 280,
                                    child: ClipRRect(
                                      child: Image.network(this.mediaUrl),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(this.Size.toString(), style: TextStyle(color: Colors.grey[700], fontSize: 22)),
                                  Text("\$ " + this.Price.toString(), style: GoogleFonts.ruda(color: Colors.deepPurple, fontSize: 22)),

                                ],
                              ),

                            ],
                          ),
                        );
                      }
                      return buildSecondPage_Unfiltered();
                    }

                )
              ),
            ],
          ),
        )
    );
  }
}

