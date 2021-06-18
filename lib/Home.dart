import 'package:flutter/material.dart';
import 'package:virtual_size_app/models/user.dart';
import "package:provider/provider.dart";
import 'package:virtual_size_app/services/AuthService.dart';
import 'package:virtual_size_app/services/databaseServices.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Widget> getQRs(){
    final myuser = Provider.of<MyUser>(context);
    List<Widget> QRs = [];

    if(myuser != null){
      myuser.QRcodes.forEach((element) {
        Card currentTile = Card(
          elevation: 1,
          child: ListTile(
            tileColor: Colors.grey[800],
            title: Text(element),
            trailing: Icon(Icons.delete, color: Colors.redAccent,),
          )
        );
        QRs.add(currentTile);
      });
      QRs.add(IconButton(
        icon: Icon(Icons.add_circle_outlined),
        iconSize: 35,
        color: Colors.green,
        onPressed: (){
          print("tap");
        },
      ));
      return QRs;
    }
    else{
      List<Widget> empty = [];
      empty.add(CircularProgressIndicator());
      return empty;
    }

  }

  @override
  Widget build(BuildContext context) {
    final myuser = Provider.of<MyUser>(context);
    if(myuser != null) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () async {
                  AuthService().signOut();
                },
                child: Text("Log Out", style: TextStyle(color: Colors.black),))
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hi ",
                    style: TextStyle(
                        fontSize: 50
                    ),
                  ),
                  Text(
                    myuser.fullname,
                    style: TextStyle(
                      color: Colors.lightBlueAccent[100],
                      fontSize: 50
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Text("MY QR CODES"),
              Divider(thickness: 2,),
              Container(
                height: MediaQuery.of(context).size.height-200,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),

                  children: getQRs()
                ),
              ),
            ],
          ),
        ),
      );
    }
    else{
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
