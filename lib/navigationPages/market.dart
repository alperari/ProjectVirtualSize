import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:virtual_size_app/custom_icon_icons.dart';
import 'package:virtual_size_app/models/product.dart';
import "package:virtual_size_app/services/databaseServices.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {

  double filterBarHeight = 0;
  bool filterBarOpen = false;
  Icon filterBarIcon = Icon(Icons.arrow_drop_down_rounded, size: 40,);

  Color colorHat = Colors.white;
  Color colorTshirt = Colors.white;
  Color colorPants = Colors.white;
  Color colorNecklace = Colors.white;

  bool selectedHat = false;
  bool selectedTshirt = false;
  bool selectedPants = false;
  bool selectedNecklace = false;

  Future<DocumentSnapshot> snap;


  String dropdownvalue = 'Apple';
  List<String> dropdownItems = [];
  



  Future<DocumentSnapshot> getDoc()async {
    snap = ProductsRef.doc("tshirt").collection("TshirtProducts").doc("tshirt_11").get();
  }

  Future<void> getDropdownItems()async{
    QuerySnapshot snapshot = await QRsRef.doc(auth.uid).collection("my_QRs").get();
    for(var doc in snapshot.docs){
      dropdownItems.add(doc.get("name"));
    }
  }

  void changeFilterBar(){
    setState(() {
      if(!filterBarOpen){
        filterBarHeight = 150;
        filterBarIcon = Icon(Icons.arrow_drop_up_rounded, size: 40,);
        filterBarOpen = true;
      }
      else{
        filterBarHeight = 0;
        filterBarIcon = Icon(Icons.arrow_drop_down_rounded, size: 40,);
        filterBarOpen = false;
      }
    });
  }

  Widget buildFilterIconButton(IconData myiconData, String itemName){
    bool selectedItem;
    if(itemName == "Hat") selectedItem = selectedHat;
    else if(itemName == "Tshirt") selectedItem = selectedTshirt;
    else if(itemName == "Pants") selectedItem = selectedPants;
    else if(itemName == "Necklace") selectedItem = selectedNecklace;

    return GestureDetector(
      child: Container(
        child: Icon(myiconData, color: selectedItem  ? Colors.black : Colors.white),
        width: 40,
        height: 40,
        decoration: new BoxDecoration(
          color: selectedItem ? Colors.white : Colors.grey[800],
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 1, color: Colors.white),
        ),
      ),
      onTap: (){
        setState(() {
          if(itemName == "Hat") selectedHat = !selectedHat;
          else if(itemName == "Tshirt") selectedTshirt = !selectedTshirt;
          else if(itemName == "Pants") selectedPants = !selectedPants;
          else if(itemName == "Necklace") selectedNecklace = !selectedNecklace;
        });
      },
    );
  }

  Widget buildFilterBar(){
    return Column(
      children: [
        GestureDetector(
          child: Container(
            height: 30,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text("FILTER PRODUCTS"),
                ),
                Expanded(
                  flex: 1,
                  child: filterBarIcon
                ),
              ],
            ),
          ),
          onTap: (){
            changeFilterBar();
          },
        ),
        AnimatedContainer(
          height: filterBarHeight,
          duration: Duration(milliseconds: 250),
          child: filterBarHeight == 150 ? buildFilterContent() : Text(""),
        ),
        Divider(thickness: 1, color: Colors.white,)
      ],
    );
  }

  Widget buildFilterContent(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 50,),
            buildFilterIconButton(CustomIcon.hat, "Hat"),
            buildFilterIconButton(CustomIcon.t_shirt_1, "Tshirt"),
            buildFilterIconButton(CustomIcon.black__1_, "Pants"),
            buildFilterIconButton(CustomIcon.necklace, "Necklace"),
            SizedBox(width: 50,),
          ],

        ),
        DropdownButton(
          value: dropdownvalue,
          icon: Icon(Icons.keyboard_arrow_down),
          items:dropdownItems.map((String items) {
            return DropdownMenuItem(
                value: items,
                child: Text(items)
            );
          }
          ).toList(),
          onChanged: (String newValue){
            setState(() {
              dropdownvalue = newValue;
            });
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          child: Text("FILTER",style: TextStyle(color: Colors.white),),
          onPressed: (){
            print("filtered");
          },
        ),

      ],
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
          buildFilterBar(),

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
