import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/page/add_to_cart2_page.dart';
import 'package:ui_13/page/cart_page.dart';
import '../core/color.dart';


class CartTab extends StatefulWidget {
  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          title: Text("Cart", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),

          bottom: TabBar(tabs: [
            Tab(child: Text("Place order",style: TextStyle(color: tabcolor1, fontWeight: FontWeight.bold),),),
            Tab(child: Text("orders details",style: TextStyle(color: tabcolor1, fontWeight: FontWeight.bold),),),
          ]),
        ),
        body: TabBarView(
          children: [
            AddToCart2(),
            Cart()
          ],
        ),
      ),
    );
  }
}