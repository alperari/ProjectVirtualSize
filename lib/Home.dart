import 'package:flutter/material.dart';
import 'package:virtual_size_app/cart.dart';
import 'package:virtual_size_app/models/user.dart';
import "package:provider/provider.dart";
import 'package:virtual_size_app/navigationPages/createQR/createQRcode_getName.dart';
import 'package:virtual_size_app/navigationPages/displayQRs.dart';
import 'package:virtual_size_app/services/AuthService.dart';

import 'package:flutter/cupertino.dart';

import 'file:///D:/AndoidStudio_apps/virtual_size_app/lib/navigationPages/createQR/createQRcode.dart';
import "package:virtual_size_app/navigationPages/Profile.dart";
import "package:virtual_size_app/navigationPages/market.dart";


import 'package:cupertino_icons/cupertino_icons.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PageController pageController;
  int pageIndex = 0;


  onPageChanged(int pindex){
    setState(() {
      this.pageIndex = pindex;
    });
  }
  navigationTap(int pindex){
    pageController.jumpToPage(pindex);
  }


  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    //get user by provider, guaranteed to be non-null
    final myuser = Provider.of<MyUser>(context);


    if(myuser != null) {
      return Scaffold(
        appBar: AppBar(
          leading: pageIndex == 3 ? OutlinedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){

                    return Cart(user: myuser);
                  }
              ));
            },
            child: Icon(CupertinoIcons.cart_fill, color: Colors.black,size: 30,),
          )
          :null,
          actions: [
            TextButton(
                onPressed: () async {
                  AuthService().signOut();
                },
                child: Text("Log Out", style: TextStyle(color: Colors.black),))
          ],
        ),
        body: PageView(
          children: <Widget>[
            Profile(),
            displayQRs(),
            createQRcode_getName(),
            Market(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),

        ),

        bottomNavigationBar: CupertinoTabBar(
          iconSize: 34,
          backgroundColor: Colors.transparent,
          currentIndex: pageIndex,
          onTap: navigationTap,
          activeColor: Colors.lightGreen,
          inactiveColor: Colors.grey,
          items: [
            BottomNavigationBarItem(title: Text("Profile", style: TextStyle(fontSize: 14),),icon: Icon(CupertinoIcons.person_solid)),
            BottomNavigationBarItem(title: Text("Display QRs", style: TextStyle(fontSize: 14),),icon: Icon(Icons.qr_code_rounded)),
            BottomNavigationBarItem(title: Text("Create QR", style: TextStyle(fontSize: 14),),icon: Icon(CupertinoIcons.add_circled_solid,)),
            BottomNavigationBarItem(title: Text("Marketplace", style: TextStyle(fontSize: 14),),icon: Icon(Icons.shopping_cart)),
          ],
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

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }
}
