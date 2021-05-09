

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progo/views/peole_list.dart';


Widget eopleBuild(var people,var project, List<NetworkImage> images,Size size,BuildContext context) {
  print('return of the prodigal child');
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
       Container(

            padding: EdgeInsets.only(left: size.width*0.05,right: size.width*0.05,top: size.height*0.18,bottom: size.height*0.32),
            decoration: BoxDecoration(color: Colors.transparent),
            child:accepted.length>0?
            Container(
                height: size.height*0.4,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(size.height*0.02)
                    ,topLeft: Radius.circular(size.height*0.02),bottomRight:Radius.circular(size.height*0.02),bottomLeft: Radius.circular(size.height*0.02) )),
                child:ListView.separated(

                  itemCount: accepted.length+1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index==accepted.length)
                      return Container();
                    else return Container(
                      height: size.height*0.08,

                      child: Row(
                        mainAxisSize: MainAxisSize.max
                        ,mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,children: [
                        SizedBox(width: size.width*0.05,),
                        CircleAvatar(
                            radius: size.height*0.05,
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.green,
                            backgroundImage:NetworkImage(accepted[index]['image'])
                        ),


                        SizedBox(width: size.width*0.1,),
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: size.width*0.3,child: Text(accepted[index]['name'].toString().toUpperCase(),style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: size.height*0.02),)),
                            Container(child: Text(accepted[index]['iid'],style:TextStyle(color: Colors.black45))),

                          ],
                        ),
                        SizedBox(width: size.width*0.07,),
                        Text(accepted[index]['pursuing']=="0"?"UG":(accepted[index]['pursuing']=="1"?'PHD':'PG'),
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
          Row(
              children: [
                Container(height: size.height*0.04,width: size.height*0.04,
                  decoration: BoxDecoration(color: Colors.redAccent,borderRadius: BorderRadius.all(Radius.circular(size.height*0.05)),
                  ),

                  child: Text((people.length-pending.length).toString(),
                      style: TextStyle(color: Colors.white,fontSize: size.height*0.018)),alignment: Alignment.center,),
                SizedBox(width: size.width*0.05,),
                Text("People",style: TextStyle(color: Colors.black45),),



              ],
            ),


            decoration:
            BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(size.height*0.05))),),
              top: size.height*0.07,right: size.width*0.15),

        ]
    );
}

