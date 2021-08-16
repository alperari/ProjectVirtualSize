import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'file:///D:/AndoidStudio_apps/virtual_size_app/lib/services/AuthService.dart';
import "package:virtual_size_app/Auth/authenticate.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:provider/provider.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: MyApp(),
      theme: ThemeData(
        // Define the default brightness and colors.
        primaryColor: Colors.deepPurple[800],
        accentColor: Colors.deepPurpleAccent,
        // Define the default font family.
        fontFamily: 'Arial',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
    )
  );
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext, AsyncSnapshot snapshot){
        if(snapshot.hasError){
          print(snapshot.error);
          return Scaffold(
            body: Center(
              child:
                  Text("Error with connecting Firebase!"),
              ),

          );
        }
        else if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text("CONNECTING FIREBASE..."),
          );
        }
        else if(snapshot.connectionState == ConnectionState.done){
          print('Firebase connected');
          return StreamProvider<User>.value(
            value: AuthService().user,
            child: Authenticate(),

          );

        }
      },
    );
  }
}
