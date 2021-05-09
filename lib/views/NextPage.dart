import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class NextPage extends StatefulWidget {
  var myProject;
  var people=<Map>[];
  var cuser,uid;
  NextPage(this.myProject,this.people,this.cuser,this.uid){}
  @override
  _NextPageState createState() => _NextPageState(myProject,people,cuser,uid);
}

class _NextPageState extends State<NextPage> {
  var myProject;
  var people=<Map>[];
  var cuser;
  var uid;
  var mem=<Map>[];
  var rem=<Map>[];
  _NextPageState(this.myProject,this.people,this.cuser,this.uid);
  Size size;
  @override
  Widget build(BuildContext context) {
    mem.clear();
    rem.clear();
    mem.add(cuser);
    for (int i=0;i<people.length;i++){
      List p=myProject['members'];

      if(p.contains(people[i]['id'])){
       mem.add(people[i]);
      }
      else if(people[i]['st']=="1"){
        rem.add(people[i]);
      }
    }
    size=MediaQuery.of(context).size;
    return Scaffold(appBar:   AppBar(title: Text(""),elevation: 0,
        // hides leading widget

    //)
       // )
    ),
    body: Container(height: size.height,decoration: BoxDecoration(color: Colors.blue),child:
    SingleChildScrollView(
      child: Column(
        children: [
          Container(padding: EdgeInsets.only(left: 20,right: 15,bottom: 20),
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(width: size.width,child: Text(myProject['name'],style: TextStyle(fontSize: size.height*0.05,color: Colors.white,fontWeight: FontWeight.bold),)),
                SizedBox(height: size.height*0.01,),
               Container(child: Text("Description :"+myProject['desc'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.height*0.02),))
                   ,SizedBox(height: size.height*0.09,),
                     Text("Members",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                     // Expanded(
                     //   child: ListView.builder(itemBuilder: (BuildContext bc,int index){
                     //    return Container(height: 3,);
                     //   },itemCount:2,shrinkWrap:true),
                     // )
                     SizedBox(height: 4,),
                      Column(crossAxisAlignment: CrossAxisAlignment.center,children:mem.map((item) {
                        return Container(
                            decoration: BoxDecoration( color: Colors.white,border: Border(
                              top: BorderSide(width: 1.0, color: Colors.grey)
                              ,
                            ),),padding: EdgeInsets.fromLTRB(size.width*0.05, size.height*0.02, size.width*0.068,size.height*0.02),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,children:[
                                  CircleAvatar(
                                      radius: size.height*0.05,
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.blue,
                                      backgroundImage:NetworkImage(item['image'])
                                  ),

                                  SizedBox(width: size.width*0.07,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start
                                    ,mainAxisSize: MainAxisSize.max,children: [

                                    Container(width: size.width*0.32,child: Text(item['name'].toString().toUpperCase(),textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.height*0.02),)),
                                    SizedBox(height:size.height*0.01),

                                    Container(
                                        width: size.width*0.32,child: Text(item['iid'],textAlign: TextAlign.left,style: TextStyle(color: Colors.black45),))
                                  ],),
                                  SizedBox(width: size.width*0.05,),
                                  item['pursuing']=="0"?Text('UG',
                                    textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold)
                                    ,):item['pursuing']=="1"?Text("PG"
                                      ,
                                      textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold)
                                  ):Text('Phd',
                                      textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold))
                                ]),
                               ]
                            )
                        );

                      }).toList()),
                   Container(color: Colors.blue,),
                   ], ),
          ),

        SizedBox(height: size.height*0.04,),


        ],
      ),
    ))
      //   Container(
      //     height: size.height*0.04,
      //     padding: EdgeInsets.fromLTRB(10, 5, 1, 1),
      //     width:size.width,color: Colors.green
      //     ,child: Text("Add People",
      //   style: TextStyle(backgroundColor: Colors.green,fontWeight: FontWeight.bold,color: Colors.white),)),
      //   Expanded(
      //
      //     child: new ListView.builder(itemBuilder:(BuildContext btctxt,int index){
      //       if(index==accepted.length)
      //         return Container( decoration: BoxDecoration( border: Border(
      //           top: BorderSide(width: 1.0, color: Colors.grey)
      //           ,
      //         )));
      //       else return new CheckboxListTile(value: _checked[index],onChanged:(bool nvalue){
      //         setState(() {
      //           log(nvalue.toString());
      //
      //           _checked[index]= nvalue;
      //         });
      //       },
      //         activeColor: Colors.green,
      //         checkColor: Colors.white,
      //         controlAffinity: ListTileControlAffinity.platform,
      //         secondary: Container(
      //             decoration: BoxDecoration(
      //             ),padding: EdgeInsets.fromLTRB(0, size.height*0.007, 0,size.height*0.007),
      //             child:
      //             Row(
      //                 mainAxisSize: MainAxisSize.min,children:[
      //               CircleAvatar(
      //                   radius: size.height*0.05,
      //                   backgroundColor: Colors.green,
      //                   foregroundColor: Colors.green,
      //                   backgroundImage:NetworkImage(accepted[index]['image'])
      //               ),
      //               Column(mainAxisSize: MainAxisSize.max,children: [
      //
      //                 Container(width: size.width*0.25,child: Text(accepted[index]['name'],textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),)),
      //                 SizedBox(height:size.height*0.01),
      //
      //                 Container(width: size.width*0.25,child: Text(accepted[index]['iid'],textAlign: TextAlign.left,style: TextStyle(color: Colors.black45),))
      //               ],),
      //               SizedBox(width: size.width*0.05,),
      //               accepted[index]['pursuing']=="0"?Text('UG',
      //                 textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold)
      //                 ,):accepted[index]['pursuing']=="1"?Text("PG"
      //                   ,
      //                   textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold)
      //               ):Text('Phd',
      //                   textAlign: TextAlign.end,style: TextStyle(color: Colors.black45,fontSize: size.height*0.03,fontWeight:FontWeight.bold))
      //             ])
      //         ),);
      //     },itemExtent: size.height*0.1
      //       ,itemCount: accepted.length+1,
      //     ),
      //
      //   )


    );

  }
}
