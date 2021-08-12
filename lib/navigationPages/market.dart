import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:virtual_size_app/custom_icon_icons.dart';
import 'package:virtual_size_app/models/FilterIcon.dart';
import 'package:virtual_size_app/models/product.dart';
import "package:virtual_size_app/services/databaseServices.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:google_fonts/google_fonts.dart';

import "package:virtual_size_app/services/filterProducts.dart";



class Market extends StatefulWidget {

  @override
  _MarketState createState() => new _MarketState();
}

class _MarketState extends State<Market> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Future<DocumentSnapshot> snap;

  //About Dropdown menu
  List<bool> isSelected = List.generate(6, (index) => false);
  List<String> QRcodes = ['SELECT QR CODE'];
  List<DocumentSnapshot> QRcodesDocuments= [];
  String dropdownValue;
  int selectedQRcode_index;


  //about filter
  int selectedIconIndex;

  static const header_height = 32.0;


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

  Future<DocumentSnapshot> getDoc()async {
    snap = ProductsRef.doc("tshirt").collection("TshirtProducts").doc("tshirt_11").get();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
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
            onPressed: dropdownValue=="SELECT QR CODE" ? null :
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
            selectedColor: Colors.amber,
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
                      child: Text(value, style: GoogleFonts.titilliumWeb(fontSize: 20, color: value == 'SELECT QR CODE' ? Colors.deepOrangeAccent : Colors.orangeAccent),),
                    );
                  }).toList(),
                )
              ],
            );
          },
        );

  }
  Widget buildSubmitFilterButton(){
    return OutlinedButton(
      onPressed: () async{
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
          getTshirts(
            chest: myMatches["chest"],
            shoulder: myMatches["shoulder"],
            waist: myMatches["waist"],
            neck: myMatches["neck"],
            biceps: myMatches["biceps"],
            length: myMatches["length"],
          );
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
        backgroundColor: selectedIconIndex==null? Colors.grey: Colors.lightGreen[400],
      ),
    );
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "FILTER",
              style: GoogleFonts.staatliches(fontSize: 30, color: Colors.grey),
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
                      buildToggleButtons(),
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
                  elevation: 12.0,
                  borderRadius: new BorderRadius.only(
                      topLeft: new Radius.circular(16.0),
                      topRight: new Radius.circular(16.0)),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: 5,
                        color: Colors.grey[800],

                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            FutureBuilder(
                              future: snap,
                              builder: (context,snapshot){
                                if(snapshot.hasData){
                                  TshirtProduct t1 = TshirtProduct.fromDoc(snapshot.data);
                                  //print(t1.Company + t1.Price.toString() + t1.mediaUrl + t1.measureData.toString());
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
                      )
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
    getDoc();
    controller = new AnimationController(vsync: this, duration: new Duration(milliseconds: 100), value: 1.0);


    dropdownValue = QRcodes[0];
    getQRcodes();
  }

  @override
  Widget build(BuildContext context) {
    //print(isPanelVisible);
    return new LayoutBuilder(
      builder: bothPanels,
    );
  }
}

