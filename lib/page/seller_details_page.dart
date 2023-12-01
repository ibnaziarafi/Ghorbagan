import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/data/seller_model.dart';
import 'package:ui_13/page/add_to_cart2_page.dart';
import 'package:ui_13/page/seller_plant_page.dart';
import 'package:ui_13/page/tools_and_soil_page.dart';

import '../data/plant_model_firestore.dart';

class SellerDetails extends StatefulWidget {
  final Seller seller;

  const SellerDetails({Key? key, required this.seller}) : super(key: key);

  @override
  State<SellerDetails> createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  PageController controller = PageController();
  late PlantF plantk;
  @override
  void initState() {
    controller = PageController(viewportFraction: 0.6, initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Plants', 'Tools & soil'];
    bool emptyListcheck=false;
    return DefaultTabController(
      length: tabs.length, // This is the number of tabs.
      child: Scaffold(
        backgroundColor: white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverAppBar(

                // This is the title in the app bar.
                elevation: 0,
                expandedHeight: MediaQuery.of(context).size.width*0.4,

                forceElevated: innerBoxIsScrolled,
                pinned: true,
                stretch: true,

                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: <StretchMode>[
                    StretchMode.zoomBackground
                  ],
                  title: Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(widget.seller.name+" store", textAlign:TextAlign.center,maxLines:1,style: TextStyle(color: tabcolor1.withOpacity(0.9), fontWeight:FontWeight.bold,fontSize: 16),),
                    ),
                  ),
                  centerTitle: true,
                  background:  Container(
                    //height: MediaQuery.of(context).size.width*0.4,
                    decoration: BoxDecoration(
                      color: lightGreen,
                      boxShadow: [
                        BoxShadow(
                          color: green.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        colorFilter:
                        ColorFilter.mode(Colors.black.withOpacity(0.15),
                            BlendMode.darken),
                        image: CachedNetworkImageProvider(widget.seller.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(child: Text("")),
                  ),
                ),
                backgroundColor: white,
              ),
              /*FlexibleSpaceBar(
                background: Container(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width*0.4,
                        decoration: BoxDecoration(
                          color: lightGreen,
                          boxShadow: [
                            BoxShadow(
                              color: green.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                          ),
                          image: DecorationImage(
                            colorFilter:
                            ColorFilter.mode(Colors.black.withOpacity(0.15),
                                BlendMode.darken),
                            image: NetworkImage(widget.seller.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 3.8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(widget.seller.name+" store",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontWeight: FontWeight.bold,color: tabcolor1, fontSize: 20),),
                                  ),
                                  Text("(1000+)", overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/

              SliverPadding(
                padding: new EdgeInsets.all(0.0),
                sliver: new SliverList(
                  delegate: new SliverChildListDelegate([
                    TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        new Tab( text: "Plants", ),
                        new Tab(
                            text: "Tools & soil"),
                      ],
                    ),
                  ]),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: [
              SellerPlantDetails(seller: widget.seller),
              ToolsAndSoil(seller: widget.seller),

            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users-item-listing")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("items").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Text("");
                  }
                  if(snapshot.hasData) {
                    emptyListcheck=snapshot.data!.docs.length!=0?true:false;




                  }

                  return emptyListcheck==false?SizedBox():ElevatedButton(

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(

                          builder: (builder) => AddToCart2(),
                        ),
                      );

                    },
                    /*${widget.plant.price}*/
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Checkout cart', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(tabcolor1.withOpacity(0.6)),
                      overlayColor: MaterialStateProperty.all(tabcolor2.withOpacity(0.7)),
                    ),
                  );
                }),

          ],
        ),
      ),
    );
  }
  int selectId = 0;
  int activePage = 0;
}
