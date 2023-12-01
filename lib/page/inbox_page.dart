import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/data/inbox_details_data.dart';
import 'package:ui_13/page/inbox_details_page.dart';
import '../core/color.dart';


class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  late InboxAll inboxAll;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        title: Text("Inbox", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // constraints: BoxConstraints(maxHeight: 2000),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 2500),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("inbox")
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("items")
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

                              if(data['question'] == "which plant is ita?") {

                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    //builder: (builder) => DetailsPage(plant: plants[index]),
                                    builder: (builder) => InboxDetails(inboxAll: inboxAll=InboxAll(
                                        question: data['question'],
                                        imagePath: data['imagePath'],
                                        answer: data['answer'],
                                        description: data['description'])),
                                  ),
                                );
                              }
                            },
                            child: Container(

                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(data['imagePath']),
                                ),
                                title: Text(data['answer']),
                                subtitle: Text("Tap to see instruction"),
                                trailing: GestureDetector(
                                    onTap: () {
                                      /*FirebaseFirestore.instance
                                          .collection("inbox")
                                          .doc(FirebaseAuth.instance.currentUser!.email)
                                          .collection("items")
                                          .doc(data.id)
                                          .delete();*/
                                    },
                                    child: Icon(Icons.delete_outline)),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}