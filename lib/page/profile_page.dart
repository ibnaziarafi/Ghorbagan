import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/data/profile_model.dart';
import 'package:ui_13/page/profile_edit_page.dart';

import '../core/color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name="";
  String avatarurl="";
  String email="";
  String skill="";
  String pet="";
  int skillcolorChecker=1;
  int petcolorChecker=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
      ),

      body: SingleChildScrollView(

        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-profile")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Text("");
              //snapshot.data.docs
            }
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: green.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width*0.12,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width*0.105,
                          backgroundColor: Colors.greenAccent.withOpacity(0.1),
                          backgroundImage: NetworkImage(""),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(height: 6,),
                  Text("email", style: TextStyle(color:Colors.black54),),
                  SizedBox(height: 16,),
                  ElevatedButton(

                    onPressed: () {

                    },
                    child: const Text('  Edit  ', style: TextStyle(fontWeight: FontWeight.bold),),
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
                  SizedBox(height: 40,),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Gardening skill: "),
                  ),
                  SizedBox(height: 10,),
                  ListTile(
                    leading: Icon(Icons.pets),
                    title: Text("Pets or children: "),
                  ),
                  SizedBox(height: 10,),




                ],
              );
            }

            if(snapshot.hasData) {

              var user=snapshot.data;
              name=user["name"];
              email=user["email"];
              avatarurl=user["imagePath"];
              pet=user["pet"];
              skill=user["skill"];

              if(skill=="easy") {
                skillcolorChecker=1;
              } else if(skill=="medium") {
                skillcolorChecker=2;
              } else {
                skillcolorChecker=3;
              }

              if(pet=="yes") {
                petcolorChecker=1;
              } else {
                petcolorChecker=2;
              }
            }
            return  Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: green.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width*0.12,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width*0.105,
                        backgroundColor: Colors.greenAccent.withOpacity(0.1),
                        backgroundImage: CachedNetworkImageProvider(avatarurl),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: 6,),
                Text(email, style: TextStyle(color:Colors.black54),),
                SizedBox(height: 16,),
                ElevatedButton(

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(

                        builder: (builder) => EditProfilePage(profile: Profile(
                            name: name,
                            skill: skill,
                            pet: pet,
                            imagePath: avatarurl),),
                      ),
                    );
                  },
                  child: const Text('  Edit  ', style: TextStyle(fontWeight: FontWeight.bold),),
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
                SizedBox(height: 40,),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Gardening skill: "),
                  trailing: Container(
                    decoration: BoxDecoration(

                      color: skillcolorChecker==1?Colors.green:(skillcolorChecker==2?Colors.orangeAccent:Colors.redAccent),

                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32),bottomRight: Radius.circular(32),bottomLeft: Radius.circular(32)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(skill, style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                ListTile(
                  leading: Icon(Icons.pets),
                  title: Text("Pets or children: "),
                  trailing: Container(
                    decoration: BoxDecoration(

                      color: petcolorChecker==1?Colors.greenAccent:Colors.pinkAccent,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32),bottomRight: Radius.circular(32),bottomLeft: Radius.circular(32)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(pet, style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
                SizedBox(height: 10,),




              ],
            );
          },

        ),
      ),
    );
  }
}
