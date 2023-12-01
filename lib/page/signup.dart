import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui_13/page/signup_confirm_page.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  bool loading=false;



  signUp()async{

    if(_emailController.text.length <3) {
      Fluttertoast.showToast(msg: "Email field is empty");
    } else if(_passwordController.text.length<1 || _passwordController2.text.length <1) {
      Fluttertoast.showToast(msg: "Password field is empty");
    } else if(_passwordController.text!=_passwordController2.text) {
      Fluttertoast.showToast(msg: "Both password didn't match");
    } else if(_passwordController.text.length<6) {
      Fluttertoast.showToast(msg: "password is too short.");
    } else if(_passwordController.text==_passwordController2.text && _emailController.text.length>3) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text
        );
        var authCredential = userCredential.user;
        print(authCredential!.uid);
        if(authCredential.uid.isNotEmpty){
          setState(() {
            loading=false;
          });

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>RegPage()));

          //Navigator.push(context, CupertinoPageRoute(builder: (_)=>BottomNavBar()));
        }
        else{
          setState(() {
            loading=false;
          });
          Fluttertoast.showToast(msg: "Something is wrong");
        }

      } on FirebaseAuthException catch (e) {
        setState(() {
          loading=false;
        });
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(msg: "The password provided is too weak.");

        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(msg: "The account already exists for that email.");

        }
      } catch (e) {
        print(e);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Sign up", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 20,),
                  Text("Create an account, It's free", style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700]
                  ),),
                  SizedBox(height: 20,),
                ],
              ),
              Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Email", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87
                      ),),
                      SizedBox(height: 5,),
                      TextField(
                        controller: _emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "example@gmail.com",
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Password", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87
                      ),),
                      SizedBox(height: 5,),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "password must be 6 character",
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Re-enter", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87
                      ),),
                      SizedBox(height: 5,),
                      TextField(
                        controller: _passwordController2,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Re-enter password ",
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                  loading==true?Center(child: CircularProgressIndicator()):SizedBox(),
                  //makeInput(controller: _emailController,label: "Email"),
                  //makeInput(controller: _passwordController,label: "Password", obscureText: true),
                  //makeInput(label: "Confirm Password", obscureText: true),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    setState(() {
                      loading=true;
                    });
                    signUp();
                  },
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Sign up", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => LoginPage()));

                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w600, fontSize: 18
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({controller,label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}