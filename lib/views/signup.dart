import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:progo/views/emaiVerify.dart';
import 'package:progo/views/projectManagerScreen.dart';
final fauth=FirebaseAuth.instance;
  GlobalKey _scaffoldKe = GlobalKey<ScaffoldState>();
 int emai=0;

final sn = SnackBar(content: Text('EMAIL LINKED TO EXISTING ACCOUNT'));
class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  int _radioValue1 = 0;


  final TextEditingController name = new TextEditingController();
  final TextEditingController iid = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController pwd = new TextEditingController();
  final TextEditingController cpwd = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar1 = SnackBar(content: Text('NAME FIELD SHOULD NOT BE EMPTY!'));
  final snackBar2 = SnackBar(content: Text('ID FIELD SHOULD NOT BE EMPTY!'));
  final snackBar3 = SnackBar(content: Text('EMAIL FIELD SHOULD NOT BE EMPTY!'));
  final snackBarm = SnackBar(
      content: Text('MOBILE FIELD SHOULD NOT BE EMPTY!'));
  final snackBar4 = SnackBar(
      content: Text('PASSWORD FIELD SHOULD NOT BE EMPTY!'));
  final snackBar5 = SnackBar(content: Text('CONFIRM PASSWORD!'));
  final snackBar6 = SnackBar(
      content: Text('PASSWORD SHOULD BE ATLEAST 5 CHARACTERS'));
  final snackBar7 = SnackBar(
      content: Text('CONFIRMED PASSWORD DOESN\'T MATCH'));
  final snackBar8 = SnackBar(content: Text('ENTER A VALID EMAIL'));
  final snackBar9 = SnackBar(content: Text('ENTER A VALID MOBILE NUMBER'));
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up"),
            backgroundColor: Color.fromARGB(255, 50, 160, 50)),
        key: _scaffoldKey,
        body: Center(

            child: Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start
                    ,
                    children: <Widget>[

                      TextFormField(
                        controller: name
                        , decoration: InputDecoration(
                          labelText: 'FULL NAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 15.0),
                      TextField(
                        controller: iid
                        , decoration: InputDecoration(
                          labelText: 'INSTITUTE ID',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 25.0),
                      Text("CURRENTLY PURSUING", style: TextStyle(
                          color: Colors.green, fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold, fontSize: 15),)
                      ,
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            activeColor: Colors.green,
                            focusColor: Colors.green,
                            toggleable: true
                            ,
                            value: 0,
                            groupValue: _radioValue1,
                            onChanged: (int value) {
                              setState(() {
                                _radioValue1 = value;
                              });
                            },
                          ),
                          new Text(
                            'UG',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 1,
                            activeColor: Colors.green,
                            focusColor: Colors.green,
                            toggleable: true
                            ,
                            groupValue: _radioValue1,
                            onChanged: (int value) {
                              setState(() {
                                _radioValue1 = value;
                              });
                            },
                          ),
                          new Text(
                            'PHD',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Radio(
                            value: 2,
                            activeColor: Colors.green,
                            focusColor: Colors.green,
                            toggleable: true
                            ,
                            groupValue: _radioValue1,
                            onChanged: (int value) {
                              setState(() {
                                _radioValue1 = value;
                              });
                            },
                          ),
                          new Text(
                            'PG',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(width: 20,)
                        ],
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),

                      ),
                      SizedBox(height: 15,),
                      TextField(
                        controller: mobile,
                        decoration: InputDecoration(
                            labelText: 'MOBILE NUMBER (10 DIGIT)',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green),

                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: pwd,
                        decoration: InputDecoration(
                            labelText: 'PASSWORD (atleast 6 characters)',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: cpwd,
                        decoration: InputDecoration(
                            labelText: 'CONFIRM PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                      ),
                      SizedBox(height: 35,),
                      Container(
                        alignment: Alignment.center
                        , child: Container(
                        height: 40.0, width: 220,
                        alignment: Alignment.center,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: InkWell(
                            onTap: () {
                              if (name.text
                                  .toString()
                                  .isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(
                                    snackBar1);
                              }
                              else if (iid.text
                                  .toString()
                                  .isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(
                                    snackBar2);
                              }
                              else if (email.text
                                  .toString()
                                  .isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(
                                    snackBar3);
                              }
                              else if (mobile.text
                                  .toString()
                                  .isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(
                                    snackBarm);
                              }
                              else if (pwd.text
                                  .toString()
                                  .isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(
                                    snackBar4);
                              }
                              else if (cpwd.text
                                  .toString()
                                  .isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(
                                    snackBar5);
                              } else
                              if (!regExp.hasMatch(email.text.toString())) {
                                _scaffoldKey.currentState.showSnackBar(
                                    snackBar8);
                              }

                              else if (mobile.text
                                  .toString()
                                  .length < 10 || mobile.text
                                  .toString()
                                  .length > 13) {
                                _scaffoldKey.currentState.showSnackBar(
                                    snackBar9);
                              }
                              else if (
                              pwd.text
                                  .toString()
                                  .length < 6) {
                                _scaffoldKey.currentState.showSnackBar(
                                    snackBar6);
                              }
                              else if (pwd.text.toString().compareTo(
                                  cpwd.text.toString()) != 0) {
                                _scaffoldKey.currentState.showSnackBar(
                                    snackBar7);
                              }
                              else {
                                SignUp(email.text.toString(),
                                    pwd.text.toString(), context);
                                if (emai == 1) {
                                  _scaffoldKey.currentState.showSnackBar(sn);
                                  emai = 0;
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ),
                      SizedBox(height: 20,)
                    ],)

              ),
            )
        )
    );
  }

  Future<String> SignUp(String email, String password,
      BuildContext context) async {
    Map<String, String> userm = {
      "id":"",
      "name": name.text.toString(),
      "email":email,
      "iid":iid.text.toString(),
      "pwd":pwd.text.toString(),
      "mobile":mobile.text.toString(),
      "pursuing":_radioValue1.toString(),
      "image":"https://firebasestorage.googleapis.com/v0/b/progo-drusn.appspot.com/o/unnamed.png?alt=media&token=cb7147c7-b7d6-4da5-9b91-d35b29bb3544",
      "st":"0"
    };
    AuthResult result;
    try {
      result = (await fauth.createUserWithEmailAndPassword(
          email: email, password: password)) as AuthResult;
      userm["id"]=result.user.uid;
    } catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        emai = 1;
        return null;
        // print('The account already exists for that email.');
      }
    }

    if (result.user != null) {
      Firestore.instance.collection('users').document(result.user.uid.toString()).setData(userm).catchError((e){print(e.toString());});
      Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => emailVerify()));
    }

    return result.user.uid;
  }
}