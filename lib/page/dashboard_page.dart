import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/page/All_blog_page.dart';
import 'package:ui_13/page/image_detection_plantnet_page.dart';
import 'package:ui_13/page/inbox_page.dart';
import 'package:ui_13/page/plant_diagnosis_page.dart';
import 'package:ui_13/page/profile_page.dart';
import 'package:ui_13/page/tutorial_page.dart';
import 'package:ui_13/widgets/hidden_drawer_nav.dart';



class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectId = 0;
  int activePage = 0;

  int sitesnumber=0;
  int c1=0,c2=0,c3=0;
  dynamic indoornumber=0;
  dynamic outdoornumber=0;
  dynamic gardennumber=0;

  int living_Site=0;
  int bed_Site=0;
  int kitchen_Site=0;
  int bath_Site=0;
  int belcony_Site=0;
  int terrace_Site=0;
  int office_Site=0;
  late var rnumber;



  List category1=[];
  List category2=[];
  List category3=[];

  String avatarurl="";
  String name="your name";


  List<QueryDocumentSnapshot<Object?>> _documentSnapshot2=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot3=[];

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;




  /*final Plants plant;
  const Dashboard({Key? key, required this.plant}) : super(key: key);*/
  @override
  Widget build(BuildContext context) {
    var height = (MediaQuery.of(context).size.height/2);
    var weight = (MediaQuery.of(context).size.width-30);
    return WillPopScope(
        child: AnimatedContainer(

          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor)..rotateY(isDrawerOpen? -0.1:0),
          duration: Duration(milliseconds: 250),

          decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(isDrawerOpen?40:0.0)

          ),

          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isDrawerOpen?IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: (){
                            setState(() {
                              xOffset=0;
                              yOffset=0;
                              scaleFactor=1;
                              isDrawerOpen=false;

                            });
                          },

                        ): IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                xOffset = 230;
                                yOffset = 150;
                                scaleFactor = 0.65;
                                isDrawerOpen=true;
                              });
                            }),
                        Text("Discover", style: TextStyle(color: tabcolor1,fontSize: 23,fontWeight: FontWeight.bold),),

                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("inbox")
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection("items")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(""),
                                );
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Text(""),
                                );
                              }

                              return Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(

                                        builder: (builder) => Inbox(),
                                      ),
                                    );

                                  }, icon: snapshot.data!.docs.length!=0?Stack(
                                    children: <Widget>[
                                      new Icon(Icons.messenger_outline, color: Colors.black54,),
                                      new Positioned(  // draw a red marble
                                        top: 1.0,
                                        right: 01.0,
                                        child: new Icon(Icons.brightness_1, size: 10.0,
                                            color: Colors.red),
                                      )
                                    ]
                                )
                                    :Icon(Icons.messenger_outline, color: Colors.black54,),
                                  //Icon(Icons.messenger_outline, color: Colors.black54,)
                                ),
                              );
                            }),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(

                    width: (MediaQuery.of(context).size.width-30),
                    decoration: BoxDecoration(

                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(12),bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: green.withOpacity(0.25),
                          blurRadius: 15,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [


                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("users-profile")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(snapshot.data==null){
                              return Text("");
                              //snapshot.data.docs
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(avatarurl),
                                    backgroundColor: Colors.green.withOpacity(0.3),
                                  ),
                                  title: Text("Your name", style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text("See your profile"),
                                ),
                              );
                            }

                            if(snapshot.hasData) {

                              var user=snapshot.data;
                              name=user["name"];
                              avatarurl=user["imagePath"];
                            }
                            return  Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(

                                      builder: (builder) => ProfilePage(),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(

                                  backgroundImage: CachedNetworkImageProvider(avatarurl),
                                  backgroundColor: Colors.green.withOpacity(0.15),

                                ),
                                title: Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: Text("See your profile"),
                              ),
                            );
                          },

                        ),
                        //
                        SizedBox(height: 15,),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder(
                                stream: FirebaseFirestore.instance.collection("users-myplant-items-v2").doc(FirebaseAuth.instance.currentUser!.email)
                                    .collection("items").snapshots(),
                                builder: (BuildContext context, AsyncSnapshot snapshot){
                                  if(snapshot.data==null){
                                    return Text("");
                                    //snapshot.data.docs
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(

                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.black12,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 2,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Icon(FontAwesomeIcons.tree, color: tabcolor2.withOpacity(0.5),),
                                                    Text("  ${0}", style: TextStyle(color: Colors.black45),),
                                                  ],
                                                ),
                                                SizedBox(height: 2,),
                                                Text("plants", style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),),
                                                SizedBox(height: 2,),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Container(
                                          decoration: BoxDecoration(

                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.black12,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 2,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Icon(FontAwesomeIcons.tree, color: tabcolor2.withOpacity(0.5),),
                                                    Text("  ${0}", style: TextStyle(color: Colors.black45),),
                                                  ],
                                                ),
                                                SizedBox(height: 2,),
                                                Text("Sites", style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),),
                                                SizedBox(height: 2,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }

                                  if(snapshot.hasData) {
                                    _documentSnapshot2 =snapshot.data!.docs;
                                    _documentSnapshot3=_documentSnapshot2;
                                    for(int i=0;i<_documentSnapshot3.length;i++) {
                                      if(_documentSnapshot3[i]['site']=='living-room') {
                                        living_Site=1;
                                      } else if(_documentSnapshot3[i]['site']=='bed-room') {
                                        bed_Site=1;
                                      } else if(_documentSnapshot3[i]['site']=='kitchen-room') {
                                        kitchen_Site=1;
                                      } else if(_documentSnapshot3[i]['site']=='bath-room') {
                                        bath_Site=1;
                                      } else if(_documentSnapshot3[i]['site']=='belcony-room') {
                                        belcony_Site=1;
                                      } else if(_documentSnapshot3[i]['site']=='terrace-room') {
                                        terrace_Site=1;
                                      } else if(_documentSnapshot3[i]['site']=='office-room') {
                                        office_Site=1;
                                      }
                                    }
                                    sitesnumber=living_Site+bed_Site+kitchen_Site+bath_Site+belcony_Site+terrace_Site+office_Site;
                                    ////

                                  }
                                  return  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(

                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 2,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Icon(FontAwesomeIcons.tree, color: tabcolor2.withOpacity(0.5),),
                                                  Text("  ${snapshot.data.docs.length}", style: TextStyle(color: Colors.black45),),
                                                ],
                                              ),
                                              SizedBox(height: 2,),
                                              Text("plants", style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),),
                                              SizedBox(height: 2,),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6,),
                                      Container(
                                        decoration: BoxDecoration(

                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 2,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Icon(FontAwesomeIcons.tree, color: tabcolor2.withOpacity(0.5),),
                                                  Text("  ${sitesnumber}", style: TextStyle(color: Colors.black45),),
                                                ],
                                              ),
                                              SizedBox(height: 2,),
                                              Text("Sites", style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),),
                                              SizedBox(height: 2,),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },

                              ),

                              StreamBuilder(
                                stream: FirebaseFirestore.instance.collection("rewards").doc(FirebaseAuth.instance.currentUser!.email)
                                    .snapshots(),
                                builder: (BuildContext context, AsyncSnapshot snapshot){
                                  if(snapshot.data==null){
                                    return Text("");
                                    //snapshot.data.docs
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent.withOpacity(0.2),

                                        borderRadius: BorderRadius.circular(12),

                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
                                            child:Icon(FontAwesomeIcons.coins, size: (MediaQuery.of(context).size.width/2)*0.12,color:Colors.blue.withOpacity(0.3),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                                            child:Text("Credits", style: TextStyle(fontWeight: FontWeight.bold,),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                                            child:Container(
                                              width: MediaQuery.of(context).size.width/4.9,
                                              decoration: BoxDecoration(
                                                color: Colors.white,

                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                              child: Center(
                                                child: Text("0"),
                                              ),
                                            ),
                                          ),



                                        ],
                                      ),
                                    );
                                  }

                                  if(snapshot.hasData) {
                                    var rewards=snapshot.data;
                                    rnumber=rewards["temp-rewards"];


                                  }
                                  return  Container(
                                    width: MediaQuery.of(context).size.width/4,
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent.withOpacity(0.2),

                                      borderRadius: BorderRadius.circular(12),

                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
                                          child:Icon(FontAwesomeIcons.coins, size: (MediaQuery.of(context).size.width/2)*0.12,color:Colors.blue.withOpacity(0.3),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                                          child:Text("Credits", style: TextStyle(fontWeight: FontWeight.bold,),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                                          child:Container(
                                            width: MediaQuery.of(context).size.width/4.9,
                                            decoration: BoxDecoration(
                                              color: Colors.white,

                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(
                                              child: Text(rnumber.toString(),overflow: TextOverflow.fade,),
                                            ),
                                          ),
                                        ),



                                      ],
                                    ),
                                  );
                                },

                              ),

                            ],
                          ),
                        ),



                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 44),
                          child: Divider(
                            color: Colors.grey.withOpacity(0.6),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap:() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      //builder: (builder) => DetailsPage(plant: plants[index]),
                                      builder: (builder) => ImageDetectPN(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.width/2.7,
                                  width: MediaQuery.of(context).size.width/4,

                                  decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent.withOpacity(0.3),

                                    borderRadius: BorderRadius.circular(32),

                                  ),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(""),
                                      Text(""),
                                      Icon(FontAwesomeIcons.camera, size: (MediaQuery.of(context).size.width/2)*0.14,color: Colors.white70,),
                                      Text(""),

                                      Text("Plant",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                                      Text("recognition",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45)),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap:() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      //builder: (builder) => DetailsPage(plant: plants[index]),
                                      builder: (builder) => PlantDiagnosis(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.width/2.7,
                                  width: MediaQuery.of(context).size.width/4,

                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.3),

                                    borderRadius: BorderRadius.circular(32),

                                  ),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(""),
                                      Text(""),
                                      Icon(FontAwesomeIcons.houseMedicalCircleCheck, size: (MediaQuery.of(context).size.width/2)*0.14,color: Colors.white70,),
                                      Text(""),

                                      Text("Plant",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                                      Text("diagnosis",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45)),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap:() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      //builder: (builder) => DetailsPage(plant: plants[index]),
                                      builder: (builder) => TempPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.width/2.7,
                                  width: MediaQuery.of(context).size.width/4,

                                  decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent.withOpacity(0.3),

                                    borderRadius: BorderRadius.circular(32),

                                  ),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(""),
                                      Text(""),
                                      Icon(FontAwesomeIcons.sunPlantWilt, size: (MediaQuery.of(context).size.width/2)*0.14,color: Colors.white70,),
                                      Text(""),

                                      Text("Light",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                                      Text("meter",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45)),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                  SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 21),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(

                                builder: (builder) => TutorialPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width/2.5,
                            width: MediaQuery.of(context).size.width/2.5,

                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: green.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: tabcolor2.withOpacity(0.28),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Icon(FontAwesomeIcons.chalkboardUser, size: (MediaQuery.of(context).size.width/2)*0.12,color:Colors.blue.withOpacity(0.3),),
                                      ),
                                    ),
                                  ),
                                ),


                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Tutorial",style: TextStyle(fontWeight: FontWeight.bold, color: tabcolor2.withOpacity(0.7), fontSize: (MediaQuery.of(context).size.width/2)*0.086,shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 10.0,
                                        color: tabcolor2.withOpacity(0.3),
                                      ),

                                    ])),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                //builder: (builder) => DetailsPage(plant: plants[index]),
                                builder: (builder) => Blogs(),
                              ),
                            );
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width/2.5,
                            width: MediaQuery.of(context).size.width/2.5,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  opacity: 0.9,

                                  image: AssetImage("assets/images/bc2.png"),
                                  fit: BoxFit.cover),

                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: green.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 3),
                                ),
                              ],

                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment:Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: tabcolor2.withOpacity(0.28),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(Icons.newspaper, size: (MediaQuery.of(context).size.width/2)*0.12,color:Colors.blue.withOpacity(0.3),),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(


                                  children: [



                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text("Blog",style: TextStyle(fontWeight: FontWeight.bold, color: tabcolor2.withOpacity(0.6),fontSize: (MediaQuery.of(context).size.width/2)*0.1,shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 10.0,
                                                  color: tabcolor2.withOpacity(0.3),
                                                ),

                                              ])),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )



                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 200,),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
         if(isDrawerOpen) {
           setState(() {
             xOffset=0;
             yOffset=0;
             scaleFactor=1;
             isDrawerOpen=false;

           });
           return false;
         } else {
           return true;
         }

        });
  }
}


