import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:virtual_size_app/custom_icon_icons.dart';
import 'package:virtual_size_app/models/FilterIcon.dart';
import 'package:virtual_size_app/models/product.dart';
import "package:virtual_size_app/services/databaseServices.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {

  Future<DocumentSnapshot> snap;
  List<bool> isSelected = List.generate(6, (index) => false);



  Future<DocumentSnapshot> getDoc()async {
    snap = ProductsRef.doc("tshirt").collection("TshirtProducts").doc("tshirt_11").get();
  }

  Widget buildToggleButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        ToggleButtons(
          children: [
            FilterIcon(
              icon: const Icon(CustomIcon.hat,size: 28,),
              isSelected: isSelected[0],
              bgColor: const Color(0xfff44336),
            ),
            FilterIcon(
              icon: const Icon(CustomIcon.t_shirt_1,size: 28,),
              isSelected: isSelected[1],
              bgColor: const Color(0xffE91E63),
            ),
            FilterIcon(
              icon: const Icon(CustomIcon.black__1_,size: 28,),
              isSelected: isSelected[2],
              bgColor: const Color(0xff9C27B0),
            ),
            FilterIcon(
              icon: const Icon(CustomIcon.necklace,size: 28,),
              isSelected: isSelected[3],
              bgColor: const Color(0xff673AB7),
            ),
            FilterIcon(
              icon: const Icon(Icons.add),
              isSelected: isSelected[4],
              bgColor: const Color(0xff3F51B5),
            ),
            FilterIcon(
              icon: const Icon(Icons.add),
              isSelected: isSelected[5],
              bgColor: const Color(0xff2196F3),
            ),
          ],
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = !isSelected[buttonIndex];
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
          },
          isSelected: isSelected,
          selectedColor: Colors.amber,
          renderBorder: false,
          fillColor: Colors.transparent,
        ),
      ]
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getDoc();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          buildToggleButtons(),
          FutureBuilder(
          future: snap,
          builder: (context,snapshot){
            if(snapshot.hasData){
              TshirtProduct t1 = TshirtProduct.fromDoc(snapshot.data);
              print(t1.Company + t1.Price.toString() + t1.mediaUrl + t1.measureData.toString());
              return Center(
                child: t1.ReturnTshirtProductWidget(context),
              );
            }
            else
              print("no data");
            return Center(
              child: Text("NOPE"),
            );
          },
        )
        ],
      ),
    );
  }
}

