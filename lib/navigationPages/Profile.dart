import 'dart:async';

import 'package:flutter/material.dart';
import 'package:virtual_size_app/custom_icon_icons.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import "package:virtual_size_app/InputSections/hat.dart";
import "package:virtual_size_app/InputSections/tshirt.dart";
import "package:virtual_size_app/InputSections/pants.dart";
import "package:virtual_size_app/InputSections/necklace.dart";


class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {

  Map<String,double> QRdata = {};


  StreamController<Map<String,double>> mystreamController = StreamController.broadcast();
  Stream<Map<String,double>> mystream;


  // TickerProviderStateMixin allows the fade out/fade in animation when changing the active button

  // this will control the button clicks and tab changing
  TabController _controller;

  // this will control the animation when a button changes from an off state to an on state
  AnimationController _animationControllerOn;

  // this will control the animation when a button changes from an on state to an off state
  AnimationController _animationControllerOff;

  // this will give the background color values of a button when it changes to an on state
  Animation _colorTweenBackgroundOn;
  Animation _colorTweenBackgroundOff;

  // this will give the foreground color values of a button when it changes to an on state
  Animation _colorTweenForegroundOn;
  Animation _colorTweenForegroundOff;

  // when swiping, the _controller.index value only changes after the animation, therefore, we need this to trigger the animations and save the current index
  int _currentIndex = 0;

  // saves the previous active tab
  int _prevControllerIndex = 0;

  // saves the value of the tab animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
  double _aniValue = 0.0;

  // saves the previous value of the tab animation. It's used to figure the direction of the animation
  double _prevAniValue = 0.0;

  // these will be our tab icons. You can use whatever you like for the content of your buttons
  List<dynamic> _icons = [
    CustomIcon.hat,
    CustomIcon.t_shirt_1,
    CustomIcon.black__1_,
    CustomIcon.necklace,
  ];

  List<dynamic> iconColorsSet = [0,0,0,0];

  // active button's foreground color
  Color _foregroundOn = Colors.white;
  Color _foregroundOff = Colors.black;

  // active button's background color
  Color _backgroundOn = Colors.lightGreen;
  Color _backgroundOff = Colors.grey[500];

  // scroll controller for the TabBar
  ScrollController _scrollController = new ScrollController();

  // this will save the keys for each Tab in the Tab Bar, so we can retrieve their position and size for the scroll controller
  List _keys = [];

  // regist if the the button was tapped
  bool _buttonTap = false;

  @override
  void initState() {
    super.initState();

    mystream = mystreamController.stream;

    for (int index = 0; index < _icons.length; index++) {
      // create a GlobalKey for each Tab
      _keys.add(new GlobalKey());
    }

    // this creates the controller with 6 tabs (in our case)
    _controller = TabController(vsync: this, length: _icons.length);
    // this will execute the function every time there's a swipe animation
    _controller.animation.addListener(_handleTabAnimation);
    // this will execute the function every time the _controller.index value changes
    _controller.addListener(_handleTabChange);

    _animationControllerOff =
        AnimationController(vsync: this, duration: Duration(milliseconds: 75));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOff.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff);

    _animationControllerOn =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOn.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  // runs during the switching tabs animation
  _handleTabAnimation() {
    // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller.animation.value;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller.index);

    // this resets the button tap
    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });

      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn.reset();
    _animationControllerOff.reset();

    // run the animations!
    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle

      // get the last button
      renderBox = _keys[_icons.length - 1].currentContext.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated ammount
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index, snapshot) {
    if(!snapshot.hasData){
      return _backgroundOff;
    }
    else{
      if(snapshot.data["icon"+index.toString()] == 1){

        if (index == _currentIndex) {
          // if it's active button
          return _colorTweenBackgroundOn.value;
        }
        else if (index == _prevControllerIndex) {
          // if it's the previous active button
          return _colorTweenBackgroundOff.value;
        }
        else {
          // if the button is inactive
          return Colors.lightGreenAccent;
        }
      }
      else{
        return _colorTweenBackgroundOff.value;
      }


    }
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return _colorTweenForegroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff.value;
    } else {
      return _foregroundOff;
    }
  }



  bool checkButtonValidity(snapshot){
    if(snapshot.data["icon0"]==1.0 || snapshot.data["icon1"]==1.0 ||snapshot.data["icon2"]==1.0  || snapshot.data["icon3"]==1.0){
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(children: <Widget>[
          // this is the TabBar
          Container(
              height: 49.0,
              // this generates our tabs buttons
              child: StreamBuilder(
                stream: mystream,
                builder: (context,snapshot){
                  return Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ListView.builder(
                          // this gives the TabBar a bounce effect when scrolling farther than it's size
                            physics: BouncingScrollPhysics(),
                            controller: _scrollController,
                            // make the list horizontal
                            scrollDirection: Axis.horizontal,
                            // number of tabs
                            itemCount: _icons.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                // each button's key
                                  key: _keys[index],
                                  // padding for the buttons
                                  padding: EdgeInsets.all(6.0),
                                  child: ButtonTheme(
                                      child: AnimatedBuilder(
                                        animation: _colorTweenBackgroundOn,
                                        builder: (context, child) =>
                                            FlatButton(
                                              // get the color of the button's background (dependent of its state)
                                                color: _getBackgroundColor(index,snapshot),
                                                // make the button a rectangle with round corners
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius.circular(7.0)),
                                                onPressed: () {
                                                  setState(() {
                                                    _buttonTap = true;
                                                    // trigger the controller to change between Tab Views
                                                    _controller.animateTo(index);
                                                    // set the current index
                                                    _setCurrentIndex(index);
                                                    // scroll to the tapped button (needed if we tap the active button and it's not on its position)
                                                    _scrollTo(index);
                                                  });
                                                },
                                                child: Icon(
                                                  // get the icon
                                                  _icons[index],
                                                  // get the color of the icon (dependent of its state)
                                                  color: _getForegroundColor(index),
                                                )

                                            )


                                      )));
                            }
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            color: snapshot.hasData ? (checkButtonValidity(snapshot) ? Colors.blue : Colors.grey[600]) : Colors.grey[600],

                          ),

                          child: IconButton(
                            icon: Icon(Icons.check, color: Colors.white,
                            ),
                            iconSize: 30,
                            onPressed: snapshot.hasData ? (checkButtonValidity(snapshot) ? (){

                              QRdata["neck"] = snapshot.data["neck"];
                              QRdata["chest"] = snapshot.data["chest"];
                              QRdata["shoulder"] = snapshot.data["shoulder"];
                              QRdata["length"] = snapshot.data["length"];
                              QRdata["sleeve"] = snapshot.data["sleeve"];
                              QRdata["biceps"] = snapshot.data["biceps"];
                              QRdata["waist"] = snapshot.data["waist"];
                              print("From out, stream: " +  snapshot.data.toString());
                              print("from out, qrdata: " +  QRdata.toString());

                            } : null )
                                :
                            null,
                          ),
                        ),
                      )
                    ],
                  );
                }

              )
          ),
          Flexible(
            // this will host our Tab Views
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                // and it is controlled by the controller
                controller: _controller,
                children: <Widget>[
                  // our Tab Views
                  Hat(data: QRdata),
                  Tshirt(data: QRdata, stream: mystream, controller: mystreamController),
                  Pants(data: QRdata),
                  Necklace(data: QRdata),
                ],
              )),
        ]));
  }

}