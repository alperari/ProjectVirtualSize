import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import "package:virtual_size_app/services/databaseServices.dart";


Future<List<String>> getVirtualSize_Biceps(double bicepsValue, String matchName)async{
  List<String>  correspondingDocs = [];
  QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Biceps").get();


  for(DocumentSnapshot doc in snapshot.docs){
    if(doc.get(matchName)[0] <= bicepsValue && doc.get(matchName)[1] >= bicepsValue ){
      //this is the document that matches matchName interval.
      correspondingDocs.add(doc.id);
    }
  }
  return correspondingDocs;
}


Future<List<String>> getVirtualSize_Chest(double chestValue, String matchName)async{

  List<String>  correspondingDocs = [];
  QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Chest").get();


  for(DocumentSnapshot doc in snapshot.docs){
    if(doc.get(matchName)[0] <= chestValue && doc.get(matchName)[1] >= chestValue ){
      correspondingDocs.add(doc.id);

    }
  }
  return correspondingDocs;
}


Future<List<String>> getVirtualSize_Shoulder(double shoulderValue, String matchName)async{

  List<String>  correspondingDocs = [];
  QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Shoulder").get();


  for(DocumentSnapshot doc in snapshot.docs){
    if(doc.get(matchName)[0] <= shoulderValue && doc.get(matchName)[1] >= shoulderValue ){
      correspondingDocs.add(doc.id);

    }
  }
  return correspondingDocs;
}


Future<List<String>> getVirtualSize_Length(double lengthValue, String matchName)async{

  List<String>  correspondingDocs = [];
  QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Length").get();


  for(DocumentSnapshot doc in snapshot.docs){
    if(doc.get(matchName)[0] <= lengthValue && doc.get(matchName)[1] >= lengthValue ){
      correspondingDocs.add(doc.id);

    }
  }
  return correspondingDocs;
}


Future<List<String>> getVirtualSize_Neck(double neckValue, String matchName)async{    ///NECK NM HAS DIFFERENT RULES

  List<String>  correspondingDocs = [];
  QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Neck").get();

  for(DocumentSnapshot doc in snapshot.docs){
    if(doc.get(matchName)[0] <= neckValue && doc.get(matchName)[1] >= neckValue ){
      correspondingDocs.add(doc.id);

    }
  }
  return correspondingDocs;
}


Future<List<String>> getVirtualSize_Waist(double waistValue, String matchName)async{

  List<String>  correspondingDocs = [];
  QuerySnapshot snapshot = await virtualSizesRef.doc("Tshirt").collection("Waist").get();


  for(DocumentSnapshot doc in snapshot.docs){
    if(doc.get(matchName)[0] <= waistValue && doc.get(matchName)[1] >= waistValue ){
      correspondingDocs.add(doc.id);

    }
  }
  return correspondingDocs;
}


String neck = "N05"; //neck3
String chest = "C12";
String waist = "W10";
String length = "L04";
String biceps = "B06";
String shoulder = "S08";
double sleeve =  35;

Future<Map> getHumanVirtualSizes(
    {dynamic neck,
    dynamic chest,
    dynamic waist,
    dynamic length,
    dynamic biceps,
    dynamic shoulder})async{

  Map<String,String> matches = {};

  var neckSizes = await virtualSizesRef.doc("Tshirt").collection("Neck").get();
  var chestSizes = await virtualSizesRef.doc("Tshirt").collection("Chest").get();
  var waistSizes = await virtualSizesRef.doc("Tshirt").collection("Waist").get();
  var lengthSizes = await virtualSizesRef.doc("Tshirt").collection("Length").get();
  var bicepsSizes = await virtualSizesRef.doc("Tshirt").collection("Biceps").get();
  var shoulderSizes = await virtualSizesRef.doc("Tshirt").collection("Shoulder").get();

  for(var doc in neckSizes.docs){
    if(doc.get("FM")[0]<=neck && neck<=doc.get("FM")[1]){
      matches["neck"] = doc.id;
      break;
    }
  }
  for(var doc in chestSizes.docs){
    if(doc.get("FM")[0]<=chest && chest<=doc.get("FM")[1]){
      matches["chest"] = doc.id;
      break;
    }
  }for(var doc in waistSizes.docs){
    if(doc.get("FM")[0]<=waist && waist<=doc.get("FM")[1]){
      matches["waist"] = doc.id;
      break;
    }
  }for(var doc in lengthSizes.docs){
    if(doc.get("H")[0]<=length && length<=doc.get("H")[1]){
      matches["length"] = doc.id;
      break;
    }
  }for(var doc in bicepsSizes.docs){
    if(doc.get("FM")[0]<=biceps && biceps<=doc.get("FM")[1]){
      matches["biceps"] = doc.id;
      break;
    }
  }
  for(var doc in shoulderSizes.docs){
    if(doc.get("PM")[0]<=shoulder && shoulder<=doc.get("PM")[1]){
      matches["shoulder"] = doc.id;
      break;
    }
  }


  print(matches);
  return matches;

}


Map<String,List<String>> dictionary = {};

Future<void> getTshirts()async{
  var chestTshirts = await product_VirtualSize_Matches.doc("Tshirt").collection("Chest").doc(chest).get();

  var waistTshirts = await product_VirtualSize_Matches.doc("Tshirt").collection("Waist").doc(waist).get();
  var neckTshirts = await product_VirtualSize_Matches.doc("Tshirt").collection("Neck").doc(neck).get();
  var shoulderTshirts = await product_VirtualSize_Matches.doc("Tshirt").collection("Shoulder").doc(shoulder).get();
  var bicepsTshirts = await product_VirtualSize_Matches.doc("Tshirt").collection("Biceps").doc(biceps).get();
  var lengthTshirts = await product_VirtualSize_Matches.doc("Tshirt").collection("Length").doc(length).get();


  //CHEST TSHIRTS
  var FM = chestTshirts.get("FM");
  var PM = chestTshirts.get("PM");
  var LM = chestTshirts.get("LM");
  var XLM = chestTshirts.get("XLM");

  Map<String,String> chestDict = {};

  for(String tshirt in FM){
    chestDict[tshirt] = "FM";
  }
  for(String tshirt in PM){
    chestDict[tshirt] = "PM";
  }
  for(String tshirt in LM){
    chestDict[tshirt] = "LM";
  }
  for(String tshirt in XLM){
    chestDict[tshirt] = "XLM";
  }

  print(chestDict);

  //construct matrix, get tshirt names at the first column, get corresponding CHEST, add it to second column
  for(int i=0; i<chestDict.keys.length; i++){
    String tshirtName = chestDict.keys.elementAt(i);

    List<String> virtualSizesList = [];
    virtualSizesList.add(chestDict[tshirtName]);
    dictionary[tshirtName] = virtualSizesList;
  }
  print("matrix: " + dictionary.toString());



  //WAIST TSHIRTS
  FM = waistTshirts.get("FM");
  PM = waistTshirts.get("PM");
  LM = waistTshirts.get("LM");
  XLM = waistTshirts.get("XLM");

  Map<String,String> waistDict = {};

  for(String tshirt in FM){
    waistDict[tshirt] = "FM";
  }
  for(String tshirt in PM){
    waistDict[tshirt] = "PM";
  }
  for(String tshirt in LM){
    waistDict[tshirt] = "LM";
  }
  for(String tshirt in XLM){
    waistDict[tshirt] = "XLM";
  }

  print(waistDict);


  List<String> toDelete = [];
  dictionary.forEach((tshirtName, value) {
    if(waistDict.keys.contains(tshirtName)){
      //if that tshirt in dictionary also is in waist, add corresponding WAIST VIRTUAL SIZE to the list
      dictionary[tshirtName].add(waistDict[tshirtName]);

    }
    else{
      //if its not found in waist, delete it
      //you can delete it by key
      toDelete.add(tshirtName);
    }
  }
  );
  dictionary.removeWhere((key, value) => toDelete.contains(key)); //delete some
  print("LAST: " + dictionary.toString());



  //NECK TSHIRTS
  FM = neckTshirts.get("FM");
  PM = neckTshirts.get("PM");
  LM = neckTshirts.get("LM");

  Map<String,String> neckDict = {};

  for(String tshirt in FM){
    neckDict[tshirt] = "FM";
  }
  for(String tshirt in PM){
    neckDict[tshirt] = "PM";
  }
  for(String tshirt in LM){
    neckDict[tshirt] = "LM";
  }


  print(neckDict);

  toDelete.clear();
  dictionary.forEach((tshirtName, value) async {
    if(neckDict.keys.contains(tshirtName)){
      dictionary[tshirtName].add(neckDict[tshirtName]);
    }
    else{
      toDelete.add(tshirtName);
    }
  });

  dictionary.removeWhere((key, value) => toDelete.contains(key));
  print("LAST: " + dictionary.toString());


  //SHOULDER  + BICEPS TSHIRTS
  //var SHOULDER_XUM = shoulderTshirts.get("XUM");
  var SHOULDER_UM = shoulderTshirts.get("UM");
  var SHOULDER_PM = shoulderTshirts.get("PM");
  var SHOULDER_LM = shoulderTshirts.get("LM");
  var SHOULDER_XLM = shoulderTshirts.get("XLM");


  Map<String,String> shoulderDict = {};

  // for(String tshirt in SHOULDER_XUM){
  //   shoulderDict[tshirt] = "XUM";
  // }
  for(String tshirt in SHOULDER_UM){
    shoulderDict[tshirt] = "UM";
  }
  for(String tshirt in SHOULDER_PM){
    shoulderDict[tshirt] = "PM";
  }
  for(String tshirt in SHOULDER_LM){
    shoulderDict[tshirt] = "LM";
  }
  for(String tshirt in SHOULDER_XLM){
    shoulderDict[tshirt] = "XLM";
  }

  toDelete.clear();
  for(String tshirtName in dictionary.keys){

    if(shoulderDict.keys.contains(tshirtName)){
      dictionary[tshirtName].add(shoulderDict[tshirtName]);
    }
    else{
      toDelete.add(tshirtName);
    }
  }
  dictionary.removeWhere((key, value) => toDelete.contains(key));
  print("LAST: " + dictionary.toString());



  //BICEPS TSHIRTS
  var BICEPS_FM = bicepsTshirts.get("FM");
  var BICEPS_PM = bicepsTshirts.get("PM");
  var BICEPS_LM = bicepsTshirts.get("LM");
  var BICEPS_XLM = bicepsTshirts.get("XLM");

  Map<String,String> bicepsDict = {};



  for(String tshirt in FM){
    bicepsDict[tshirt] = "FM";
  }
  for(String tshirt in PM){
    bicepsDict[tshirt] = "PM";
  }
  for(String tshirt in LM){
    bicepsDict[tshirt] = "LM";
  }
  for(String tshirt in XLM){
    bicepsDict[tshirt] = "XLM";
  }

  toDelete.clear();
  for(String tshirtName in dictionary.keys){

    if(bicepsDict.keys.contains(tshirtName)){
      dictionary[tshirtName].add(bicepsDict[tshirtName]);
    }
    else{
      toDelete.add(tshirtName);
    }
  }
  dictionary.removeWhere((key, value) => toDelete.contains(key));
  print("LAST: " + dictionary.toString());


  //NOW CHECK IF SHOULDER-BICEPS is XLM-XLM    or   XUM-FM
  toDelete.clear();
  dictionary.forEach((key, value) {
    if(value[3] == "XUM" && value[4] == "FM"){
      toDelete.add(key);
    }
    else if(value[3] == "XLM" && value[4] == "XLM"){
      toDelete.add(key);
    }
  });
  //remove those 2 cases if exists
  dictionary.removeWhere((key, value) => toDelete.contains(key));

  dictionary.forEach((key, value) {
    print(key + "   " + value.toString());
  });

  //ADD SLEEVE INFO
  for(String tshirtName in dictionary.keys){
    var doc = await ProductsRef.doc("tshirt").collection("TshirtProducts").doc(tshirtName).get();
    double TshirtSleeve = double.parse(doc.get("measureData")["sleeve"]);

    String SleeveCode;
    if(TshirtSleeve<=sleeve/2){
      SleeveCode = "SHORT SLEEVE";
    }
    else if(sleeve/2 <TshirtSleeve && TshirtSleeve<( sleeve/2+sleeve/5)){
      SleeveCode = "PERFECT SLEEVE";
    }
    else{
      SleeveCode = "LONG SLEEVE";
    }
    dictionary[tshirtName].add(SleeveCode);
  }

  print("");
  dictionary.forEach((key, value) {
    print(key + "   " + value.toString());
  });
  //
  // //LENGTH TSHIRTS
  // FM = lengthTshirts.get("FM");
  // PM = lengthTshirts.get("PM");
  // LM = lengthTshirts.get("LM");
  // XLM = lengthTshirts.get("XLM");
  //
  // Map<String,String> lengthDict = {};
  //
  // for(String tshirt in FM){
  //   lengthDict[tshirt] = "FM";
  // }
  // for(String tshirt in PM){
  //   lengthDict[tshirt] = "PM";
  // }
  // for(String tshirt in LM){
  //   lengthDict[tshirt] = "LM";
  // }
  // for(String tshirt in XLM){
  //   lengthDict[tshirt] = "XLM";
  // }
  //
  // print(lengthDict);
  //
  // toDelete.clear();
  // dictionary.forEach((tshirtName, value) {
  //   if(lengthDict.keys.contains(tshirtName)){
  //     //if that tshirt in dictionary also is in waist, add corresponding WAIST VIRTUAL SIZE to the list
  //     dictionary[tshirtName].add(lengthDict[tshirtName]);
  //
  //   }
  //   else{
  //     //if its not found in waist, delete it
  //     //you can delete it by key
  //     toDelete.add(tshirtName);
  //   }
  // }
  // );
  // dictionary.removeWhere((key, value) => toDelete.contains(key)); //delete some
  // print("LAST: " + dictionary.toString());

}
