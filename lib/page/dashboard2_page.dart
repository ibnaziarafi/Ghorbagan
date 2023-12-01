import 'package:flutter/material.dart';
import 'package:ui_13/page/dashboard_page.dart';
import '../widgets/drawerScreen.dart';
class Dashboard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          Dashboard(),

        ],
      ),

    );
  }
}