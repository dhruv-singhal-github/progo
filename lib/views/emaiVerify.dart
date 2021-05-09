import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:progo/views/projectManagerScreen.dart';

import 'login.dart';

class emailVerify extends StatefulWidget {

  @override
  _emailVerifyState createState() => _emailVerifyState();
}

class _emailVerifyState extends State<emailVerify> {


  @override
  Widget build(BuildContext context) {
    sendmail();
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child:Material(color:Colors.white,child:Column(
        children:[
          SizedBox(height: 100,),
      Image.asset("assets/emailv.jpg", ),
          IconButton(icon: Icon(Icons.navigate_next_rounded,color: Colors.greenAccent,size: 50,), onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => login()),
            );
          })
      ]
      )
    ));
  }




}
Future<void> sendmail() async{

  FirebaseUser user = await FirebaseAuth.instance.currentUser();

  if (!user.isEmailVerified) {
    user.sendEmailVerification();

  }
}

