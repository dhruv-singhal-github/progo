import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:progo/views/body.dart';
import 'package:progo/views/login.dart';
class projectManagerScreen extends StatefulWidget {
  String uid;
  final fauth=FirebaseAuth.instance;
  projectManagerScreen(String uid){
    this.uid=uid;
  }
  @override
  _projectManagerScreenState createState() => _projectManagerScreenState(uid);
}

class _projectManagerScreenState extends State<projectManagerScreen> {
  String uid;
  _projectManagerScreenState(String uid){
    this.uid=uid;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     body: Body(uid),

    );

  }

}
