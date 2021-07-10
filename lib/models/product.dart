import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class Product{
  final String Company;
  final dynamic Price;
  final Map<String,dynamic> measureData;
  final String mediaUrl;
  //Constructor
  Product({
    @required this.Company,
    @required this.Price,
    @required this.measureData,
    @required this.mediaUrl
  });


}

class TshirtProduct extends Product{

  final String Size;

  TshirtProduct({
    @required String Company,
    @required dynamic Price,
    @required Map<String,dynamic> measureData,
    @required String mediaUrl,
    @required this.Size
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
}