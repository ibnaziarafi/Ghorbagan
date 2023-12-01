import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/color.dart';

class PlantDiagnosis extends StatefulWidget {
  const PlantDiagnosis({Key? key}) : super(key: key);

  @override
  _PlantDiagnosisState createState() => _PlantDiagnosisState();
}

class _PlantDiagnosisState extends State<PlantDiagnosis> {
  late File _image;
  bool imageSelect=false;
  String submit="wait a few sec";
  int ck=0;
  TextEditingController _nameController = TextEditingController();

  Future pickImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image=File(pickedFile!.path);

    setState(() {
      _image=image;
      imageSelect=true;
    });

  }
  Future pickPhoto()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    File image=File(pickedFile!.path);
    setState(() {
      _image=image;
      imageSelect=true;
    });


  }

  Future uploadImageToFirebase() async {

    String fileName = _image.path.split('/').last;
    final ref = FirebaseStorage.instance.ref('uploads/$fileName');
    dynamic t=ref.putFile(_image);

    final snapshot = await t!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    final snapshot2 = await  ref.getDownloadURL();
    print("$urlDownload");
    //
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("ask-for-image-v2");
    return _collectionRef
        .doc()
        .set({
      "question": "what is the problem of it?(pD)",
      "email":currentUser!.email,
      "imagePath": urlDownload.toString(),
      "description":_nameController.text.length>0?_nameController.text:"No description",
    }).then((value) {
      setState(() {
        submit="Submited!";
        print(submit);
        if(ck==0) {
          Navigator.of(context).pop();
        }

      });
    });

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
                Text('Wait a few seconds'),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hide'),
              onPressed: () {
                ck=1;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              (imageSelect)?GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: Container(

                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width/2.97,
                    backgroundColor: tabcolor1,
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width/3,
                      backgroundImage: FileImage(_image),
                    ),
                  ),
                  //Image.file(_image),
                ),
              ):Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width*0.36,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(

                      margin: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width/3,
                        backgroundColor: Colors.green.withOpacity(0.15),
                        child: Text("Tap to select", style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),

              Visibility(
                  visible: (imageSelect)? true : false,
                  child: SizedBox(height: 15,)
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: (imageSelect)? true : false,
                    child: ElevatedButton(

                      onPressed: () {
                        pickImage();
                      },
                      child: const Text(' Change picture '),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(tabcolor1.withOpacity(0.6)),
                        overlayColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (imageSelect)? true : false,
                    child: Text("   or   "),
                  ),
                  ElevatedButton(

                    onPressed: () {
                      pickPhoto();
                    },
                    child: const Text('  Take photo  '),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(tabcolor1.withOpacity(0.6)),
                      overlayColor: MaterialStateProperty.all(Colors.red),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 55),
                  child: Divider(
                    color: Colors.grey.withOpacity(0.6),
                  ),
                ),
              ),
              Visibility(
                visible: (imageSelect)? false : true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 55),
                  child: Text(
                    "choose or take a photo of the infected leaves/tree stem.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black54
                    ),

                  ),
                ),
              ),

              Visibility(
                visible: (imageSelect)? true : false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 20),
                  child: TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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

            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: (imageSelect)? true : false,
        child: ElevatedButton(

          onPressed: () {
            ck=0;

            uploadImageToFirebase();

            _showMyDialog();
          },
          child: const Text('    Submit    ', style: TextStyle(fontWeight: FontWeight.bold),),
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
      ),
    );
  }
}
