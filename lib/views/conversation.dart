import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progo/views/DatabaseMethods.dart';
import 'package:progo/views/NextPage.dart';
import 'package:progo/views/Widget.dart';
    String myid;
    var mypeople=<Map> [];
    class conversation extends StatefulWidget {
      var people=<Map>[];
      var myProject;
      var cuser;
      BuildContext bc;
      String uid;
      Size size;
      conversation(this.myProject,this.people,size,this.uid,this.bc,this.cuser);

      @override
      _conversationState createState() => _conversationState(myProject,people,size,uid,bc,cuser);
    }

    class _conversationState extends State<conversation> {
      var people=<Map>[];
      var _isVisible=false;
      var myProject;
      var cuser;
      BuildContext bc;
      String uid;
      Size size;
      Stream<QuerySnapshot> chats;
      TextEditingController messageEditingController = new TextEditingController();
      _conversationState(this.myProject,this.people,this.size,this.uid,this.bc,this.cuser){
        myid=this.uid;
        mypeople=this.people;
      }
      final _controller = ScrollController();

      Widget chatMessages(){


        return StreamBuilder(
          stream: chats,
          builder: (context, snapshot){

            return snapshot.hasData ?  ListView.builder(
                itemCount: snapshot.data.documents.length,
                controller: _controller,
                itemBuilder: (context, index){
                  return MessageTile(
                    message: snapshot.data.documents[index].data["message"],
                    sendByMe: uid == snapshot.data.documents[index].data["sendBy"],
                    id:snapshot.data.documents[index].data["sendBy"]
                  );
                }) : Container();
          },
        );
      }

      addMessage() {
        if (messageEditingController.text.isNotEmpty) {
          Map<String, dynamic> chatMessageMap = {
            "sendBy": uid,
            "message": messageEditingController.text,
            'time': DateTime
                .now()
                .millisecondsSinceEpoch,
          };

          DatabaseMethods().addMessage(myProject['id'], chatMessageMap);

          setState(() {
            messageEditingController.text = "";
            Timer(Duration(milliseconds: 500),
                    () => _controller.jumpTo(_controller.position.maxScrollExtent));
          });

        }
      }

      @override
      void initState() {
        DatabaseMethods().getChats(myProject['id']).then((val) {
          setState(() {
            chats = val;
          });
        });
        _isVisible=false;

        Timer(Duration(milliseconds: 500),
                () => _controller.jumpTo(_controller.position.maxScrollExtent));
        super.initState();
      }

      @override
      Widget build(BuildContext context) {
          Timer.periodic(Duration(seconds: 1), (timer) {
            if(_controller.offset != _controller.position.maxScrollExtent){
              setState(() {
                _isVisible=true;

              });
            }
          });
        _controller.addListener(() {
          if (_controller.offset == _controller.position.maxScrollExtent ) {

            setState(() {

              _isVisible=false;


            });

          } else {
            setState(() {
              _isVisible=true;

            });
            // You're at the bottom.
          }

        });
        return Scaffold(
          appBar: AppBar(title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(myProject['name']),
                Text(myProject['desc'],overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.height*0.016),)
            ], ),actions: [
                Padding(padding: EdgeInsets.only(right: 25,top:5),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new PageRouteBuilder(
                          opaque: true,
                          transitionDuration: const Duration(milliseconds: 500),

                          pageBuilder: (BuildContext context, _, __) {
                            return new NextPage(myProject,people,cuser,uid);

                          },
                          transitionsBuilder: (_, Animation<double> animation, __, Widget child) {

                            return new SlideTransition(
                              child: child,
                              position: new Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).animate(animation),
                            );
                          }
                      ));

                    },
                    child: Icon(Icons.add_circle,size: 30,),
                  ),

                ),


              ]
          ),
          body: Container(

            child: Stack(
              children: [

                Container(child: chatMessages(),padding: EdgeInsets.only(bottom:MediaQuery
                    .of(context)
                    .size
                    .height*0.08),),
                Container(alignment: Alignment.bottomCenter,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    color: Colors.black87,

                    height: MediaQuery.of(context).size.height*0.08,
                    child: Row(
                      children: [
                        Flexible(
                            child: TextField(
                              controller: messageEditingController,
                              style: simpleTextStyle(),keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: "Type Here...",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,

                                  ),
                                  border: InputBorder.none,

                              ),
                            )),
                        SizedBox(width: 16,),
                        GestureDetector(
                          onTap: () {
                            addMessage();
                          },
                          child: Container(
                              height:MediaQuery.of(context).size.height*0.04,
                              width:MediaQuery.of(context).size.height*0.04,

                              decoration: BoxDecoration(

                                 color: Colors.green,
                                  borderRadius: BorderRadius.circular(40)
                              ),

                              child: Image.asset("assets/send.png",
                                height: 25, width: 25,)),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(child:  Visibility(
                  child: IconButton(icon: Icon(Icons.arrow_circle_down_outlined,color: Colors.black87,size: MediaQuery.of(context).size.height*0.05,),
                      onPressed:(){ _controller.jumpTo(_controller.position.maxScrollExtent);}),
                  visible: _isVisible,
                ),
                  bottom: MediaQuery.of(context).size.height*0.1,left:MediaQuery.of(context).size.width*0.45 ,),
              ],
            ),
          ),
        );
      }

    }

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final String id;
  MessageTile({@required this.message, @required this.sendByMe,@required this.id});


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe ? [

                const Color(0xff4CAF50),
                const Color(0xff4CAF50)
              ]
                  : [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ],
            )
        ),
        child: Column(
          crossAxisAlignment: sendByMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text(sendByMe?"Me":mypeople.firstWhere((element) => element['id']==id)['name'].toString(),
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.left),
            Text(message,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
    }
