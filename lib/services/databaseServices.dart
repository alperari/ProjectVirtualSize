import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final usersRef = FirebaseFirestore.instance.collection("users");
final QRsRef = FirebaseFirestore.instance.collection("QRs");
final auth = FirebaseAuth.instance.currentUser;
final storageRef = FirebaseStorage.instance.ref();

Future<void> CreateUserInFirestore(String uid, String email, String fullname)async{
  usersRef.doc(uid).set({
    "userID" : uid,
    "email" : email,
    "fullname" : fullname,
  });
}




Future<void> createQR_FireStore({String userID, dynamic QR_id}) async{
  await usersRef.doc(userID).update({
    "QRcodes" : FieldValue.arrayUnion([QR_id])
  });

}