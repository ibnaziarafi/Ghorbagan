import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_13/page/splash_page.dart';
import 'package:ui_13/widgets/bottom_nav.dart';

class SplashPage2 extends StatefulWidget {
  const SplashPage2({Key? key}) : super(key: key);

  @override
  _SplashPage2State createState() => _SplashPage2State();
}

class _SplashPage2State extends State<SplashPage2> {

  void starttimer() {
    Timer(Duration(seconds: 2), () {
      navigateUser();
    });
  }
  void navigateUser() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var getval=prefs.getString('uniqueid') ?? '';
    if(getval.length>2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          //builder: (builder) => DetailsPage(plant: plants[index]),
          builder: (builder) => BottomNavBar(),
        ),
      );

    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          //builder: (builder) => DetailsPage(plant: plants[index]),
          builder: (builder) => SplashPage(),
        ),
      );
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    starttimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:  Center(child: Text("GhorBagan",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.blueGrey),)),),
    );
  }
}
