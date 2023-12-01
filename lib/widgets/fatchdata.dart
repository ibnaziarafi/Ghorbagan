import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/core/color.dart';

import '../data/plant_model_firestore.dart';
import '../page/test_page.dart';

Widget fetchData (String collectionName){

  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
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



      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount:
          snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot =
            snapshot.data!.docs[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder: (builder) => DetailsPage(plant: plants[index]),
                    builder: (builder) => DetailsPage2(plant:  PlantF(
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
                elevation: 0.2,
                //color: lightGreen,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_documentSnapshot['imagePath']),
                  ),
                  title: Text(
                    _documentSnapshot['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 18),
                  ),
                  subtitle: Text("\$ ${_documentSnapshot['price']}"),
                  trailing: GestureDetector(
                    child: Icon(Icons.cancel_outlined),
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection(collectionName)
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection("items")
                          .doc(_documentSnapshot.id)
                          .delete();
                    },
                  ),
                ),
              ),
            );
          });
    },
  );
}