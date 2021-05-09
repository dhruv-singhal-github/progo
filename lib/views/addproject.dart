

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progo/views/main_screen.dart';

class addproject extends StatefulWidget {
  var people=<Map>[];
  var projects=<Map>[];
  var accepted=<Map>[];
  String uid;
  List<NetworkImage> images = List<NetworkImage>();
  Size size;
  addproject( {@required this.people,@required this.projects,@required this.images,@required this.size,this.uid}){

    for (var i=0;i<people.length;i++){
      if (people[i]['st']=="1")
      accepted.add(people[i]);
    }
  }
  @override
  _addprojectState createState() => _addprojectState(people,projects,images,size,accepted,uid);

}

class _addprojectState extends State<addproject> {
  TextEditingController pname=new TextEditingController();
  TextEditingController pdes=new TextEditingController();

  var people=<Map>[];
  var projects=<Map>[];
  var accepted=<Map>[];
  var _checked;
  String uid;
  Size size;
  final snackBar = SnackBar(content: Text('Project Name Must not be Empty!'));
  List<NetworkImage> images=List<NetworkImage>();
  final GlobalKey<ScaffoldState> a = new GlobalKey<ScaffoldState>();
  _addprojectState(this.people,this.projects,this.images,this.size,this.accepted,this.uid){
    // _checked=List.filled(people.length,true);
    _checked=List.filled(accepted.length, false);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: a,
    appBar: AppBar(backgroundColor: Colors.green,title:Text('ADD PROJECT'),
    actions: [
      Padding(padding: EdgeInsets.only(right: 10,top:size.height*0.03),
        child: GestureDetector(
          onTap: (){
            if(pname.text.toString()==""){
              a.currentState.showSnackBar(snackBar);
            }

            else {
              List<String> id=new List<String>();
              id.add(uid);
              for (int i =0;i<accepted.length;i++){
                if (_checked[i]==true){
                  id.add(accepted[i]['id']);
                }

              }
              Map<String ,Object> project={
                "name":pname.text.toString().toUpperCase(),
                "desc":pdes.text.toString(),
                "members":id
              };

              add(project,context);
            }

          },
          child: Text("NEXT",style: TextStyle(fontWeight: FontWeight.bold),),
        ),

      ),


    ],)
    ,body:Container(
        margin: EdgeInsets.fromLTRB(size.height*0.03,size.height*0.01,size.height*0.03,size.height*0.01 ),
        child:Column(

        children: [
          TextField(
            controller:pname,
            decoration: InputDecoration(
                labelText: 'Project Name',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green))),

          ),
          SizedBox(height: size.height*0.05,),
          TextField(
            controller:pdes,
            decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green))),

          ),
              SizedBox(height: size.height*0.03,),

              Container(
                height: size.height*0.04,
              padding: EdgeInsets.fromLTRB(10, 5, 1, 1),
              width:size.width,color: Colors.green
              ,child: Text("Add People",
                style: TextStyle(backgroundColor: Colors.green,fontWeight: FontWeight.bold,color: Colors.white),)),
              Expanded(

                child: new ListView.builder(itemBuilder:(BuildContext btctxt,int index){
                  if(index==accepted.length)
                    return Container( decoration: BoxDecoration( border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey)
                      ,
                    )));
                  else return new CheckboxListTile(value: _checked[index],onChanged:(bool nvalue){
                    setState(() {
                      log(nvalue.toString());

                      _checked[index]= nvalue;
                    });
                  },
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.platform,
                  secondary: Container(
                    decoration: BoxDecoration(
                    ),padding: EdgeInsets.fromLTRB(0, size.height*0.007, 0,size.height*0.007),
                    child:
                     Row(
                         mainAxisSize: MainAxisSize.min,children:[
                      CircleAvatar(
                        radius: size.height*0.05,
                         backgroundColor: Colors.green,
                        foregroundColor: Colors.green,
                        backgroundImage:NetworkImage(accepted[index]['image'])
                    ),
                       Column(mainAxisSize: MainAxisSize.max,children: [

                         Container(width: size.width*0.32,child: Text(accepted[index]['name'],textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),)),
                         SizedBox(height:size.height*0.01),

                         Container(width: size.width*0.32,child: Text(accepted[index]['iid'],textAlign: TextAlign.left,style: TextStyle(color: Colors.black45),))
                       ],),
                       SizedBox(width: size.width*0.05,),
                       accepted[index]['pursuing']=="0"?Text('UG',
                         textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold)
                         ,):accepted[index]['pursuing']=="1"?Text("PG"
                           ,
                           textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold)
                       ):Text('Phd',
                           textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold))
                       ])
                  ),);
                },itemExtent: size.height*0.1
                ,itemCount: accepted.length+1,
                ),

          )


        ],
      ),
      )
    );
  }
  Future<String> add(Map<String,Object> project,BuildContext bc)async{

    await Firestore.instance.collection('projects').add(project).catchError((e){print(e.toString());});
    Navigator.pushAndRemoveUntil(
        bc,
        MaterialPageRoute(builder: (BuildContext context) => main_screen(size:size,uid: uid)), ModalRoute.withName('/'));
  }
}
