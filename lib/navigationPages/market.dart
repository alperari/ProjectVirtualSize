import "package:flutter/material.dart";
import 'package:virtual_size_app/models/product.dart';
import "package:virtual_size_app/services/databaseServices.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {


  Future<DocumentSnapshot> snap;

  Future<DocumentSnapshot> getDoc()async {
    snap = ProductsRef.doc("tshirt").collection("TshirtProducts").doc("tshirt_11").get();
  }

@override
  void initState() {
    // TODO: implement initState
    getDoc();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: snap,
      builder: (context,snapshot){
        if(snapshot.hasData){
          TshirtProduct t1 = TshirtProduct.fromDoc(snapshot.data);
          print(t1.Company + t1.Price.toString() + t1.mediaUrl + t1.measureData.toString());
          return Center(
            child: Text("YEAH"),
          );
        }
        else
          print("no data");
          return Center(
            child: Text("NOPE"),
          );
      },
    );
  }
}
