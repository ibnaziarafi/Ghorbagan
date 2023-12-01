import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/color.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController _emailController = TextEditingController();

  Future submit() async{

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim())
          .then((value) {
        Fluttertoast.showToast(msg: "Submitted!");
        Navigator.pop(context);
      });




    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");

      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");

      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Center(
          child: TextField(
            controller: _emailController,
            obscureText: false,
            decoration: InputDecoration(
              hintText: "Enter email",
              labelText: 'Email',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(

        onPressed: () {
          submit();
        },
        child: const Text('    Reset password    ', style: TextStyle(fontWeight: FontWeight.bold),),
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
    );
  }
}
