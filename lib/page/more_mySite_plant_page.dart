import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/core/color.dart';
import '../data/plant_model_firestore.dart';

class MoreMySite extends StatefulWidget {
  final String category1;

  const MoreMySite({Key? key, required this.category1}) : super(key: key);

  @override
  State<MoreMySite> createState() => _MoreMySiteState();
}

class _MoreMySiteState extends State<MoreMySite> {
  PageController controller = PageController();
  late PlantF plantk;
  int ind=0;
  String title="";
  List<String> titleName=["Living room","BedRoom", "Kitchen","BathRoom", "Balcony", "Terrace", "Office"];
  List<String> tegName=["living-room","bed-room", "kitchen-room","bath-room", "belcony-room", "terrace-room", "office-room"];
  @override
  void initState() {
    controller = PageController(viewportFraction: 0.6, initialPage: 0);
    ind=tegName.indexOf(widget.category1);
    title=titleName[ind];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,

      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users-myplant-items-v2")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("items")
            .where('site',isEqualTo: widget.category1)
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
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          //builder: (builder) => DetailsPage(plant: plants[index]),
                          builder: (builder) => MyplantDetailspage(plant: plantk= PlantF(
                            id:_documentSnapshot['id'],
                            name:_documentSnapshot['name'],
                            imagePath:_documentSnapshot['imagePath'],
                            category:_documentSnapshot['category'],
                            semiCategory:_documentSnapshot['semiCategory'],
                            description:_documentSnapshot['description'],
                            price:_documentSnapshot['price'],
                            isFavorit:_documentSnapshot['isFavorit'],
                            temp:_documentSnapshot['temp'],
                            light:_documentSnapshot['light'],
                            toxic:_documentSnapshot['toxic'],
                          )),
                        ),
                      );*/
                    },
                    child: Container(
                      width: 200.0,
                      margin: const EdgeInsets.only(right: 0, bottom: 0),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(_documentSnapshot['imagePath']),
                        ),
                        title: Text(
                          _documentSnapshot['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,color: Colors.black45, fontSize: 18),
                        ),
                        subtitle: Text(" ${_documentSnapshot['category']}"),
                        trailing: Icon(Icons.arrow_right),
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
