import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progo/views/HelperFunctions.dart';
import 'package:progo/views/addAgain.dart';
import 'package:progo/views/login.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:universal_widget/universal_widget.dart';
import 'addproject.dart';
import 'constants.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'projects.dart';
import 'people.dart';

class main_screen extends StatefulWidget {
  String uid;

   main_screen({
    Key key,@required this.uid,
    @required this.size
  }) : super(key: key);
  final Size size;

  @override
  _main_screenState createState() => _main_screenState(uid);
}

class _main_screenState extends State<main_screen> {
  String uid;
  int ndoc=0 ;
  int npro=0;
  bool first=false;
  bool firstpro=false;
  int curr_index=1;
  var fauth=FirebaseAuth.instance;

  var people=<Map>[];
  var projects=<Map>[];
  var myProjects=<Map>[];
  List admin;
  var myImage;
  Map<String, dynamic> cuser;
  List<NetworkImage> images = List<NetworkImage>();
  FirebaseUser ccuser;
  File _image;
  _main_screenState(String uid){
    this.uid=uid;
  }
  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    Future getImage() async {

      final pickedFil = await picker.getImage(source: ImageSource.gallery);


      if (pickedFil != null) {
        _image = File(pickedFil.path);
        final StorageReference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child("user/${uid}/i"); //i is the name of the image
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
        StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
        var downloadUrl = await storageSnapshot.ref.getDownloadURL();
        if (uploadTask.isComplete) {
          final String url = downloadUrl.toString();

          //You might want to set this as the _auth.currentUser().photourl
          var snapshots = Firestore.instance
              .collection('users')
              .document(uid);

          await snapshots.setData({'image': url}, merge: true);
          setState(() {
            cuser['image'] = url;
          });
        } else {
          print('No image selected.');
        }
      };
    }
    return StreamBuilder(
        stream: Firestore.instance.collection("projects").orderBy("name").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
          print("entered 1 loop streambuilder");
          if (snapshot1.hasData)
            return StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("users").orderBy("name").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (snapshot2.hasData) {
                    getUserData(snapshot1, snapshot2);

                    return
                      Scaffold(
                          floatingActionButtonLocation:admin.contains(uid) ?FloatingActionButtonLocation.centerDocked:null,
                          floatingActionButton:admin.contains(uid) ? FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (
                                      BuildContext context) =>
                                      addproject(
                                          people: people,
                                          projects: projects,
                                          images: images,
                                          size: widget.size,
                                          uid: uid))).then((value) =>
                                  setState(() {}));
                            },

                            child: Icon(Icons.add),
                            elevation: 3.0, backgroundColor: Colors.green,
                          ):null,
                          bottomNavigationBar: BottomNavigationBar(
                            selectedItemColor: Colors.green,
                            currentIndex: curr_index,
                            items: [
                              BottomNavigationBarItem(
                                icon: new Icon(Icons.group_work_sharp),
                                title: new Text('Projects'),
                              ),
                              BottomNavigationBarItem(
                                icon: new Icon(Icons.group_sharp),
                                title: new Text('People'),
                              ),
                            ],
                            onTap: onTabTapped,

                          ),
                          body:
                          Container(

                            // It will cover 20% of our total height
                            height: widget.size.height,
                            decoration: BoxDecoration(gradient: LinearGradient(
                                begin: Alignment.center,
                                end:
                                Alignment(0.8, 0.0),
                                // 10% of the width, so there are ten blinds.
                                colors: [

                                  Colors.green, Colors.lightGreen,


                                ]))
                            , child: Stack(
                            children: <Widget>[
                              Container(

                                height: widget.size.height * 0.18,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.center,
                                      end:
                                      Alignment(0.8, 0.0),
                                      // 10% of the width, so there are ten blinds.
                                      colors: [

                                        Colors.green, Colors.lightGreen,


                                      ], // red to yellow
                                      // repeats the gradient over the canvas
                                    )

                                ),
                                child: Container(
                                  width: widget.size.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      SizedBox(
                                        height: widget.size.height * 0.05,),
                                      IconButton(onPressed: () {
                                        HelperFunctions
                                            .saveUserLoggedInSharedPreference(
                                            false);
                                        FirebaseAuth.instance.signOut();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(builder: (
                                                BuildContext context) =>
                                                login()),
                                            ModalRoute.withName('/')
                                        );
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => login()),
                                        // );


                                      },
                                          icon: Icon(Icons.logout,
                                              color: Colors.white)),
                                      Align(alignment: Alignment.topRight,)
                                    ],
                                  ),
                                ),

                              ),
                              Positioned(child: Text(cuser['name']
                                  .toString()
                                  .toUpperCase(), style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monsterrat'),
                                textAlign: TextAlign.center,), top: widget.size
                                  .height * 0.13, left: widget.size.width *
                                  0.46,),

                              Positioned(child: Text(cuser['iid']
                                  .toString()
                                  .toUpperCase(), style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Monsterrat')), top: widget.size
                                  .height * 0.17, left: widget.size.width *
                                  0.46),
                              cuser['pursuing'].toString() == '0'
                                  ?
                              Positioned(child: Text('UG', style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Monsterrat')), left: widget.size
                                  .width * 0.8, top: widget.size.height * 0.17)
                                  : (cuser['pursing'].toString() == '1'
                                  ?

                              Positioned(child: Text('PHD', style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Monsterrat')), left: widget.size
                                  .width * 0.8, top: widget.size.height * 0.17)
                                  :

                              Positioned(child: Text('PG', style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Monsterrat')), left: widget.size
                                  .width * 0.8, top: widget.size.height *
                                  0.17)),

                              Positioned(child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(230, 230, 230, 1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 4,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      )
                                    ]),
                                child: curr_index == 0 ? buil(
                                    people, projects, images, widget.size, uid,
                                    context,cuser) : admin.contains(uid)?peopleBuild(
                                    people, projects, images, widget.size,
                                    context):eopleBuild(people, projects, images, widget.size,
                                    context),
                              )

                                ,
                                top: widget.size.height * 0.22,
                                width: widget.size.width,
                                height: widget.size.height * 1,)
                              ,
                              Positioned(
                                  top: widget.size.height * 0.12,
                                  left: widget.size.width * 0.05,
                                  child:

                                  //_image!=null?Image.file(_image):
                                  CircleAvatar(backgroundColor: Colors.white,
                                    radius: widget.size.height * 0.09,
                                    backgroundImage: CachedNetworkImageProvider(
                                        cuser['image']),)
                              ),


                              Positioned(child: IconButton(icon: Icon(
                                Icons.add_circle, color: Colors.black,
                                size: 33,), onPressed: () {
                                print("pressed");
                                getImage();
                              },)
                                , top: widget.size.height * 0.1, left: widget
                                    .size.width * 0.03,)
                            ],
                          ),
                          )
                      );
                  } else {
                    return Container(child: CircularProgressIndicator(),
                      height: widget.size.height,
                      alignment: Alignment.center,);
                  }
                }


                    );
          else {
            return Container(child: CircularProgressIndicator(),
              height: widget.size.height,
              alignment: Alignment.center,
                    );
          }
        }
    );
  }
  Object getUserData(AsyncSnapshot<QuerySnapshot> sp1,AsyncSnapshot<QuerySnapshot> sp2) {

   print("called User Data");

    List<DocumentSnapshot> pr=sp1.data.documents;
    List pe=sp2.data.documents;
    projects.clear();
    people.clear();
    images.clear();
     cuser=pe.firstWhere((element) => element.data['id']==uid).data;





//   if(people.length<ndoc||!first)
  {
    print(people.length);
    print(ndoc);
    first=true;
      pe.forEach((result) {
        print(result.data);
        if (result.data['id'] != uid ) {
          ndoc++;
          print('tata');
          people.add(result.data);
          images.add(NetworkImage(people.last['image']));
        }

      });
    }


// //final int npro = (await Firestore.instance.collection('projects').snapshots().length.toString()) as int;
//if(projects.length<npro||!firstpro)
{
  firstpro=true;
pr.forEach((result) {
  print(result.data);
    if(result.data['name']!="admin1") {
      projects.add(result.data);
      projects.last['id'] = result.documentID;
    }
    else {
      admin=result.data['members'];
  }

    });
  }

//     print(cuser);
//     yield cuser['image'].toString();
  }
  void onTabTapped(int index) {
    setState(() {
      curr_index = index;
    });
  }
}
