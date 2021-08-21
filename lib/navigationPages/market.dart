import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:virtual_size_app/custom_icon_icons.dart';
import 'package:virtual_size_app/models/FilterIcon.dart';
import 'package:virtual_size_app/models/product.dart';
import "package:virtual_size_app/services/databaseServices.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:google_fonts/google_fonts.dart';

import "package:virtual_size_app/services/filterProducts.dart";
import "package:virtual_size_app/models/QRcodeTile.dart";


class Market extends StatefulWidget {

  @override
  _MarketState createState() => new _MarketState();
}

class _MarketState extends State<Market> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Future<QuerySnapshot> snap;

  //About Dropdown menu
  List<bool> isSelected = List.generate(6, (index) => false);
  List<String> QRcodes = ['SELECT QR CODE'];
  List<DocumentSnapshot> QRcodesDocuments= [];
  String dropdownValue;
  int selectedQRcode_index;


  //about filter
  int selectedIconIndex;

  static const header_height = 32.0;

  bool isFiltered = false;
  Map<String,List<String>> my_matched_tshirts_asMap = {};
  List<SortItem> my_matched_tshirts_asList = [];
  bool loading_filter_results = false;


  Future<void> getQRcodes()async{
    final snapshot = await QRsRef.doc(auth.uid).collection("my_QRs").get();
    //print(QRcodes);
    //print(QRcodesDocuments);
    for(var doc in snapshot.docs){
     if(!QRcodes.contains(doc.get("name")))
       QRcodes.add(doc.get("name"));

     if(!QRcodesDocuments.contains(doc))
       QRcodesDocuments.add(doc);
    }



  }

  Future<DocumentSnapshot> getProducts()async {
    snap = ProductsRef.doc("tshirt").collection("TshirtProducts").get();

  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }


  Future<Map<String,int>> getIconColors(DocumentSnapshot doc)async{
    // 35-48 neck
    // 80-180 shoulder
    // 60-180 chest
    // 20-55 biceps
    // 45-100 Tlength
    // 50-200 waist
    Map<String,int> icons = {"Hat": 0, "Tshirt": 0 , "Pants": 0, "Necklace": 0};


    var neck = doc.get("measureData")["neck"]??0;
    var shoulder = doc.get("measureData")["shoulder"] ?? 0;
    var chest = doc.get("measureData")["chest"] ?? 0;
    var biceps = doc.get("measureData")["biceps"] ?? 0;
    var Tlength = doc.get("measureData")["length"] ?? 0;
    var waist = doc.get("measureData")["waist"] ?? 0;
    var hip = doc.get("measureData")["hip"] ?? 0;
    var inLeg = doc.get("measureData")["inLeg"] ?? 0;
    var outLeg = doc.get("measureData")["outLeg"] ?? 0;


    //For tshirt
    if(    (30<=neck && neck<=87) &&
        (21<=shoulder && shoulder<=72) &&
        (55<=chest && chest<=155) &&
        (12<=biceps && biceps<=63) &&
        (45<=Tlength && Tlength<=110) &&
        (55<=waist && waist<=161)) {
      icons["Tshirt"] = 1;
    }
    ///TODO continue adding 4 icon constraints
    return icons;
  }

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = MediaQuery.of(context).size.height/4;
    final frontPanelHeight = -header_height;

    return new RelativeRectTween(
        begin: new RelativeRect.fromLTRB(
            0.0, backPanelHeight, 0.0, frontPanelHeight),
        end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(new CurvedAnimation(
        parent: controller, curve: Curves.bounceInOut));
  }


  Widget buildToggleButtons(context, Map<String,int> data, bool enabled){

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ToggleButtons(

            children: [
              FilterIcon(
                icon: const Icon(CustomIcon.hat ,size: 28, ),
                isSelected: isSelected[0],
                bgColor: data["Hat"] == 1 ? Colors.deepPurple[400] : Colors.grey,
              ),
              FilterIcon(
                icon: const Icon(CustomIcon.t_shirt_1,size: 28,),
                isSelected: isSelected[1],
                bgColor: data["Tshirt"] == 1 ? Colors.deepPurple[400] : Colors.grey,
              ),
              FilterIcon(
                icon: const Icon(CustomIcon.black__1_,size: 28,),
                isSelected: isSelected[2],
                bgColor: data["Pants"] == 1 ? Colors.deepPurple[400] : Colors.grey,
              ),
              FilterIcon(
                icon: const Icon(CustomIcon.necklace,size: 28,),
                isSelected: isSelected[3],
                bgColor: data["Necklace"] == 1 ? Colors.deepPurple[400] : Colors.grey,
              ),
              FilterIcon(
                icon: const Icon(Icons.add),
                isSelected: isSelected[4],
                bgColor: Colors.grey,
              ),
              FilterIcon(
                icon: const Icon(Icons.add),
                isSelected: isSelected[5],
                bgColor: Colors.grey,
              ),
            ],
            onPressed: dropdownValue=="SELECT QR CODE" || enabled == false? null :
                (int index) {

              setState(() {
                for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = !isSelected[buttonIndex];
                    if( isSelected[buttonIndex] == true){
                      selectedIconIndex = index;
                    }
                    else{
                      selectedIconIndex = null;

                    }
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }

              });
            },
            isSelected: isSelected,
            selectedColor: Colors.purple[100],
            renderBorder: false,
            fillColor: Colors.transparent,
          ),
        ]
    );

  }
  Widget buildDropdownMenu(){
    return
        FutureBuilder(
          future: getQRcodes(),
          builder: (context,snapshot){
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code,size: 35,),
                SizedBox(width: 8,),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      print(QRcodes.indexOf(dropdownValue));
                      selectedQRcode_index = QRcodes.indexOf(dropdownValue);
                    });
                  },
                  items: QRcodes
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.titilliumWeb(fontSize: 20, color: value == 'SELECT QR CODE' ? Colors.grey[700] : Colors.black),),
                    );
                  }).toList(),
                )
              ],
            );
          },
        );

  }
  Widget buildSubmitFilterButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: (){
              //reset filter
              setState(() {
                isFiltered = false;
                loading_filter_results = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'RESET',
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        OutlinedButton(
          onPressed: () async{

            setState(() {
              loading_filter_results=true;
            });

            if(selectedIconIndex == 1 && dropdownValue != "SELECT QR CODE"){
              Map<String,dynamic> QRdata = QRcodesDocuments[selectedQRcode_index-1].get("measureData");
              dynamic chest = QRdata["chest"];
              dynamic shoulder = QRdata["shoulder"];
              dynamic waist = QRdata["waist"];
              dynamic neck = QRdata["neck"];
              dynamic biceps = QRdata["biceps"];
              dynamic length = QRdata["length"];
              dynamic sleeve = QRdata["sleeve"];

              Map<String,String> myMatches = await getHumanVirtualSizes(
                chest: chest,
                shoulder: shoulder,
                waist: waist,
                neck: neck,
                biceps: biceps,
                length: length,
              );

              print("MY VIRTUAL SIZE:");
              myMatches.forEach((key, value) {
                print(key +" " +  value);
              });

              print("");
              print("TSHIRTS I CAN WEAR:");

              Map matches = await getTshirts(
                chest: myMatches["chest"],
                shoulder: myMatches["shoulder"],
                waist: myMatches["waist"],
                neck: myMatches["neck"],
                biceps: myMatches["biceps"],
                length: myMatches["length"],
              );

              setState(() {
                my_matched_tshirts_asMap = matches["asMap"];
                my_matched_tshirts_asList = matches["asList"];
                isFiltered = true;
                loading_filter_results= false;
              });
            }



          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'SUBMIT',
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: selectedIconIndex==null? Colors.grey: Colors.deepPurple[400],
          ),
        ),
      ],
    );
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              children: [
                Text(
                  "FILTER",
                  style: GoogleFonts.staatliches(fontSize: 30, color: Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    controller.fling(velocity: isPanelVisible ? -1 : 1);
                  },
                  icon: new AnimatedIcon(
                    icon: AnimatedIcons.arrow_menu,
                    progress: controller.view,
                  ),
                ),
              ],
            ),
          ],
        ),
        new Container(
          height: 5,
          color: Colors.grey[800],

        ),
        new Container(
        height: constraints.biggest.height-32-5-16,
          width: constraints.maxWidth,
          child: new Stack(
            children: <Widget>[

              new Container(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildDropdownMenu(),

                      (selectedQRcode_index != null && selectedQRcode_index != 0) ?
                        FutureBuilder(
                          future: getIconColors(QRcodesDocuments[selectedQRcode_index-1]),
                          builder: (context,snapshot){
                            if(snapshot.hasData){
                              return buildToggleButtons(context, snapshot.data, true);
                            }else{
                              return buildToggleButtons(context, {}, false);
                            }
                          },
                        )
                          :
                      buildToggleButtons(context, {}, false),

                      buildSubmitFilterButton()
                    ],
                  ),
                  height: MediaQuery.of(context).size.height/4,
                  width: constraints.maxWidth,

                ),
              ),
              new PositionedTransition(
                rect: getPanelAnimation(constraints),
                child: new Material(
                  color: Colors.grey[300],
                  elevation: 12.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: 5,
                        color: Colors.grey[800],

                      ),
                      Container(
                        child: FutureBuilder(
                          future: snap,
                          builder: (context,snapshot){


                            if(snapshot.hasData){
                              Map<String,DocumentSnapshot> collectionMap = {};
                              for(DocumentSnapshot doc in snapshot.data.docs){
                                collectionMap[doc.id] = doc;
                              }

                              List<Widget> ProductsList = [];


                              if(loading_filter_results){
                                return Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              else{
                                //FILTER OFF
                                if(isFiltered == false){
                                  ProductsList.clear();

                                  ProductsList = snapshot.data.docs.map<Widget>((DocumentSnapshot doc){
                                    TshirtProduct tshirt = TshirtProduct.fromDoc(doc);
                                    return tshirt.ReturnTshirtProductWidget_UnFiltered(context);
                                  }).toList();
                                }

                                //FILTER ON
                                else{
                                  ProductsList.clear();
                                  my_matched_tshirts_asList.sort((a, b) => b.total.compareTo(a.total));


                                  print("----");
                                  print("after sort");
                                  for(SortItem element in my_matched_tshirts_asList){
                                    print(element.name + " ----  "+ element.total.toString() + "   " + element.matches.toString());
                                  }


                                  QuerySnapshot querySnapshot = snapshot.data;


                                  for(SortItem tshirtItem in my_matched_tshirts_asList){
                                    double Rate = (tshirtItem.total/4218)*100;
                                    List<String> matchData = tshirtItem.matches;
                                    TshirtProduct tshirt = TshirtProduct.fromDoc(collectionMap[tshirtItem.name]);
                                    ProductsList.add( tshirt.ReturnTshirtProductWidget_Filtered(context, matchData, Rate) );

                                  }

                                  // snapshot.data.docs.forEach((DocumentSnapshot doc) {   //if any document that exists in our matched tshirts list, add it to ProductsList
                                  //   if(my_matched_tshirts_asMap.keys.contains(doc.id)){
                                  //
                                  //     List<String> matchData = my_matched_tshirts_asMap[doc.id];
                                  //
                                  //     TshirtProduct tshirt = TshirtProduct.fromDoc(doc);
                                  //
                                  //     ProductsList.add( tshirt.ReturnTshirtProductWidget_Filtered(context, matchData) );
                                  //
                                  //   }
                                  // });

                                  //now sort ProductsList
                                }
                              }


                              return  Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: ProductsList
                                ),
                              );
                            }
                            else{
                              return Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
    controller = new AnimationController(vsync: this, duration: new Duration(milliseconds: 100), value: 1.0);

    dropdownValue = QRcodes[0];
    getQRcodes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new LayoutBuilder(
        builder: bothPanels,
      ),
    );
  }
}

