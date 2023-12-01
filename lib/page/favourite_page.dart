import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/page/test_page.dart';
import '../core/color.dart';
import '../data/plant_model_firestore.dart';


class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot2=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot3=[];
  var list=[];
  bool check=false;

  fatchtask () async{
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance
        .collection("users-favourite-items-v2").doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .get();

    _documentSnapshot=qn.docs;
    print(_documentSnapshot);



    setState(() {
      check=true;
    });




    return qn.docs;

  }
  @override
  void initState() {
    fatchtask();
    super.initState();


    //currentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text("Favourite", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,

      ),

      body: Container(
        child:check==false?Center(child: CircularProgressIndicator()): StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("products-v2")
              .where('isFavorit',isEqualTo: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something is wrong"),
              );
            }
            if(snapshot.hasData) {
              _documentSnapshot3.clear();
              list.clear();
              _documentSnapshot2=snapshot.data!.docs;
              for(int i=0;i<_documentSnapshot2.length;i++){
                for(int b=0;b<_documentSnapshot.length;b++) {
                  if((_documentSnapshot2[i]['id']==_documentSnapshot[b]['id'])
                      && (_documentSnapshot2[i]['name']==_documentSnapshot[b]['name'])
                      && (_documentSnapshot2[i]['category']==_documentSnapshot[b]['category'])) {
                    _documentSnapshot3.add(_documentSnapshot2[i]);
                    list.add(_documentSnapshot[b].id);
                  }
                }
              }

            }



            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:_documentSnapshot3.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot4 =
                  _documentSnapshot3[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(

                            builder: (builder) => DetailsPage2(plant: PlantF(
                              id:_documentSnapshot4['id'],
                              name:_documentSnapshot4['name'],
                              botanical_name: _documentSnapshot4['botanical-name'],
                              imagePath:_documentSnapshot4['imagePath'],
                              category:_documentSnapshot4['category'],
                              care: _documentSnapshot4['care'],
                              description:_documentSnapshot4['description'],
                              water_winter: _documentSnapshot4['water-winter'],
                              water_summer: _documentSnapshot4['water-summer'],
                              fertilizer: _documentSnapshot4['fertilizer'],
                              temp_from: _documentSnapshot4['temp-from'],
                              temp_to: _documentSnapshot4['temp-to'],
                              price:_documentSnapshot4['price'],
                              isFavorit:_documentSnapshot4['isFavorit'],

                              light:_documentSnapshot4['light'],
                              toxic:_documentSnapshot4['toxic'],

                            )),
                          ),
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,

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
                                            _documentSnapshot4["imagePath"]),
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
                                    Text(_documentSnapshot4['name'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          ' ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
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
                                              fontWeight: FontWeight.bold, fontSize: 20),
                                        ),
                                        Text(
                                          _documentSnapshot4['price'].toString()+"TK",
                                          style: TextStyle(fontSize: 20),
                                        )
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                          onPressed: (){
                                            FirebaseFirestore.instance
                                                .collection("users-favourite-items-v2").doc(FirebaseAuth.instance.currentUser!.email)
                                                .collection("items")
                                                .doc(list[index])
                                                .delete().then((value) {
                                                  _documentSnapshot3.removeAt(index);
                                                  list.removeAt(index);
                                                  fatchtask();
                                            });
                                            print(list[index]);
                                            
                                          }, child: Text("Delete", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
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