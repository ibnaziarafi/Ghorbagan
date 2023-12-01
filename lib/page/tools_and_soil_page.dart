import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/data/seller_model.dart';
import '../data/plant_model_firestore.dart';
import 'accessories_details_page.dart';

class ToolsAndSoil extends StatefulWidget {
  final Seller seller;

  const ToolsAndSoil({Key? key, required this.seller}) : super(key: key);

  @override
  State<ToolsAndSoil> createState() => _ToolsAndSoilState();
}

class _ToolsAndSoilState extends State<ToolsAndSoil> {
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
            .collection("products-accessories")

            .where('id',isEqualTo: widget.seller.id)
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
                          builder: (builder) => DetailsPage3(plant: plantk= PlantF(
                            id:_documentSnapshot['id'],
                            name:_documentSnapshot['name'],
                            botanical_name: "",
                            imagePath:_documentSnapshot['imagePath'],
                            category:_documentSnapshot['category'],
                            care: "",
                            description:_documentSnapshot['description'],
                            water_winter: 0,
                            water_summer: 0,
                            fertilizer: 0,
                            temp_from: 0,
                            temp_to: 0,
                            price:_documentSnapshot['price'],
                            isFavorit:_documentSnapshot['isFavorit'],

                            light:"",
                            toxic:"",
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
                                        _documentSnapshot['category'],
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

                                          child: Text("")),
                                        TextButton(

                                          onPressed: null,
                                          child: Text("")),
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
