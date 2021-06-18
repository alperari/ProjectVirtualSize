import "package:cloud_firestore/cloud_firestore.dart";

final usersRef = FirebaseFirestore.instance.collection("users");

Future<void> CreateUserInFirestore(String uid, String email, String fullname)async{
  usersRef.doc(uid).set({
    "userID" : uid,
    "email" : email,
    "fullname" : fullname,
    "QRcodes" : <dynamic>[]
  });
}