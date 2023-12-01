import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/widgets/fatchdata3.dart';

class Cart2 extends StatefulWidget {
  @override
  _Cart2State createState() => _Cart2State();
}

class _Cart2State extends State<Cart2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: fetchData3("users-cart-items2"),
      ),
    );
  }
}