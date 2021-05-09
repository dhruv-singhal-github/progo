

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progo/views/peole_list.dart';


  Widget peopleBuild(var people,var project, List<NetworkImage> images,Size size,BuildContext context) {
    double s=size.height;
    var pending=  <Map>[];
    var accepted=<Map> [];
    for (int i=0;i<people.length;i++){

      if (people[i]['st']=='0'){
        pending.add(people[i]);
      }
      else accepted.add(people[i]);
    }
    return
      Stack(
          children:[
              Positioned(child: Text("Requests",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: size.height*0.02)),left: size.width*0.1,top: size.height*0.14)
            ,Container(

          padding: EdgeInsets.only(left: size.width*0.05,right: size.width*0.05,top: size.height*0.18,bottom: size.height*0.32),
          decoration: BoxDecoration(color: Colors.transparent),
          child:pending.length>0?
          Container(
          height: size.height*0.4,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(size.height*0.02)
                  ,topLeft: Radius.circular(size.height*0.02),bottomRight:Radius.circular(size.height*0.02),bottomLeft: Radius.circular(size.height*0.02) )),
              child:ListView.separated(

                itemCount: pending.length+1,
                itemBuilder: (BuildContext context, int index) {
                  if (index==pending.length)
                    return Container();
                  else return Container(
                    height: size.height*0.08,

                    child: Row(
                    mainAxisSize: MainAxisSize.max
                    ,mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,children: [
                      SizedBox(width: size.width*0.08,),
                  IconButton(icon: Icon(Icons.check_circle,color: Colors.green,size: size.height*0.045), onPressed: (){
                    Firestore.instance.collection('users').document(pending[index]['id']).updateData({"st":"1"});
                  }),


                      SizedBox(width: size.width*0.1,),
                  Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: size.width*0.3,child: Text(pending[index]['name'].toString().toUpperCase(),style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: size.height*0.02),)),
                      Container(child: Text(pending[index]['iid'],style:TextStyle(color: Colors.black45))),

                    ],
                  ),
                  SizedBox(width: size.width*0.07,),
                  Text(pending[index]['pursuing']=="0"?"UG":(pending[index]['pursuing']=="1"?'PHD':'PG'),
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: size.height*0.025),)

                    ],),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              )

          ):Container(padding: EdgeInsets.all(size.height*0.12),child:Image.asset("assets/addtask.jpg",)),
        ),
        Positioned(child: Container(height: 0.048*size.height,width: 0.35*size.width,padding: EdgeInsets.only(left: size.height*0.005,right:size.height*0.005,
            top: size.height*0.001,bottom: size.height*0.0),
          child:
          GestureDetector(child:Row(
            children: [
            Container(height: size.height*0.04,width: size.height*0.04,
              decoration: BoxDecoration(color: Colors.redAccent,borderRadius: BorderRadius.all(Radius.circular(size.height*0.05)),
              ),

              child: Text((people.length-pending.length).toString(),
                  style: TextStyle(color: Colors.white,fontSize: size.height*0.018)),alignment: Alignment.center,),
            SizedBox(width: size.width*0.05,),
            Text("People",style: TextStyle(color: Colors.black),),
              Icon(Icons.navigate_next_rounded,color:Colors.black),


          ],
          ),onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => people_list(accepted,size)));
          }
    ),

          decoration:
          BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(size.height*0.05))),),
          top: size.height*0.07,right: size.width*0.15),

          ]
      );
  }

