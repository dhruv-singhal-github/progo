import 'package:flutter/material.dart';

class people_list extends StatelessWidget {
  var accepted=<Map> [];
  Size size;
  people_list(this.accepted,this.size);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,title:Text('People')),
        body:Container(

        padding: EdgeInsets.only(top: size.height*0.0),

        child:

        new ListView.builder(itemBuilder:(BuildContext btctxt,int index){
            if(index==accepted.length) {
              return Container(decoration: BoxDecoration( border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey))));
            }
           else return Container(
                decoration: BoxDecoration( border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey)
                  ,
                ),),padding: EdgeInsets.fromLTRB(size.width*0.05, size.height*0.02, 0,size.height*0.02),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,children:[
                      CircleAvatar(
                          radius: size.height*0.05,
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.green,
                          backgroundImage:NetworkImage(accepted[index]['image'])
                      ),

                      SizedBox(width: size.width*0.07,),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start
                      ,mainAxisSize: MainAxisSize.max,children: [

                        Container(width:size.width*0.32,child: Text(accepted[index]['name'].toString().toUpperCase(),textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.height*0.02),)),
                        SizedBox(height:size.height*0.01),

                        Container(
          width: size.width*0.32,child: Text(accepted[index]['iid'],textAlign: TextAlign.left,style: TextStyle(color: Colors.black45),))
                      ],),
                      SizedBox(width: size.width*0.15,),
                      accepted[index]['pursuing']=="0"?Text('UG',
                        textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold)
                        ,):accepted[index]['pursuing']=="1"?Text("PG"
                          ,
                          textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold)
                      ):Text('Phd',
                          textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold))
                    ]),
                  Row(
                    children: [
                      SizedBox(width: size.width*0.25,),
                      Icon(Icons.mail,color: Colors.indigoAccent,),
                      Flexible(
                        child:
                      Text(accepted[index]['email'],style: TextStyle(color: Colors.indigoAccent),softWrap: true,),
                      )
                    ],
                  )],
                )
            );
        }
          ,itemCount: accepted.length+1,

        ),

      )
    );
  }
}
