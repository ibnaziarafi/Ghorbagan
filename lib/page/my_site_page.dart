import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/page/my_houseplants_tabbar_details_page.dart';
import '../data/plant_model_firestore.dart';

class MySite extends StatefulWidget {
  const MySite({Key? key}) : super(key: key);

  @override
  State<MySite> createState() => _MySiteState();
}

class _MySiteState extends State<MySite> {
  PageController controller = PageController();
  late PlantF plantk;
  bool istree=true;
  @override
  void initState() {
    controller = PageController(viewportFraction: 0.6, initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      body: StreamBuilder(
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



          return !istree?SingleChildScrollView(
            child: Column(
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
            ),
          ):ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount:
              snapshot.data == null ? 0 : snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot _documentSnapshot =
                snapshot.data!.docs[index];



                return Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //builder: (builder) => DetailsPage(plant: plants[index]),
                          builder: (builder) => MyHouseplantsTabbarPage(plant:  HousePlantMy(

                            uid: _documentSnapshot.id,
                            name:_documentSnapshot['name'],
                            botanical_name :_documentSnapshot['botanical-name'],
                            imagePath:_documentSnapshot['imagePath'],
                            category:_documentSnapshot['category'],
                            site:_documentSnapshot['site'],
                            water_winter:_documentSnapshot['water_winter'],
                            water_summer:_documentSnapshot['water_summer'],
                            pot:_documentSnapshot['pot'],
                            temp_from:_documentSnapshot['temp_from'],
                            temp_to:_documentSnapshot['temp_to'],
                            auto_taskname:_documentSnapshot['auto_taskname'],
                            care: _documentSnapshot['care'],
                            light:_documentSnapshot['light'],
                            toxic:_documentSnapshot['toxic'],
                            drain: _documentSnapshot['drain'],
                            fertilizer: _documentSnapshot['fertilizer'],
                            list: _documentSnapshot['water_list'],
                          )),
                        ),
                      );
                    },
                    child: Container(
                      width: 200.0,
                      margin: const EdgeInsets.only(right: 0, bottom: 0),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(_documentSnapshot['imagePath']),
                        ),
                        title: Text(
                          _documentSnapshot['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,color: Colors.black45, fontSize: 18),
                        ),
                        subtitle: Text(" ${_documentSnapshot['botanical-name']}"),
                        trailing: Icon(Icons.arrow_right),
                      ),
                    ),
                  ),
                );

              });
        },
      ),


    );
  }

  int selectId = 0;
  int activePage = 0;
}
