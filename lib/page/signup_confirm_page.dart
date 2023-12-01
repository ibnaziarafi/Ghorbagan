import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../core/color.dart';
import '../widgets/bottom_nav.dart';


class RegPage extends StatefulWidget {
  const RegPage({Key? key}) : super(key: key);

  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactnoController2 = TextEditingController();

  final GlobalKey<ExpansionTileCardState> cardA=new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB=new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC=new GlobalKey();


  String skill="easy";
  String pet="yes";
  String avaterurl="https://ih1.redbubble.net/image.3447272478.3412/st,small,507x507-pad,600x600,f8f8f8.jpg";

  late int a;
  bool check=false;
  String plantnetApi='2b10W5SQjjjtmSjL1hOXRC8zRe';

  late Future<int> _counter;
  late var  list =[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot2=[];

  fatchtask () async{
    var _firestoreInstance = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> qn = await _firestoreInstance.collection("plantnet-api-key")
        .doc('2b10W5SQjjjtmSjL1hOXRC8zRe')
        .get();
    print("function working");


    setState(() {
      //temp_rewards_avail=qn['email'];
      print(qn.data());
      print(qn.get("api-key"));
      plantnetApi=qn.get("api-key");
    });




    return qn;

  }

  Future<void> abc() async{
    final SharedPreferences prefs = await _prefs;

    await prefs.setString('uniqueid', FirebaseAuth.instance.currentUser!.email.toString());
    await prefs.setString('skill', skill);
    await prefs.setString('pet', pet);
    await prefs.setString('plantnetApi', plantnetApi);


  }

  Future finalReg() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-profile");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
      "name":_nameController.text,
      "email":currentUser.email.toString(),
      "pet":pet,
      "skill":skill,
      "location":"",
      "imagePath":avaterurl,
      "plantnet-api":plantnetApi,
    }).then((value) {
     abc().then((value) =>rewardProfileCreate());
    });
  }

  Future rewardProfileCreate() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("rewards");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
      "email":currentUser.email.toString(),
      "temp-rewards":0,
      "temp-spent":0,
      "total-rewards":0,
      "total-spent":0,
    }).then((value) {
      Fluttertoast.showToast(msg: "welcome!");




      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>BottomNavBar()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fatchtask();
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Column(
                  children: <Widget>[
                    Text("Feel up", style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]
                    ),),
                    SizedBox(height: 20,),

                  ],
                ),
                //onPressed: () => snapshot.data.docs[0]["id"]==_idController.text?Fluttertoast.showToast(msg: " This id isn't available."):finalReg(),



                Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Name", style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87
                        ),),
                        SizedBox(height: 5,),
                        TextField(
                          controller: _nameController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: "ex. ibna zia",
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),

                    ExpansionTileCard(
                      key: cardA,
                      title: Text("Gardening skill"),
                      subtitle: Text(skill),
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              skill="easy";
                            });

                            cardA.currentState?.collapse();
                          },
                          child: Container(
                            child: ListTile(
                              title: Text("Easy"),

                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              skill="medium";
                            });

                            cardA.currentState?.collapse();
                          },
                          child: Container(
                            child: ListTile(
                              title: Text("Medium"),

                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              skill="hard";
                            });

                            cardA.currentState?.collapse();
                          },
                          child: Container(
                            child: ListTile(
                              title: Text("Hard"),

                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 20,),
                    ExpansionTileCard(
                      key: cardB,
                      title: Text("Do you have pets or children under 3years old?"),
                      subtitle: Text(pet),
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              pet="yes";
                            });

                            cardB.currentState?.collapse();
                          },
                          child: Container(
                            child: ListTile(
                              title: Text("Yes, I have."),

                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              pet="no";
                            });
                            cardB.currentState?.collapse();

                          },
                          child: Container(
                            child: ListTile(
                              title: Text("No"),

                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 20,),

                    ExpansionTileCard(
                      key: cardC,
                      title: Text("Choose avater"),
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.withOpacity(0.2),
                        backgroundImage: NetworkImage(avaterurl),
                      ),
                      children: [
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("avatar-image").snapshots(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(snapshot.data==null){
                              return Text("");
                              //snapshot.data.docs
                            }

                            if(snapshot.hasData) {
                              _documentSnapshot2 =snapshot.data!.docs;


                            }
                            return  GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _documentSnapshot2.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                ),
                                itemBuilder: (BuildContext context,int index) {
                                  return GestureDetector(
                                    onTap: () {

                                      setState(() {
                                        avaterurl=_documentSnapshot2[index]['imagePath'];
                                      });
                                      cardC.currentState?.collapse();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      backgroundImage: NetworkImage(_documentSnapshot2[index]["imagePath"]),
                                    ),
                                  );
                                });
                          },

                        ),

                      ],
                    ),



                    SizedBox(height: 40,),
                    ElevatedButton(

                      onPressed: () {
                        Fluttertoast.showToast(msg: "wait..",toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.pink);
                        finalReg();

                      },
                      child: const Text('    Finish    ', style: TextStyle(fontWeight: FontWeight.bold),),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(tabcolor1.withOpacity(0.6)),
                        overlayColor: MaterialStateProperty.all(tabcolor2.withOpacity(0.7)),
                      ),
                    ),
                    //makeInput(controller: _emailController,label: "Email"),
                    //makeInput(controller: _passwordController,label: "Password", obscureText: true),
                    //makeInput(label: "Confirm Password", obscureText: true),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}