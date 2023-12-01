import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/data/seller_model.dart';
import 'package:ui_13/page/test_page.dart';

import '../data/plant_model_firestore.dart';

class SellerPlantDetails extends StatefulWidget {
  final Seller seller;

  const SellerPlantDetails({Key? key, required this.seller}) : super(key: key);

  @override
  State<SellerPlantDetails> createState() => _SellerPlantDetailsState();
}

class _SellerPlantDetailsState extends State<SellerPlantDetails> {
  PageController controller = PageController();
  late PlantF plantk;
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
            .collection("products-v2")
            .where('id',isEqualTo: widget.seller.id)
            .where('isFavorit',isEqualTo: true)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something is wrong"),
            );
          }



          return ListView.builder(
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
                          builder: (builder) => DetailsPage2(plant: plantk= PlantF(
                            id:_documentSnapshot['id'],
                            name:_documentSnapshot['name'],
                            botanical_name: _documentSnapshot['botanical-name'],
                            imagePath:_documentSnapshot['imagePath'],
                            category:_documentSnapshot['category'],
                            care: _documentSnapshot['care'],
                            description:_documentSnapshot['description'],
                            water_winter: _documentSnapshot['water-winter'],
                            water_summer: _documentSnapshot['water-summer'],
                            fertilizer: _documentSnapshot['fertilizer'],
                            temp_from: _documentSnapshot['temp-from'],
                            temp_to: _documentSnapshot['temp-to'],
                            price:_documentSnapshot['price'],
                            isFavorit:_documentSnapshot['isFavorit'],

                            light:_documentSnapshot['light'],
                            toxic:_documentSnapshot['toxic'],
                          )),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 01,

                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.all(0),
                        child: Row(children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          _documentSnapshot['imagePath']),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 14,
                            child: Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(_documentSnapshot['name'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20.0, fontWeight: FontWeight.bold, color: tabcolor1)),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        _documentSnapshot['botanical-name'],
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Price : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,),
                                      ),
                                      Text(
                                        _documentSnapshot['price'].toString()+"TK",
                                        style: TextStyle(),
                                      )
                                    ],
                                  ),

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          onPressed: null,

                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: tabcolor2.withOpacity(0.25),

                                              borderRadius: const BorderRadius.only(
                                                bottomLeft: Radius.circular(12),
                                                bottomRight: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                topLeft: Radius.circular(12),
                                              ),

                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Text(_documentSnapshot['care'], style: TextStyle(color: tabcolor1),),
                                            ),
                                          ),),
                                        TextButton(
                                          onPressed: null,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _documentSnapshot['toxic']=="toxic"?Colors.redAccent.withOpacity(0.15):tabcolor2.withOpacity(0.25),

                                              borderRadius: const BorderRadius.only(
                                                bottomLeft: Radius.circular(12),
                                                bottomRight: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                topLeft: Radius.circular(12),
                                              ),

                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Text(_documentSnapshot['toxic']=="toxic"?"Toxic":"Non Toxic", style: TextStyle(color: _documentSnapshot['toxic']=="toxic"?Colors.red.shade900:tabcolor1),),
                                            ),
                                          ),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
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
