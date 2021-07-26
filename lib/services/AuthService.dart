import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtual_size_app/services/databaseServices.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(User user) {
    return user != null ? user : null;
  }

  //Auth Stream
  Stream<User> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }



// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  Future<void> CreateUserInFirestore(String uid, String email, String fullname)async{
    await usersRef.doc(uid).set({
      "userID" : uid,
      "email" : email,
      "fullname" : fullname,
    });

    await cartsRef.doc(uid).set({});
  }



// register with email and password
  Future registerWithEmailAndPassword(String email, String password, String fullname) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //Add user to firestore
      await CreateUserInFirestore(_auth.currentUser.uid, email, fullname);


      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
