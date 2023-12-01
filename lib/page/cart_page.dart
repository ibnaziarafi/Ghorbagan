import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/widgets/fatchdata2.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: fetchData2("users-cart-items2"),
      ),
    );
  }
}