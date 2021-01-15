import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  int _radioValue1=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up"),backgroundColor: Color.fromARGB(255, 50, 160,50)),
        body: Center(

            child:Container(
              padding:EdgeInsets.fromLTRB(30,0, 30, 0),
              decoration: BoxDecoration(
                  borderRadius:  BorderRadius.all(Radius.circular(20.0))
              ),
              child:SingleChildScrollView(
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start
                    ,
                    children: <Widget>[

                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'FULL NAME',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 15.0),TextField(
                        decoration: InputDecoration(
                            labelText: 'INSTITUTE ID',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 25.0), Text("CURRENTLY PURSUING",style: TextStyle(color: Colors.green, fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,fontSize: 15),)
                      ,SizedBox(height: 15,), Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            activeColor: Colors.green,focusColor:Colors.green,toggleable: true
                            ,value: 0,
                            groupValue: _radioValue1,
                            onChanged: (int value) {
                              setState(() { _radioValue1 = value; });
                            },
                          ),
                          new Text(
                            'UG',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 1,activeColor: Colors.green,focusColor:Colors.green,toggleable: true
                            ,
                            groupValue: _radioValue1,
                            onChanged: (int value) {
                              setState(() { _radioValue1 = value; });
                            },
                          ),
                          new Text(
                            'PHD',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Radio(
                            value: 2,activeColor: Colors.green,focusColor:Colors.green,toggleable: true
                            ,
                            groupValue: _radioValue1,
                            onChanged:(int value) {
                              setState(() { _radioValue1 = value; });
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
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),

                      ),SizedBox(height: 15,),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'MOBILE NUMBER',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'PASSWORD',
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
                        ,child:Container(
                        height: 40.0,width: 220,
                        alignment: Alignment.center,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: InkWell(
                            onTap: () {

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
}
