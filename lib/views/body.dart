import 'package:flutter/material.dart';

import 'main_screen.dart';



class Body extends StatelessWidget {
  String uid;
  Body(String uid){
    this.uid=uid;
  }
  BuildContext context;
  @override
  Widget build( context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return WillPopScope(child: Scaffold(
      body:

      main_screen(uid:uid,size: size),



    ), onWillPop: _onBackPressed);

  }
  Future<bool> _onBackPressed() {
    Navigator.of(context).pop(true);

       }
}
