import 'dart:math';
import 'dart:ui';
import 'package:virtual_size_app/services/databaseServices.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:google_fonts/google_fonts.dart';

class Product{
  final String Company;
  final dynamic Price;
  final Map<String,dynamic> measureData;
  final String mediaUrl;
  //Constructor
  Product({
    this.Company,
    this.Price,
    this.measureData,
    this.mediaUrl
  });


}

class TshirtProduct extends Product{

  final String Size;

  TshirtProduct({
    String Company,
    dynamic Price,
    Map<String,dynamic> measureData,
    String mediaUrl,
    this.Size
  })
  : super(Company: Company, Price: Price, measureData: measureData, mediaUrl: mediaUrl);

  factory TshirtProduct.fromDoc(DocumentSnapshot doc){
    var company = doc.get("Company");
    var price = doc.get("Price");
    Map<String, dynamic> measures = doc.get("measureData");
    var mediaUrl = doc.get("mediaUrl");
    var size = doc.get("Size");

    //print(company.toString() + price.toString() + measures.toString() + mediaUrl.toString());
    return TshirtProduct(
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

  onPressShowDialog(BuildContext context){
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
                      BoxShadow(color: Colors.black,offset: Offset(0,10),
                          blurRadius: 10
                      ),
                    ]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Text("test",style: TextStyle(color:Colors.black,fontSize: 22,fontWeight: FontWeight.w600),),
                    SizedBox(height: 15,),
                    Text("xxxxxxxxx",style: TextStyle(color:Colors.black,fontSize: 14),textAlign: TextAlign.center,),
                    SizedBox(height: 22,),

                  ],
                ),
              ),
            ),
          );
    }
    );
  }

  Future<List<Color>> getColors()async{
    
  }

  Widget DetailedButton({BuildContext context, String name, Color color}){
    return GestureDetector(
      onTap: (){
        onPressShowDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 2),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),

        width: 90,
        height: 41,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(name.substring(0,2), style: GoogleFonts.ptSans(color: Colors.black,fontSize: 13),),
            Icon(
              Icons.info,
              size: 20,
            ),
          ]
          ,)
      ),
    );
  }

  Widget ReturnTshirtProductWidget(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
      height: 570,
      width: MediaQuery.of(context).size.width-10,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
            Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[700].withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(this.Company.toUpperCase(),style: GoogleFonts.bebasNeue(color: Colors.black,fontSize: 25)),

              ],
            ),
            ClipRRect(
              child: Image.network(this.mediaUrl),
              borderRadius: BorderRadius.all(
                  Radius.circular(10)
              ),
            ),
            SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailedButton(context:context, name: "Neck", color: Colors.red),
                DetailedButton(context:context, name: "Chest", color: Colors.lightGreen),
                DetailedButton(context:context, name: "Shoulder", color: Colors.red),

              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailedButton(context:context, name: "Biceps", color: Colors.red),
                DetailedButton(context:context, name: "Sleeve", color: Colors.red),
                DetailedButton(context:context, name: "Waist", color: Colors.red),

              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailedButton(context:context, name: "Length", color: Colors.red),

                DetailedButton(context:context, name: "Length", color: Colors.grey),
                DetailedButton(context:context, name: "Length", color: Colors.grey),

              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       width: 160,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Neck", style: TextStyle(color: Colors.black),),
            //           Container(
            //               width: 100,
            //               height: 20,
            //               color: Colors.lightGreen,
            //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Perfect Fit"),],)
            //           ),
            //
            //         ],
            //       ),
            //     ),
            //     Container(
            //       width: 160,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Length", style: TextStyle(color: Colors.black),),
            //           Container(
            //               width: 100,
            //               height: 20,
            //               color: Colors.lightGreen,
            //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Perfect Fit"),],)
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 1,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       width: 160,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Shoulder", style: TextStyle(color: Colors.black),),
            //           Container(
            //               width: 100,
            //               height: 20,
            //               color: Colors.lightGreen,
            //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Perfect Fit"),],)
            //           )
            //         ],
            //       ),
            //     ),
            //     Container(
            //       width: 160,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Chest", style: TextStyle(color: Colors.black),),
            //           Container(
            //               width: 100,
            //               height: 20,
            //               color: Colors.lightGreen,
            //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Perfect Fit"),],)
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 1,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       width: 160,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Biceps", style: TextStyle(color: Colors.black),),
            //           Container(
            //               width: 100,
            //               height: 20,
            //               color: Colors.lightGreen,
            //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Perfect Fit"),],)
            //           )
            //         ],
            //       ),
            //     ),
            //     Container(
            //       width: 160,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Sleeve", style: TextStyle(color: Colors.black),),
            //           Container(
            //               width: 100,
            //               height: 20,
            //               color: Colors.lightGreen,
            //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Perfect Fit"),],)
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 1,),
            // Row(
            //   children: [
            //     Container(
            //       width: 160,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Waist", style: TextStyle(color: Colors.black),),
            //           Container(
            //               width: 100,
            //               height: 20,
            //               color: Colors.lightGreen,
            //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Perfect Fit"),],)
            //           )
            //         ],
            //       ),
            //     ),
            //     Container(
            //       width: 160,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Waist", style: TextStyle(color: Colors.white),),
            //           Container(
            //               width: 100,
            //               height: 20,
            //               color: Colors.white,
            //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Perfect Fit"),],)
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // )
            FlatButton(
              color: Colors.deepOrangeAccent,
              child: Text("ADD TO CART"),
              onPressed: (){},
            ),
          ],
        ),
      )
    );
  }
}

