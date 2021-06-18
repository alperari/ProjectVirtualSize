import "package:cloud_firestore/cloud_firestore.dart";

class MyUser{
  String userID;
  String email;
  String fullname;
  List<dynamic> QRcodes;
  MyUser({this.userID,this.email,this.fullname,this.QRcodes});

  factory MyUser.fromDoc(DocumentSnapshot snapshot){
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return MyUser(
      userID: data["userID"],
      fullname: data["fullname"],
      email: data["email"],
      QRcodes: data["QRcodes"],
    );
  }
}