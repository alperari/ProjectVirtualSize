import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final usersRef = FirebaseFirestore.instance.collection("users");
final cartsRef = FirebaseFirestore.instance.collection("carts");
final QRsRef = FirebaseFirestore.instance.collection("QRs");
final ProductsRef = FirebaseFirestore.instance.collection("Products");
final virtualSizesRef = FirebaseFirestore.instance.collection("VirtualSizes");
final product_VirtualSize_Matches = FirebaseFirestore.instance.collection("Product_VirtualSize_Matches");
final auth = FirebaseAuth.instance.currentUser;
final storageRef = FirebaseStorage.instance.ref();

