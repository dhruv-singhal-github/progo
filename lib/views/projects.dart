import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progo/views/conversation.dart';
import 'package:progo/views/people.dart';
import 'package:progo/views/signup.dart';

// class projects extends StatefulWidget {
//     var people=<Map>[];
//     var project=<Map>[];
//     List<NetworkImage> images = List<NetworkImage>();
//     projects({Key key,@required this.people,@required this.project,@required this.images}):super(key:key);
//   //   @override
//   // _projectsState createState() => _projectsState(people,project,images);
// }



Widget buil(
  var people,
  var project,

  List<NetworkImage> images ,Size size,String uid,
    BuildContext context,var cuser)


 {
   var myProject=<Map>[];
   for(int i=0;i<project.length;i++){

     List p=project[i]['members'];

     if(p.contains(uid)){
       myProject.add(project[i]);
     }
   }



    return
    Stack(children:[
    Container(padding: EdgeInsets.only(left: size.width*0.05,right: size.width*0.05,top: size.height*0.18,bottom: size.height*0.3),
    decoration: BoxDecoration(color: Colors.transparent),child:myProject.length>0?
        Container(
 height: size.height*0.4,

          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(size.height*0.02),topLeft: Radius.circular(size.height*0.02),bottomLeft: Radius.circular(size.height*0.02),bottomRight: Radius.circular(size.height*0.02))),
          child:ListView.separated(


      itemCount: myProject.length+1,
      itemBuilder: (BuildContext context, int index) {
        if(index==myProject.length){
          return Container();
        }
       else  return Material(
          color: Colors.white,
         child: InkWell(
            onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => conversation(myProject[index],people,size,uid,context,cuser)));
            },splashColor: Colors.grey
          , child: Container(

                padding: EdgeInsets.fromLTRB(size.width*0.07,size.height*0,size.width*0.07, size.height*0)
                ,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Row(
                      children: [
                        Container(width: size.width*0.55,
                          child: Text(myProject[index]['name'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: size.height*0.025,
                          fontFamily:'Monsterrat',),),
                        ),
                        SizedBox(width: size.width*0.06,),
                        Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey,)
                      ],
                    ),
                    Container(width: size.width*0.6,
                      child: Text(
                          myProject[index]['desc'],style: TextStyle(color: Colors.grey,fontSize: size.height*0.015),
                            textAlign: TextAlign.justify,overflow: TextOverflow.ellipsis,
                      ),
                    )

              ],),
            ),
         ),
       );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    )):Container(padding: EdgeInsets.all(size.height*0.12),child:Image.asset("assets/addtask.jpg",))

        ,
    ),
        Positioned(child: Container(height: 0.048*size.height,width: 0.35*size.width,padding: EdgeInsets.only(left: size.height*0.005,right:size.height*0.005,
        top: size.height*0.001,bottom: size.height*0.001),
          child: Row(children: [
            Container(height: size.height*0.04,width: size.height*0.04,
              decoration: BoxDecoration(color: Colors.redAccent,borderRadius: BorderRadius.all(Radius.circular(size.height*0.05)),
              ),

              child: Text(myProject.length.toString(),style: TextStyle(color: Colors.white,fontSize: size.height*0.018)),alignment: Alignment.center,),SizedBox(width: size.width*0.05,),
            
            Text("Projects",style: TextStyle(color: Colors.grey),)

          ],),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(size.height*0.05))),),
          top: size.height*0.07,right: size.width*0.15,)]

  );
}

