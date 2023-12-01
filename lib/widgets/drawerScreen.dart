import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/page/All_blog_page.dart';
import 'package:ui_13/page/cart_tabbar_page.dart';
import 'package:ui_13/page/favourite_page.dart';
import 'package:ui_13/page/image_detection_plantnet_page.dart';
import 'package:ui_13/page/plant_diagnosis_page.dart';
import 'package:ui_13/page/splash_page.dart';
import 'package:ui_13/page/tutorial_page.dart';
import 'package:ui_13/widgets/hidden_drawer_nav.dart';
import '../page/inbox_page.dart';
import '../page/profile_page.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String email='';

  Future<void> ukid2() async {
    final SharedPreferences prefs = await _prefs;
    final String counter = (prefs.getString('uniqueid') ?? '');
    setState(() {
     email=counter;

    });
  }

  void logout() async{
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      //builder: (builder) => DetailsPage(plant: plants[index]),
      builder: (builder) => SplashPage(),
    ), ModalRoute.withName('/'));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(''),
                Text('Press Confirm to log out.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                logout();
              },
            ),

          ],
        );
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ukid2();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tabcolor1.withOpacity(0.6),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => ProfilePage(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage("https://ncdsonline.org/wp-content/uploads/2020/07/empty-profile-image.jpg"),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(email,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        Text('Active Status',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
              ),


              SizedBox(height: 80,),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => CartTab(),
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 14,),
                      Icon(Icons.shopping_cart, color: Colors.white, size: 30,),
                      SizedBox(width: 10,),
                      Text("Cart", style:TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12,),
              GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => Favourite(),
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 14,),
                      Icon(Icons.favorite, color: Colors.white, size: 30,),
                      SizedBox(width: 10,),
                      Text("Favourite", style:TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => ImageDetectPN(),
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 14,),
                      Icon(Icons.camera, color: Colors.white, size: 30,),
                      SizedBox(width: 10,),
                      Text("Plant identifier", style:TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => PlantDiagnosis(),
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 14,),
                      Icon(FontAwesomeIcons.houseMedicalCircleCheck, color: Colors.white, size: 29,),
                      SizedBox(width: 10,),
                      Text("Plant diagnosis", style:TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => TempPage(),
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 14,),
                      Icon(Icons.light, color: Colors.white, size: 30,),
                      SizedBox(width: 10,),
                      Text("Light meter", style:TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => TutorialPage(),
                    ),
                  );

                },
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 14,),
                      Icon(FontAwesomeIcons.chalkboardUser, color: Colors.white, size: 27,),
                      SizedBox(width: 10,),
                      Text(" Tutorial", style:TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => Blogs(),
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 14,),
                      Icon(Icons.newspaper, color: Colors.white, size: 30,),
                      SizedBox(width: 10,),
                      Text("Blogs", style:TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12,),
              GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => Inbox(),
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 14,),
                      Icon(Icons.messenger_outline, color: Colors.white, size: 30,),
                      SizedBox(width: 10,),
                      Text("Inbox", style:TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),

              SizedBox(height: 60,),

              

              GestureDetector(
                onTap: () {
                  _showMyDialog();
                },
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.logout,color: Colors.white,),
                    SizedBox(width: 10,),

                    Text('Log out',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)


                  ],

                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}