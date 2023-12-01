import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/widgets/add_to_houseplants_details_auto.dart';
import '../core/color.dart';
import '../data/plant_model_firestore.dart';

class AddhouseplantsList extends StatefulWidget {
  @override
  _AddhouseplantsListState createState() => _AddhouseplantsListState();
}

class _AddhouseplantsListState extends State<AddhouseplantsList> {
  var inputText = "";
  late HousePlantL plantk;
  List<String> test=[];
  List<List<String>> testa=[["dd",'dd',"dd"],["dd","ddd"]];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot2=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot3=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    _documentSnapshot3.clear();
                    inputText = val.toLowerCase();

                    for(int i=0;i<_documentSnapshot2.length;i++) {
                      if(_documentSnapshot2[i]['name'].contains(inputText)){
                        _documentSnapshot3.add(_documentSnapshot2[i]);
                      }
                    }

                    print(inputText);

                  });
                },
              ),
              Expanded(
                child: Container(
                  child: inputText.length ==0?StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("houseplant-v3")
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
                        if(snapshot.hasData) {
                          _documentSnapshot2=snapshot.data!.docs;
                          for(int i=0;i<snapshot.data!.docs.length;i++) {
                            print(snapshot.data!.docs[i]['imagePath']);
                          }
                          print(testa);
                        }

                        return ListView(
                          shrinkWrap: true,
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
                                    builder: (builder) => MyhouseplantAddDetailspage(plant: HousePlantL(
                                        name: data['name'],
                                        botanical_name: data['botanical-name'],
                                        imagePath: data['imagePath'],
                                        category: data['category'],
                                        care: data['care'],
                                        water_winter: data['water-winter'],
                                        water_summer: data['water-summer'],
                                        fertilizer: data['fertilizer'],
                                        temp_from: data['temp-from'],
                                        temp_to: data['temp-to'],
                                        light: data['light'],
                                        toxic: data['toxic'])),
                                  ),
                                );
                              },
                              child:  Card(
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
                            );
                          }).toList(),
                        );
                        /*SizedBox(
                          height: MediaQuery.of(context).size.width*0.26,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.width*0.25,
                                    width: MediaQuery.of(context).size.width*0.25,
                                    decoration: BoxDecoration(
                                      color: lightGreen,

                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(data['imagePath']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  ListTile(
                                    title: Text(data['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                                    subtitle: Text(data['botanical-name']),
                                  ),
                                ],
                              ),
                              SizedBox()
                            ],
                          ),
                        ),*/

                      }):ListView.builder(
                    //physics: const ClampingScrollPhysics(),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _documentSnapshot3.length,
                      itemBuilder: (_, index) {


                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //builder: (builder) => DetailsPage(plant: plants[index]),
                                  builder: (builder) => MyhouseplantAddDetailspage(plant: HousePlantL(
                                      name: _documentSnapshot3[index]['name'],
                                      botanical_name: _documentSnapshot3[index]['botanical-name'],
                                      imagePath: _documentSnapshot3[index]['imagePath'],
                                      category: _documentSnapshot3[index]['category'],
                                      care: _documentSnapshot3[index]['care'],
                                      water_winter: _documentSnapshot3[index]['water-winter'],
                                      water_summer: _documentSnapshot3[index]['water-summer'],
                                      fertilizer: _documentSnapshot3[index]['fertilizer'],
                                      temp_from: _documentSnapshot3[index]['temp-from'],
                                      temp_to: _documentSnapshot3[index]['temp-to'],
                                      light: _documentSnapshot3[index]['light'],
                                      toxic: _documentSnapshot3[index]['toxic'])),
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
                                                  _documentSnapshot3[index]['imagePath']),
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
                                          Text(_documentSnapshot3[index]['name'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 20.0, fontWeight: FontWeight.bold, color: tabcolor1)),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                _documentSnapshot3[index]['botanical-name'],
                                              ),
                                              Text(
                                                "",
                                                style: TextStyle(fontSize: 15.0),
                                              ),
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
                                                        child: Text(_documentSnapshot3[index]['care'], style: TextStyle(color: tabcolor1),),
                                                      ),
                                                    ),),
                                                TextButton(
                                                    onPressed: null,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: _documentSnapshot3[index]['toxic']=="toxic"?Colors.redAccent.withOpacity(0.15):tabcolor2.withOpacity(0.25),

                                                        borderRadius: const BorderRadius.only(
                                                          bottomLeft: Radius.circular(12),
                                                          bottomRight: Radius.circular(12),
                                                          topRight: Radius.circular(12),
                                                          topLeft: Radius.circular(12),
                                                        ),

                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(6.0),
                                                        child: Text(_documentSnapshot3[index]['toxic']=="toxic"?"Toxic":"Non Toxic", style: TextStyle(color: _documentSnapshot3[index]['toxic']=="toxic"?Colors.red.shade900:tabcolor1),),
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

                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}