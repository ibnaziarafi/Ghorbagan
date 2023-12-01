import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/page/Question_ans_page.dart';

import '../core/color.dart';



class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  late List lists;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        title: Text("Question list", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),

      ),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("ask-for-image-v2")
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
                                  builder: (builder) => QuestionAns(list: [data['question'],data['imagePath'],data['email']],),
                                ),
                              );
                            },
                            child: Container(

                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data['imagePath']),
                                ),
                                title: Text(data['question']),
                                trailing: Icon(Icons.arrow_right),
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