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

    print(company.toString() + price.toString() + measures.toString() + mediaUrl.toString());
    return TshirtProduct(
      Company: company,
      Price: price,
      measureData: measures,
      mediaUrl: mediaUrl,
    );
  }


  Widget ReturnTshirtProductWidget(BuildContext context){


    return Container(
      margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
      height: 600,
      width: MediaQuery.of(context).size.width-10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
            Radius.circular(10)
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

      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(

          children: [
            Text(this.Company.toUpperCase(),style: GoogleFonts.bebasNeue(color: Colors.black,fontSize: 25)),
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                        ),
                    ],
                  ),

                  width: 100,
                  height: 40,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1)),
                            color: Colors.white,
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Neck", style: GoogleFonts.ptSans(color: Colors.black,fontSize: 17),),],)
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 50,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    color: Colors.blue,
                    width: 100,
                    height: 30,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Shoulder"),],)
                ),
                Container(
                    color: Colors.green,
                    width: 100,
                    height: 30,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Chest"),],)
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    color: Colors.red,
                    width: 100,
                    height: 30,
                    child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [Text("Biceps"),],)
                ),
                Container(
                    color: Colors.blue,
                    width: 100,
                    height: 30,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Sleeve"),],)
                ),
                Container(
                    color: Colors.green,
                    width: 100,
                    height: 30,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Length"),],)
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    color: Colors.red,
                    width: 100,
                    height: 30,
                    child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [Text("Waist"),],)
                ),
                Container(
                    color: Colors.white,
                    width: 100,
                    height: 30,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Neck"),],)
                ),
                Container(
                    color: Colors.white,
                    width: 100,
                    height: 30,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Neck"),],)
                ),
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
          ],
        ),
      )
    );
  }
}

