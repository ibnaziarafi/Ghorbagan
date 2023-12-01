import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core/color.dart';



class QuestionAns extends StatefulWidget {
  final List<String> list;
  const QuestionAns({Key? key, required this.list}) : super(key: key);
  @override
  _QuestionAnsState createState() => _QuestionAnsState();
}

class _QuestionAnsState extends State<QuestionAns> {
  TextEditingController _Controller = TextEditingController();

  Future giveAns() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("inbox");
    return _collectionRef
        .doc(widget.list[2])
        .collection("items")
        .doc()
        .set({
      "question": widget.list[0],
      "answer": _Controller.text,
      "imagePath": widget.list[1],
    }).then((value) => Fluttertoast.showToast(msg: "Successfully added!"));
  }

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
        child: Column(
          children: [

            Text(widget.list[0]),
            CircleAvatar(
              radius: MediaQuery.of(context).size.width/2,
              backgroundImage: NetworkImage(widget.list[1]),
            ),

            TextField(
              controller: _Controller,
              obscureText: false,
              decoration: InputDecoration(
                hintText: "answer",
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                ),
              ),
            ),
            ElevatedButton(onPressed: () {
              giveAns();
            }, child: Text("post"))



          ],
        ),
      ),
    );
  }
}