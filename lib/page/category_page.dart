import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/page/test_page.dart';
import '../data/plant_model_firestore.dart';

class CategoryAll extends StatefulWidget {
  final String category1;
  final String category2;
  const CategoryAll({Key? key, required this.category1, required this.category2}) : super(key: key);

  @override
  _CategoryAllState createState() => _CategoryAllState();
}

class _CategoryAllState extends State<CategoryAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(widget.category2, style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,

      ),

      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("products-v2")
              .where('category',isEqualTo: widget.category1)
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
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(

                            builder: (builder) => DetailsPage2(plant: PlantF(
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
                      child:Card(
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

                  /*Card(
                  elevation: 0.4,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_documentSnapshot['images']),
                    ),
                    title: Text(
                      _documentSnapshot['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
                    ),
                    subtitle: Text("\$ ${_documentSnapshot['price']}"),
                    trailing: GestureDetector(
                      child: CircleAvatar(
                        child: Icon(Icons.cancel_outlined),
                      ),
                      onTap: () {
                      },
                    ),
                  ),
                );*/
                });

          },
        ),
      ),



      /*   Container(
              child: StaggeredGridView.countBuilder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                staggeredTileBuilder: (index) => index % 7 ==0 ?
                StaggeredTile.count(2, 2) : StaggeredTile.count(1, 1),
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: plants.length,
                itemBuilder: (context, index) => mainPlantsCard(index),

              ),
            ),
            SizedBox(height: 50,)*//*

          ],

//
        ),
        //
      ),*/
    );
  }
}
