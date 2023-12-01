import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_13/data/plant_model_firestore.dart';
import 'package:ui_13/page/image_detection_plantnet_page.dart';
import 'package:ui_13/page/test_page.dart';

import '../core/color.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";
  List testList=[];
  String testinput='';
  String testinput2='';
  late PlantF plantk;
  String str='';
  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45.0,
                    width: h-(h*0.24),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: green),
                      boxShadow: [
                        BoxShadow(
                          color: green.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: 45,
                            width: h-(h*0.4),
                            child: TextFormField(

                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                              ),

                              onChanged: (val) {
                                setState(() {
                                  inputText = val.toLowerCase();

                                  print(inputText);

                                });
                              },
                            )
                        ),
                        Image.asset(
                          'assets/icons/search.png',
                          height: 25,
                        )
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => ImageDetectPN(),
                        ),
                      );
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: tabcolor1.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(FontAwesomeIcons.camera, color: Colors.white,)
                    ),
                  ),
                ],
              ),
            ),
           
            Expanded(
              child: Container(
                child: inputText.length ==0?StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products-v2")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Something went wrong"),
                        );
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading"),
                        );
                      }

                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //builder: (builder) => DetailsPage(plant: plants[index]),
                                  builder: (builder) => DetailsPage2(plant: plantk= PlantF(
                                    id:data['id'],
                                    name:data['name'],
                                    botanical_name: data['botanical-name'],
                                    imagePath:data['imagePath'],
                                    category:data['category'],
                                    care: data['care'],
                                    description:data['description'],
                                    water_winter: data['water-winter'],
                                    water_summer: data['water-summer'],
                                    fertilizer: data['fertilizer'],
                                    temp_from: data['temp-from'],
                                    temp_to: data['temp-to'],
                                    price:data['price'],
                                    isFavorit:data['isFavorit'],

                                    light:data['light'],
                                    toxic:data['toxic'],
                                  )),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
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
                                                    data['imagePath']),
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
                                            Text(data['name'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 20.0, fontWeight: FontWeight.bold, color: tabcolor1)),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  data['botanical-name'],
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
                                                  data['price'].toString()+"TK",
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
                                                        child: Text(data['care'], style: TextStyle(color: tabcolor1),),
                                                      ),
                                                    ),),
                                                  TextButton(
                                                    onPressed: null,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: data['toxic']=="toxic"?Colors.redAccent.withOpacity(0.15):tabcolor2.withOpacity(0.25),

                                                        borderRadius: const BorderRadius.only(
                                                          bottomLeft: Radius.circular(12),
                                                          bottomRight: Radius.circular(12),
                                                          topRight: Radius.circular(12),
                                                          topLeft: Radius.circular(12),
                                                        ),

                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(6.0),
                                                        child: Text(data['toxic']=="toxic"?"Toxic":"Non Toxic", style: TextStyle(color: data['toxic']=="toxic"?Colors.red.shade900:tabcolor1),),
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
                        }).toList(),
                      );
                    }):StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products-v2")
                        .where("searchItems",arrayContains: inputText)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Something went wrong"),
                        );
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading"),
                        );
                      }

                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //builder: (builder) => DetailsPage(plant: plants[index]),
                                  builder: (builder) => DetailsPage2(plant: plantk= PlantF(
                                    id:data['id'],
                                    name:data['name'],
                                    botanical_name: data['botanical-name'],
                                    imagePath:data['imagePath'],
                                    category:data['category'],
                                    care: data['care'],
                                    description:data['description'],
                                    water_winter: data['water-winter'],
                                    water_summer: data['water-summer'],
                                    fertilizer: data['fertilizer'],
                                    temp_from: data['temp-from'],
                                    temp_to: data['temp-to'],
                                    price:data['price'],
                                    isFavorit:data['isFavorit'],

                                    light:data['light'],
                                    toxic:data['toxic'],
                                  )),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
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
                                                    data['imagePath']),
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
                                            Text(data['name'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 20.0, fontWeight: FontWeight.bold, color: tabcolor1)),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  data['botanical-name'],
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
                                                  data['price'].toString()+"TK",
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
                                                        child: Text(data['care'], style: TextStyle(color: tabcolor1),),
                                                      ),
                                                    ),),
                                                  TextButton(
                                                    onPressed: null,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: data['toxic']=="toxic"?Colors.redAccent.withOpacity(0.15):tabcolor2.withOpacity(0.25),

                                                        borderRadius: const BorderRadius.only(
                                                          bottomLeft: Radius.circular(12),
                                                          bottomRight: Radius.circular(12),
                                                          topRight: Radius.circular(12),
                                                          topLeft: Radius.circular(12),
                                                        ),

                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(6.0),
                                                        child: Text(data['toxic']=="toxic"?"Toxic":"Non Toxic", style: TextStyle(color: data['toxic']=="toxic"?Colors.red.shade900:tabcolor1),),
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
                        }).toList(),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}