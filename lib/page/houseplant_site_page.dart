import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/core/color.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ui_13/page/more_mySite_plant_page.dart';
import 'package:ui_13/page/my_houseplants_tabbar_details_page.dart';
import '../data/plant_model_firestore.dart';

class HouseplantSite extends StatefulWidget {
  const HouseplantSite({Key? key}) : super(key: key);

  @override
  State<HouseplantSite> createState() => _HouseplantSiteState();
}

class _HouseplantSiteState extends State<HouseplantSite> {
  PageController controller = PageController();
  late HousePlantMy plantk;
  bool chacker=false;
  bool chacker2=false;
  bool chacker3=false;
  bool chacker4=false;
  bool chacker5=false;
  bool chacker6=false;
  bool chacker7=false;

  bool istree=true;
  int istreecount=0;
  int length1=0,length2=0,length3=0,length4=0,length5=0,length6=0,length7=0,mainlength=0;
  late var email,email2;
  late String site1,site2,site3,site4,site5,site6,site7;


  List<QueryDocumentSnapshot<Object?>> _documentSnapshot2=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot3=[];

  List<QueryDocumentSnapshot<Object?>> _documentSnapshot4=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot5=[];

  List<QueryDocumentSnapshot<Object?>> _documentSnapshot6=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot7=[];

  List<QueryDocumentSnapshot<Object?>> _documentSnapshot8=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot9=[];

  List<QueryDocumentSnapshot<Object?>> _documentSnapshot10=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot11=[];

  List<QueryDocumentSnapshot<Object?>> _documentSnapshot12=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot13=[];

  List<QueryDocumentSnapshot<Object?>> _documentSnapshot14=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot15=[];

  List<QueryDocumentSnapshot<Object?>> _documentSnapshot16=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot17=[];

  istreetrue() {
    setState(() {
      istree=true;
    });
  }

  istreefalse() {
    setState(() {
      istree=false;
    });
  }
  @override
  void initState() {
    controller = PageController(viewportFraction: 0.6, initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 25,),

////

            SizedBox(height: 25,),


            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-myplant-items-v2")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .where('site',isEqualTo: "living-room")
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something is wrong"),
                  );
                }

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(
                    color: Colors.blueGrey,
                  ));
                }
                if(snapshot.hasData) {

                  _documentSnapshot2 =snapshot.data!.docs;
                  _documentSnapshot3=_documentSnapshot2;
                  length1=_documentSnapshot3.length;
                  email=FirebaseAuth.instance.currentUser!.email;
                  if(_documentSnapshot3.length>0) {
                    chacker=true;
                  } else {
                    chacker=false;
                  }
                }




                return Column(
                  children: [

                    Padding(padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 19),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [


                          Visibility(
                              visible: chacker==false? false : true,
                              child: Text("Living Room", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),)),
                          length1>4?GestureDetector(
                            onTap:() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(

                                  builder: (builder) => MoreMySite(category1: "living-room"),
                                ),
                              );
                            },
                            child: Container(
                              child: Text("See all>>", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),),
                            ),
                          ):Text(""),


                        ],
                      ),
                    ),


                    Visibility(
                      visible: chacker==false? false : true,
                      child: SizedBox(
                        height: 1.0,

                      ),
                    ),

                    Visibility(
                      visible: chacker==false? false : true,
                      child: Container(
                        height:  (MediaQuery.of(context).size.width/2)+4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StaggeredGridView.countBuilder(
                            // physics: ScrollPhysics(),
                              physics:  NeverScrollableScrollPhysics(),

                              staggeredTileBuilder: (index) => index==0?StaggeredTile.count(2, 2):(index==1?StaggeredTile.count(1, 1):(index==2?StaggeredTile.count(1, 2):StaggeredTile.count(1, 1))),

                              /*(index) => index % 7 ==0 ?
                          StaggeredTile.count(2, 2) : StaggeredTile.count(1, 1),*/
                              crossAxisCount: 4,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount: 4,
                              itemBuilder: (context, index) {


                                /*DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];*/

                                return GestureDetector(
                                  onTap: () {

                                    ( _documentSnapshot3.length-1)>=index? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //builder: (builder) => DetailsPage(plant: plants[index]),
                                        builder: (builder) => MyHouseplantsTabbarPage(plant: plantk= HousePlantMy(

                                          uid: _documentSnapshot3[index].id,
                                          name:_documentSnapshot3[index]['name'],
                                          botanical_name :_documentSnapshot3[index]['botanical-name'],
                                          imagePath:_documentSnapshot3[index]['imagePath'],
                                          category:_documentSnapshot3[index]['category'],
                                          site:_documentSnapshot3[index]['site'],
                                          water_winter:_documentSnapshot3[index]['water_winter'],
                                          water_summer:_documentSnapshot3[index]['water_summer'],
                                          pot:_documentSnapshot3[index]['pot'],
                                          temp_from:_documentSnapshot3[index]['temp_from'],
                                          temp_to:_documentSnapshot3[index]['temp_to'],
                                          auto_taskname:_documentSnapshot3[index]['auto_taskname'],
                                          care: _documentSnapshot3[index]['care'],
                                          light:_documentSnapshot3[index]['light'],
                                          toxic:_documentSnapshot3[index]['toxic'],
                                          drain: _documentSnapshot3[index]['drain'],
                                          fertilizer: _documentSnapshot3[index]['fertilizer'],
                                          list: _documentSnapshot3[index]['water_list'],
                                        )),
                                      ),
                                    ):print(_documentSnapshot3.length.toString());

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: black.withOpacity(0.05),
                                          blurRadius: 15,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                      border: Border.all(color: white, width: 1.5),
                                      borderRadius: index==0?BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ):(index==2?BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ):BorderRadius.circular(0.0)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: lightGreen,
                                            boxShadow: [
                                              BoxShadow(
                                                color: black.withOpacity(0.05),
                                                blurRadius: 15,
                                                offset: const Offset(5, 5),
                                              ),
                                            ],
                                            borderRadius: index==0?BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ):(index==2?BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ):BorderRadius.circular(0.0)),
                                            image: DecorationImage(
                                              image: _documentSnapshot3.asMap().containsKey(index)?CachedNetworkImageProvider(_documentSnapshot3[index]['imagePath']):CachedNetworkImageProvider("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(_documentSnapshot3.asMap().containsKey(index)?Colors.white.withOpacity(1):lightGreen.withOpacity(0.0), BlendMode.dstATop),
                                            ),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: black.withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );}

                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),



            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-myplant-items-v2")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .where('site',isEqualTo: "bed-room")
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something is wrong"),
                  );
                }
                if(snapshot.hasData) {
                  _documentSnapshot4 =snapshot.data!.docs;
                  _documentSnapshot5=_documentSnapshot4;
                  length2=_documentSnapshot5.length;
                  email2=FirebaseAuth.instance.currentUser!.email;

                  if(_documentSnapshot5.length>0) {
                    chacker2=true;
                  } else{
                    chacker2=false;
                  }

                }




                return Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Visibility(
                              visible: chacker2==false? false : true,
                              child: Text("Bedroom", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),)),
                          length2>4? GestureDetector(
                            onTap:() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(

                                  builder: (builder) => MoreMySite(category1: "bed-room"),
                                ),
                              );
                            },
                            child: Container(
                              child: Text("See all>>", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),),
                            ),
                          ):SizedBox(height: 0,),


                        ],
                      ),
                    ),

                    Visibility(
                      visible: chacker2==false? false : true,
                      child: SizedBox(
                        height: 5.0,

                      ),
                    ),
                    Visibility(
                      visible: chacker2==false? false : true,
                      child: Container(
                        height:  (MediaQuery.of(context).size.width/2)+4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StaggeredGridView.countBuilder(
                            // physics: ScrollPhysics(),
                              physics:  NeverScrollableScrollPhysics(),

                              staggeredTileBuilder: (index) => index==0?StaggeredTile.count(2, 2):(index==1?StaggeredTile.count(1, 1):(index==2?StaggeredTile.count(1, 2):StaggeredTile.count(1, 1))),

                              /*(index) => index % 7 ==0 ?
                          StaggeredTile.count(2, 2) : StaggeredTile.count(1, 1),*/
                              crossAxisCount: 4,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount: 4,
                              itemBuilder: (context, index) {


                                /*DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];*/

                                return GestureDetector(
                                  onTap: () {

                                    _documentSnapshot5.asMap().containsKey(index)? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //builder: (builder) => DetailsPage(plant: plants[index]),
                                        builder: (builder) => MyHouseplantsTabbarPage(plant: plantk= HousePlantMy(

                                          uid: _documentSnapshot5[index].id,
                                          name:_documentSnapshot5[index]['name'],
                                          botanical_name :_documentSnapshot5[index]['botanical-name'],
                                          imagePath:_documentSnapshot5[index]['imagePath'],
                                          category:_documentSnapshot5[index]['category'],
                                          site:_documentSnapshot5[index]['site'],
                                          water_winter:_documentSnapshot5[index]['water_winter'],
                                          water_summer:_documentSnapshot5[index]['water_summer'],
                                          pot:_documentSnapshot5[index]['pot'],
                                          temp_from:_documentSnapshot5[index]['temp_from'],
                                          temp_to:_documentSnapshot5[index]['temp_to'],
                                          auto_taskname:_documentSnapshot5[index]['auto_taskname'],
                                          care: _documentSnapshot5[index]['care'],
                                          light:_documentSnapshot5[index]['light'],
                                          toxic:_documentSnapshot5[index]['toxic'],
                                          drain: _documentSnapshot5[index]['drain'],
                                          fertilizer: _documentSnapshot5[index]['fertilizer'],
                                          list: _documentSnapshot5[index]['water_list'],
                                        )),
                                      ),
                                    ):print("null");

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: black.withOpacity(0.05),
                                          blurRadius: 15,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                      border: Border.all(color: white, width: 1.5),
                                      borderRadius:index==0?BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ):(index==2?BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ):BorderRadius.circular(0.0)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: lightGreen,
                                            boxShadow: [
                                              BoxShadow(
                                                color: black.withOpacity(0.05),
                                                blurRadius: 15,
                                                offset: const Offset(5, 5),
                                              ),
                                            ],
                                            borderRadius: index==0?BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ):(index==2?BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ):BorderRadius.circular(0.0)),
                                            image: DecorationImage(
                                              image: _documentSnapshot5.asMap().containsKey(index)?CachedNetworkImageProvider(_documentSnapshot5[index]['imagePath']):CachedNetworkImageProvider("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(_documentSnapshot5.asMap().containsKey(index)?Colors.white.withOpacity(1):Colors.white.withOpacity(0.0), BlendMode.dstATop),
                                            ),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: black.withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );}

                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),



            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-myplant-items-v2")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .where('site',isEqualTo: "kitchen-room")
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something is wrong"),
                  );
                }
                if(snapshot.hasData) {
                  _documentSnapshot6 =snapshot.data!.docs;
                  _documentSnapshot7=_documentSnapshot6;
                  length3=_documentSnapshot7.length;

                  if(_documentSnapshot7.length>0) {
                    chacker3=true;
                  } else{
                    chacker3=false;
                  }


                }




                return Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Visibility(
                              visible: chacker3==false? false : true,
                              child: Text("Kitchen", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),)),
                          length3>4? GestureDetector(
                            onTap:() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(

                                  builder: (builder) => MoreMySite(category1: "kitchen-room"),
                                ),
                              );
                            },
                            child: Container(
                              child: Text("See all>>", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),),
                            ),
                          ):SizedBox(height: 0,),


                        ],
                      ),
                    ),

                    Visibility(
                      visible: chacker3==false? false : true,
                      child: SizedBox(
                        height: 5.0,

                      ),
                    ),
                    Visibility(
                      visible: chacker3==false? false : true,
                      child: Container(
                        height:  (MediaQuery.of(context).size.width/2)+4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StaggeredGridView.countBuilder(
                            // physics: ScrollPhysics(),
                              physics:  NeverScrollableScrollPhysics(),

                              staggeredTileBuilder: (index) => index==0?StaggeredTile.count(2, 2):(index==1?StaggeredTile.count(1, 1):(index==2?StaggeredTile.count(1, 2):StaggeredTile.count(1, 1))),

                              /*(index) => index % 7 ==0 ?
                          StaggeredTile.count(2, 2) : StaggeredTile.count(1, 1),*/
                              crossAxisCount: 4,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount: 4,
                              itemBuilder: (context, index) {


                                /*DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];*/

                                return GestureDetector(
                                  onTap: () {

                                    _documentSnapshot7.asMap().containsKey(index)? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //builder: (builder) => DetailsPage(plant: plants[index]),
                                        builder: (builder) => MyHouseplantsTabbarPage(plant: plantk= HousePlantMy(

                                          uid: _documentSnapshot7[index].id,
                                          name:_documentSnapshot7[index]['name'],
                                          botanical_name :_documentSnapshot7[index]['botanical-name'],
                                          imagePath:_documentSnapshot7[index]['imagePath'],
                                          category:_documentSnapshot7[index]['category'],
                                          site:_documentSnapshot7[index]['site'],
                                          water_winter:_documentSnapshot7[index]['water_winter'],
                                          water_summer:_documentSnapshot7[index]['water_summer'],
                                          pot:_documentSnapshot7[index]['pot'],
                                          temp_from:_documentSnapshot7[index]['temp_from'],
                                          temp_to:_documentSnapshot7[index]['temp_to'],
                                          auto_taskname:_documentSnapshot7[index]['auto_taskname'],
                                          care: _documentSnapshot7[index]['care'],
                                          light:_documentSnapshot7[index]['light'],
                                          toxic:_documentSnapshot7[index]['toxic'],
                                          drain: _documentSnapshot7[index]['drain'],
                                          fertilizer: _documentSnapshot7[index]['fertilizer'],
                                          list: _documentSnapshot7[index]['water_list'],
                                        )),
                                      ),
                                    ):print(_documentSnapshot7.length.toString());

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: black.withOpacity(0.05),
                                          blurRadius: 15,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                      border: Border.all(color: white, width: 1.5),
                                      borderRadius: index==0?BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ):(index==2?BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ):BorderRadius.circular(0.0)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: lightGreen,
                                            boxShadow: [
                                              BoxShadow(
                                                color: black.withOpacity(0.05),
                                                blurRadius: 15,
                                                offset: const Offset(5, 5),
                                              ),
                                            ],
                                            borderRadius: index==0?BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ):(index==2?BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ):BorderRadius.circular(0.0)),
                                            image: DecorationImage(
                                              image: _documentSnapshot7.asMap().containsKey(index)?CachedNetworkImageProvider(_documentSnapshot7[index]['imagePath']):CachedNetworkImageProvider("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(_documentSnapshot7.asMap().containsKey(index)?Colors.white.withOpacity(1):lightGreen.withOpacity(0.0), BlendMode.dstATop),
                                            ),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: black.withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );}

                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-myplant-items-v2")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .where('site',isEqualTo: "bath-room")
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something is wrong"),
                  );
                }
                if(snapshot.hasData) {
                  _documentSnapshot8 =snapshot.data!.docs;
                  _documentSnapshot9=_documentSnapshot8;
                  length4=_documentSnapshot9.length;

                  if(_documentSnapshot9.length>0) {
                    chacker4=true;
                  } else{
                    chacker4=false;
                  }


                }




                return Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Visibility(
                              visible: chacker4==false? false : true,
                              child: Text("Bathroom", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),)),
                          length4>4? GestureDetector(
                            onTap:() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(

                                  builder: (builder) => MoreMySite(category1: "bath-room"),
                                ),
                              );
                            },
                            child: Container(
                              child: Text("See all>>", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),),
                            ),
                          ):SizedBox(height: 0,),


                        ],
                      ),
                    ),

                    Visibility(
                      visible: chacker4==false? false : true,
                      child: SizedBox(
                        height: 5.0,

                      ),
                    ),
                    Visibility(
                      visible: chacker4==false? false : true,
                      child: Container(
                        height:  (MediaQuery.of(context).size.width/2)+4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StaggeredGridView.countBuilder(
                            // physics: ScrollPhysics(),
                              physics:  NeverScrollableScrollPhysics(),

                              staggeredTileBuilder: (index) => index==0?StaggeredTile.count(2, 2):(index==1?StaggeredTile.count(1, 1):(index==2?StaggeredTile.count(1, 2):StaggeredTile.count(1, 1))),

                              /*(index) => index % 7 ==0 ?
                          StaggeredTile.count(2, 2) : StaggeredTile.count(1, 1),*/
                              crossAxisCount: 4,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount: 4,
                              itemBuilder: (context, index) {


                                /*DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];*/

                                return GestureDetector(
                                  onTap: () {

                                    _documentSnapshot9.asMap().containsKey(index)? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //builder: (builder) => DetailsPage(plant: plants[index]),
                                        builder: (builder) => MyHouseplantsTabbarPage(plant: plantk= HousePlantMy(

                                          uid: _documentSnapshot9[index].id,
                                          name:_documentSnapshot9[index]['name'],
                                          botanical_name :_documentSnapshot9[index]['botanical-name'],
                                          imagePath:_documentSnapshot9[index]['imagePath'],
                                          category:_documentSnapshot9[index]['category'],
                                          site:_documentSnapshot9[index]['site'],
                                          water_winter:_documentSnapshot9[index]['water_winter'],
                                          water_summer:_documentSnapshot9[index]['water_summer'],
                                          pot:_documentSnapshot9[index]['pot'],
                                          temp_from:_documentSnapshot9[index]['temp_from'],
                                          temp_to:_documentSnapshot9[index]['temp_to'],
                                          auto_taskname:_documentSnapshot9[index]['auto_taskname'],
                                          care: _documentSnapshot9[index]['care'],
                                          light:_documentSnapshot9[index]['light'],
                                          toxic:_documentSnapshot9[index]['toxic'],
                                          drain: _documentSnapshot9[index]['drain'],
                                          fertilizer: _documentSnapshot9[index]['fertilizer'],
                                          list: _documentSnapshot9[index]['water_list'],
                                        )),
                                      ),
                                    ):print(_documentSnapshot9.length.toString());

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: black.withOpacity(0.05),
                                          blurRadius: 15,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                      border: Border.all(color: white, width: 1.5),
                                      borderRadius: index==0?BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ):(index==2?BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ):BorderRadius.circular(0.0)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: lightGreen,
                                            boxShadow: [
                                              BoxShadow(
                                                color: black.withOpacity(0.05),
                                                blurRadius: 15,
                                                offset: const Offset(5, 5),
                                              ),
                                            ],
                                            borderRadius: index==0?BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ):(index==2?BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ):BorderRadius.circular(0.0)),
                                            image: DecorationImage(
                                              image: _documentSnapshot9.asMap().containsKey(index)?CachedNetworkImageProvider(_documentSnapshot9[index]['imagePath']):CachedNetworkImageProvider("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(_documentSnapshot9.asMap().containsKey(index)?Colors.white.withOpacity(1):lightGreen.withOpacity(0.0), BlendMode.dstATop),
                                            ),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: black.withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );}

                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-myplant-items-v2")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .where('site',isEqualTo: "belcony-room")
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something is wrong"),
                  );
                }
                if(snapshot.hasData) {
                  _documentSnapshot10 =snapshot.data!.docs;
                  _documentSnapshot11=_documentSnapshot10;
                  length5=_documentSnapshot10.length;

                  if(_documentSnapshot11.length>0) {
                    chacker5=true;
                  } else{
                    chacker5=false;
                  }


                }




                return Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Visibility(
                              visible: chacker5==false? false : true,
                              child: Text("Balcony", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),)),
                          length5>4? GestureDetector(
                            onTap:() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(

                                  builder: (builder) => MoreMySite(category1: "belcony-room"),
                                ),
                              );
                            },
                            child: Container(
                              child: Text("See all>>", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),),
                            ),
                          ):SizedBox(height: 0,),


                        ],
                      ),
                    ),

                    Visibility(
                      visible: chacker5==false? false : true,
                      child: SizedBox(
                        height: 5.0,

                      ),
                    ),
                    Visibility(
                      visible: chacker5==false? false : true,
                      child: Container(
                        height:  (MediaQuery.of(context).size.width/2)+4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StaggeredGridView.countBuilder(
                            // physics: ScrollPhysics(),
                              physics:  NeverScrollableScrollPhysics(),

                              staggeredTileBuilder: (index) => index==0?StaggeredTile.count(2, 2):(index==1?StaggeredTile.count(1, 1):(index==2?StaggeredTile.count(1, 2):StaggeredTile.count(1, 1))),

                              /*(index) => index % 7 ==0 ?
                          StaggeredTile.count(2, 2) : StaggeredTile.count(1, 1),*/
                              crossAxisCount: 4,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount: 4,
                              itemBuilder: (context, index) {


                                /*DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];*/

                                return GestureDetector(
                                  onTap: () {

                                    _documentSnapshot11.asMap().containsKey(index)? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //builder: (builder) => DetailsPage(plant: plants[index]),
                                        builder: (builder) => MyHouseplantsTabbarPage(plant: plantk= HousePlantMy(

                                          uid: _documentSnapshot11[index].id,
                                          name:_documentSnapshot11[index]['name'],
                                          botanical_name :_documentSnapshot11[index]['botanical-name'],
                                          imagePath:_documentSnapshot11[index]['imagePath'],
                                          category:_documentSnapshot11[index]['category'],
                                          site:_documentSnapshot11[index]['site'],
                                          water_winter:_documentSnapshot11[index]['water_winter'],
                                          water_summer:_documentSnapshot11[index]['water_summer'],
                                          pot:_documentSnapshot11[index]['pot'],
                                          temp_from:_documentSnapshot11[index]['temp_from'],
                                          temp_to:_documentSnapshot11[index]['temp_to'],
                                          auto_taskname:_documentSnapshot11[index]['auto_taskname'],
                                          care: _documentSnapshot11[index]['care'],
                                          light:_documentSnapshot11[index]['light'],
                                          toxic:_documentSnapshot11[index]['toxic'],
                                          drain: _documentSnapshot11[index]['drain'],
                                          fertilizer: _documentSnapshot11[index]['fertilizer'],
                                          list: _documentSnapshot11[index]['water_list'],
                                        )),
                                      ),
                                    ):print(_documentSnapshot11.length.toString());

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: black.withOpacity(0.05),
                                          blurRadius: 15,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                      border: Border.all(color: white, width: 1.5),
                                      borderRadius: index==0?BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ):(index==2?BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ):BorderRadius.circular(0.0)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: lightGreen,
                                            boxShadow: [
                                              BoxShadow(
                                                color: black.withOpacity(0.05),
                                                blurRadius: 15,
                                                offset: const Offset(5, 5),
                                              ),
                                            ],
                                            borderRadius: index==0?BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ):(index==2?BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ):BorderRadius.circular(0.0)),
                                            image: DecorationImage(
                                              image: _documentSnapshot11.asMap().containsKey(index)?CachedNetworkImageProvider(_documentSnapshot11[index]['imagePath']):CachedNetworkImageProvider("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(_documentSnapshot11.asMap().containsKey(index)?Colors.white.withOpacity(1):lightGreen.withOpacity(0.0), BlendMode.dstATop),
                                            ),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: black.withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );}

                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-myplant-items-v2")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .where('site',isEqualTo: "terrace-room")
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something is wrong"),
                  );
                }
                if(snapshot.hasData) {
                  _documentSnapshot12 =snapshot.data!.docs;
                  _documentSnapshot13=_documentSnapshot12;
                  length6=_documentSnapshot13.length;

                  if(_documentSnapshot13.length>0) {
                    chacker6=true;
                  } else{
                    chacker6=false;
                  }


                }




                return Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Visibility(
                              visible: chacker6==false? false : true,
                              child: Text("Terrace", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),)),
                          length6>4? GestureDetector(
                            onTap:() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(

                                  builder: (builder) => MoreMySite(category1: "terrace-room"),
                                ),
                              );
                            },
                            child: Container(
                              child: Text("See all>>", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),),
                            ),
                          ):SizedBox(height: 0,),


                        ],
                      ),
                    ),

                    Visibility(
                      visible: chacker6==false? false : true,
                      child: SizedBox(
                        height: 5.0,

                      ),
                    ),
                    Visibility(
                      visible: chacker6==false? false : true,
                      child: Container(
                        height:  (MediaQuery.of(context).size.width/2)+4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StaggeredGridView.countBuilder(
                            // physics: ScrollPhysics(),
                              physics:  NeverScrollableScrollPhysics(),

                              staggeredTileBuilder: (index) => index==0?StaggeredTile.count(2, 2):(index==1?StaggeredTile.count(1, 1):(index==2?StaggeredTile.count(1, 2):StaggeredTile.count(1, 1))),

                              /*(index) => index % 7 ==0 ?
                          StaggeredTile.count(2, 2) : StaggeredTile.count(1, 1),*/
                              crossAxisCount: 4,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount: 4,
                              itemBuilder: (context, index) {


                                /*DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];*/

                                return GestureDetector(
                                  onTap: () {

                                    _documentSnapshot13.asMap().containsKey(index)? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //builder: (builder) => DetailsPage(plant: plants[index]),
                                        builder: (builder) => MyHouseplantsTabbarPage(plant: plantk= HousePlantMy(

                                          uid: _documentSnapshot13[index].id,
                                          name:_documentSnapshot13[index]['name'],
                                          botanical_name :_documentSnapshot13[index]['botanical-name'],
                                          imagePath:_documentSnapshot13[index]['imagePath'],
                                          category:_documentSnapshot13[index]['category'],
                                          site:_documentSnapshot13[index]['site'],
                                          water_winter:_documentSnapshot13[index]['water_winter'],
                                          water_summer:_documentSnapshot13[index]['water_summer'],
                                          pot:_documentSnapshot13[index]['pot'],
                                          temp_from:_documentSnapshot13[index]['temp_from'],
                                          temp_to:_documentSnapshot13[index]['temp_to'],
                                          auto_taskname:_documentSnapshot13[index]['auto_taskname'],
                                          care: _documentSnapshot13[index]['care'],
                                          light:_documentSnapshot13[index]['light'],
                                          toxic:_documentSnapshot13[index]['toxic'],
                                          drain: _documentSnapshot13[index]['drain'],
                                          fertilizer: _documentSnapshot13[index]['fertilizer'],
                                          list: _documentSnapshot13[index]['water_list'],
                                        )),
                                      ),
                                    ):print(_documentSnapshot13.length.toString());

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: black.withOpacity(0.05),
                                          blurRadius: 15,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                      border: Border.all(color: white, width: 1.5),
                                      borderRadius: index==0?BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ):(index==2?BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ):BorderRadius.circular(0.0)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: lightGreen,
                                            boxShadow: [
                                              BoxShadow(
                                                color: black.withOpacity(0.05),
                                                blurRadius: 15,
                                                offset: const Offset(5, 5),
                                              ),
                                            ],
                                            borderRadius: index==0?BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ):(index==2?BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ):BorderRadius.circular(0.0)),
                                            image: DecorationImage(
                                              image: _documentSnapshot13.asMap().containsKey(index)?CachedNetworkImageProvider(_documentSnapshot13[index]['imagePath']):CachedNetworkImageProvider("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(_documentSnapshot13.asMap().containsKey(index)?Colors.white.withOpacity(1):lightGreen.withOpacity(0.0), BlendMode.dstATop),
                                            ),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: black.withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );}

                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-myplant-items-v2")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .where('site',isEqualTo: "office-room")
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something is wrong"),
                  );
                }
                if(snapshot.hasData) {
                  _documentSnapshot14 =snapshot.data!.docs;
                  _documentSnapshot15=_documentSnapshot14;
                  length7=_documentSnapshot15.length;

                  if(_documentSnapshot15.length>0) {
                    chacker7=true;
                  } else{
                    chacker7=false;
                  }


                }




                return Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Visibility(
                              visible: chacker7==false? false : true,
                              child: Text("Office", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),)),
                          length7>4? GestureDetector(
                            onTap:() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(

                                  builder: (builder) => MoreMySite(category1: "office-room"),
                                ),
                              );
                            },
                            child: Container(
                              child: Text("See all>>", style: TextStyle(fontWeight: FontWeight.w100,fontSize: 17,color: Colors.black54),),
                            ),
                          ):SizedBox(height: 0,),


                        ],
                      ),
                    ),

                    Visibility(
                      visible: chacker7==false? false : true,
                      child: SizedBox(
                        height: 5.0,

                      ),
                    ),
                    Visibility(
                      visible: chacker7==false? false : true,
                      child: Container(
                        height:  (MediaQuery.of(context).size.width/2)+4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StaggeredGridView.countBuilder(
                            // physics: ScrollPhysics(),
                              physics:  NeverScrollableScrollPhysics(),

                              staggeredTileBuilder: (index) => index==0?StaggeredTile.count(2, 2):(index==1?StaggeredTile.count(1, 1):(index==2?StaggeredTile.count(1, 2):StaggeredTile.count(1, 1))),

                              /*(index) => index % 7 ==0 ?
                          StaggeredTile.count(2, 2) : StaggeredTile.count(1, 1),*/
                              crossAxisCount: 4,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount: 4,
                              itemBuilder: (context, index) {


                                /*DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];*/

                                return GestureDetector(
                                  onTap: () {

                                    _documentSnapshot15.asMap().containsKey(index)? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //builder: (builder) => DetailsPage(plant: plants[index]),
                                        builder: (builder) => MyHouseplantsTabbarPage(plant: plantk= HousePlantMy(

                                          uid: _documentSnapshot15[index].id,
                                          name:_documentSnapshot15[index]['name'],
                                          botanical_name :_documentSnapshot15[index]['botanical-name'],
                                          imagePath:_documentSnapshot15[index]['imagePath'],
                                          category:_documentSnapshot15[index]['category'],
                                          site:_documentSnapshot15[index]['site'],
                                          water_winter:_documentSnapshot15[index]['water_winter'],
                                          water_summer:_documentSnapshot15[index]['water_summer'],
                                          pot:_documentSnapshot15[index]['pot'],
                                          temp_from:_documentSnapshot15[index]['temp_from'],
                                          temp_to:_documentSnapshot15[index]['temp_to'],
                                          auto_taskname:_documentSnapshot15[index]['auto_taskname'],
                                          care: _documentSnapshot15[index]['care'],
                                          light:_documentSnapshot15[index]['light'],
                                          toxic:_documentSnapshot15[index]['toxic'],
                                          drain: _documentSnapshot15[index]['drain'],
                                          fertilizer: _documentSnapshot15[index]['fertilizer'],
                                          list: _documentSnapshot15[index]['water_list'],
                                        )),
                                      ),
                                    ):print(_documentSnapshot15.length.toString());

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: black.withOpacity(0.05),
                                          blurRadius: 15,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                      border: Border.all(color: white, width: 1.5),
                                      borderRadius: index==0?BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ):(index==2?BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ):BorderRadius.circular(0.0)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: lightGreen,
                                            boxShadow: [
                                              BoxShadow(
                                                color: black.withOpacity(0.05),
                                                blurRadius: 15,
                                                offset: const Offset(5, 5),
                                              ),
                                            ],
                                            borderRadius: index==0?BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ):(index==2?BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ):BorderRadius.circular(0.0)),
                                            image: DecorationImage(
                                              image: _documentSnapshot15.asMap().containsKey(index)?CachedNetworkImageProvider(_documentSnapshot15[index]['imagePath']):CachedNetworkImageProvider("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(_documentSnapshot15.asMap().containsKey(index)?Colors.white.withOpacity(1):lightGreen.withOpacity(0.0), BlendMode.dstATop),
                                            ),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: black.withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );}

                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),



          //////














            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-myplant-items-v2")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something is wrong"),
                  );
                }
                if(snapshot.hasData) {
                  if(snapshot.data!.docs.isNotEmpty) {
                    istree=true;
                  } else {
                    istree=false;
                  }
                }



                return !istree?Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: MediaQuery.of(context).size.width*0.3,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),

                          image: DecorationImage(
                              opacity: 0.9,

                              image: AssetImage("assets/images/notree.png"),
                              fit: BoxFit.cover),

                          borderRadius: BorderRadius.circular(32),


                        ),
                      ),
                    ),

                    Text("No trees in your garden. Add some.", style: TextStyle(fontWeight: FontWeight.normal,letterSpacing: 1,fontSize: 12),),
                  ],
                ):SizedBox(height: 0,);
              },
            ),



          ],
        ),
      ),

    );
  }


  int selectId = 0;
  int activePage = 0;
}
