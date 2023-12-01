import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_13/core/color.dart';
import '../widgets/bottom_nav.dart';


class LoginConnecting extends StatefulWidget {
  const LoginConnecting({Key? key}) : super(key: key);

  @override
  _LoginConnectingState createState() => _LoginConnectingState();
}

class _LoginConnectingState extends State<LoginConnecting> {
  String skill='';
  String name='';
  String pet='';
  String plantnetApiKey='';
  String tempPlantapi='';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> abc() async{
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('skill', skill);
    await prefs.setString('pet', pet);
    await prefs.setString('plantnetApi', plantnetApiKey);


  }
  Future<void> abc2() async{
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('skill', 'easy');
    await prefs.setString('pet', 'no');
    await prefs.setString('plantnetApi', tempPlantapi);


  }
  fatchtask2 () async{
    var _firestoreInstance = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> qn = await _firestoreInstance.collection("plantnet-api-key")
        .doc('2b10W5SQjjjtmSjL1hOXRC8zRe')
        .get();
    print("function working");


    setState(() {
      //temp_rewards_avail=qn['email'];
      print(qn.data());
      print(qn.get("api-key"));
      tempPlantapi=qn.get("api-key");

      finalReg();
    });




    return qn;

  }

  fatchtask () async{
    var _firestoreInstance = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> qn = await _firestoreInstance.collection("users-profile")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    print("function working");


    setState(() {
      if(qn.data()!=null){
        print(qn.data());
        print(qn.get("name"));
        name=qn.get('name');
        skill=qn.get("skill");
        pet=qn.get("pet");
        plantnetApiKey=qn.get("plantnet-api");

        abc().then((value) =>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => BottomNavBar()), (Route<dynamic> route) => false));

      } else {
        fatchtask2();
      }

      //temp_rewards_avail=qn['email'];

    });




    return qn;

  }

  Future finalReg() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-profile");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
      "name":'Set name',
      "email":currentUser.email.toString(),
      "pet":'no',
      "skill":'easy',
      "location":"",
      "imagePath":"https://ih1.redbubble.net/image.3447272478.3412/st,small,507x507-pad,600x600,f8f8f8.jpg",
      "plantnet-api":tempPlantapi,
    }).then((value) {
      abc2().then((value) =>rewardProfileCreate());
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
      Fluttertoast.showToast(msg: "Successfully created!");




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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: tabcolor1,
            ),
            SizedBox(height: 5,),
            Text("Connecting",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: tabcolor1),)
          ],
        ),
      ),
    );
  }
}
