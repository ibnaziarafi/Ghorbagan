import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/core/color.dart';

Widget fetchData2 (String collectionName){

  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .where('status',whereIn: ["On hold","On the way"])
        //.where('status',isEqualTo: "Ön the way")
        .where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email)
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
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black38,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(_documentSnapshot['images']),
                      ),
                      title: Text(
                        _documentSnapshot['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
                      ),
                      subtitle: Text("\$ ${_documentSnapshot['price']}"),
                      trailing: _documentSnapshot['status']!="On hold"?Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.3),
                              boxShadow: [
                                BoxShadow(
                                  color: green.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_documentSnapshot['status']),
                            )),
                      ):GestureDetector(
                        child: Icon(Icons.cancel_outlined),//Icon(Icons.cancel_outlined),
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection(collectionName)
                              .doc(_documentSnapshot.id)
                              .delete();
                          print("working");
                        },
                      ),
                    ),

                    _documentSnapshot['status']=="On hold"?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: _documentSnapshot['status']=="On hold"?Colors.blue.withOpacity(0.3):Colors.green.withOpacity(0.3),
                            boxShadow: [
                              BoxShadow(
                                color: green.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_documentSnapshot['status']),
                          )),
                    ):SizedBox(height: 0,),
                  ],
                ),
              ),
            );
          });
    },
  );
}