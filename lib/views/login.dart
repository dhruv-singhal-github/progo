import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:progo/views/HelperFunctions.dart';
import 'package:progo/views/projectManagerScreen.dart';
import 'package:progo/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:universal_widget/universal_widget.dart';
final fauth=FirebaseAuth.instance;
bool iisLoading=false;
final _scaffoldKey = GlobalKey<ScaffoldState>();
final snackBar1 = SnackBar(content: Text('Email or Password not valid!'));
final snackBar2 = SnackBar(content: Text('Verify Email (check inbox)'));
class login extends StatefulWidget {
  @override
  _loginPageState createState() => new _loginPageState();
}

class _loginPageState extends State<login> {

  final TextEditingController email=new TextEditingController();

  final TextEditingController pwd=new TextEditingController();


  @override
  void initState() {
    String id;
    HelperFunctions.getUserNameSharedPreference().then((value)=>{id=value});
    HelperFunctions.getUserLoggedInSharedPreference().then((value) => {
      if(value){

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) =>
            projectManagerScreen(id)))
      }

    });
  }

  Widget build(BuildContext context) {

    return new Scaffold(
    key:_scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Stack(

                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 40.0, right: 40.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller:email,
                      decoration: InputDecoration(
                          labelText: 'EMAIL / USERNAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller:pwd,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                    ),
                    SizedBox(height:5.0),

                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,width: 220,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: InkWell(
                          onTap: () {

                        SignIn(email.text.toString(), pwd.text.toString(),context,_scaffoldKey);


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
                    SizedBox(height: 20.0),


                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to ProGo ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => signup()),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),

              ],
            ),
            SizedBox(height: 20,),
            Center(
                child:
              UniversalWidget(
                name: "loading",
                child: CircularProgressIndicator(),visible: false,

              )
            )
          ],
        ));
  }
  Future<void> SignIn(String email, String password,BuildContext context,GlobalKey _scaffoldkey) async{


      UniversalWidget.find("loading").update(visible:true);

    FirebaseUser user=null;
    AuthResult authr=await fauth.signInWithEmailAndPassword(email:email,password: password).then((value) async {
      user= await FirebaseAuth.instance.currentUser();
      if( user.isEmailVerified) {
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserNameSharedPreference(user.uid.toString());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) =>
            projectManagerScreen(user.uid.toString())));
      }
      else {
      sendmail();
       UniversalWidget.find("loading").update(visible:false);

        _scaffoldKey.currentState.showSnackBar(snackBar2);

      }
    }).catchError((onError)=>{

      _scaffoldKey.currentState.showSnackBar(snackBar1), UniversalWidget.find("loading").update(visible:false)
    }
      );


    final userid = user.uid;
    print(userid);



  }
  Future<void> sendmail() async{

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if (!user.isEmailVerified) {
      user.sendEmailVerification();

    }
  }

}
