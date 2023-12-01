import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:ui_13/core/color.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ui_13/data/plant_model_firestore.dart';
import 'package:ui_13/page/single_plant_category_page.dart';


class ImageDetectPN extends StatefulWidget {
  const ImageDetectPN({Key? key}) : super(key: key);

  @override
  _ImageDetectPNState createState() => _ImageDetectPNState();
}

class _ImageDetectPNState extends State<ImageDetectPN> {

  String rslt = '';
  bool loading=false;
  late File _image;
  late List _results;
  bool imageSelect=false;
  bool check=false;
  late PlantF plantk;
  String submit="wait a few sec";
  int ck=0;

  int resultLength=0;
  var nameList=[];
  var nameList2=[];
  var nameList3=[];
  late var scientificName;
  late var scientificName2;
  late var scientificName3;

  late var familyScientificName;
  late var familyScientificName2;
  late var familyScientificName3;

  late var scoreOne;
  late var scoreTwo;
  int score1=0;
  int score2=0;
  var score_1="";
  var score_2="";
  String plantnetApiKey='';

  List<QueryDocumentSnapshot<Object?>> _documentSnapshot=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot2=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot3=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot4=[];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> ukid2() async {
    final SharedPreferences prefs = await _prefs;
    final String counter = (prefs.getString('plantnetApi') ?? '');
    setState(() {
      plantnetApiKey=counter;
      print(counter);
      endPoint=endPoint+plantnetApiKey;
      print(endPoint);

    });
  }


  @override
  void initState()
  {
    ukid2();

    print(endPoint);
    super.initState();

  }


   String endPoint = 'https://my-api.plantnet.org/v2/identify/all?include-related-images=false&no-reject=false&lang=en&api-key=';
  void _upload(File file) async {
    String fileName = file.path.split('/').last;
    print(fileName);

    FormData data = FormData.fromMap({
      "images": [await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),]
    });

    Dio dio = new Dio();

    dio.post(endPoint, data: data).then((response) {
      var jsonResponse = jsonDecode(response.toString());
      print("common names: "+response.data['results'][0]['species']['commonNames'].toString());
      print("scientific name: "+response.data['results'][0]['species']['scientificNameWithoutAuthor'].toString());
      print("family s name: "+response.data['results'][0]['species']['family']['scientificNameWithoutAuthor'].toString());
      print("---");
      print(response.data['results']);
      print("---");

      resultLength=response.data['results'].length;
      if(resultLength>0) {
        nameList=response.data['results'][0]['species']['commonNames'];
        scientificName=response.data['results'][0]['species']['scientificNameWithoutAuthor'];
        familyScientificName=response.data['results'][0]['species']['family']['scientificNameWithoutAuthor'];

        score_1=response.data['results'][0]['score'].toString();
        scoreOne=double.parse(score_1);
        print(scoreOne);


        print(score_1);
      }
      if(resultLength>1){
        nameList2=response.data['results'][1]['species']['commonNames'];
        scientificName2=response.data['results'][1]['species']['scientificNameWithoutAuthor'];
        familyScientificName2=response.data['results'][1]['species']['family']['scientificNameWithoutAuthor'];

        score_2=response.data['results'][1]['score'].toString();
        scoreTwo=double.parse(score_1);
      }
      if(resultLength>2){
        nameList3=response.data['results'][2]['species']['commonNames'];
        scientificName3=response.data['results'][2]['species']['scientificNameWithoutAuthor'];
        familyScientificName3=response.data['results'][2]['species']['family']['scientificNameWithoutAuthor'];
      }
      setState(() {
        loading=false;
        check=true;
      });

    }).catchError((error) => print(error));
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
      "question": "which plant is it?",
      "email":currentUser!.email,
      "imagePath": urlDownload.toString(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                    height: MediaQuery.of(context).size.width/2,
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
                visible: (imageSelect)? true : false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 55),
                  child: Divider(
                    color: Colors.grey.withOpacity(0.6),
                  ),
                ),
              ),
              loading==true?Center(child: CircularProgressIndicator()):SizedBox(),


              (check==true && loading==false)? Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("houseplant-v3")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Something went wrong"),
                        );
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading"),
                        );
                      }
                      if(snapshot.hasData) {
                        _documentSnapshot=snapshot.data!.docs;
                        print("working");
                        print(_documentSnapshot);

                        _documentSnapshot2.clear();
                        _documentSnapshot3.clear();
                        _documentSnapshot4.clear();

                        if(resultLength>0) {
                          for(int i=0;i<_documentSnapshot.length;i++) {
                            for(int b=0;b<nameList.length;b++) {
                              if(_documentSnapshot[i]['name'].contains(nameList[b].toString().toLowerCase())){
                                _documentSnapshot2.add(_documentSnapshot[i]);
                                print("working 1st add");
                                print("working 2nd");
                                break;
                              }}
                              if(_documentSnapshot2.length==0) {
                                if(_documentSnapshot[i]['botanical-name'].contains(scientificName.toString())){
                                  _documentSnapshot2.add(_documentSnapshot[i]);
                                } else if(_documentSnapshot[i]['botanical-name'].contains(familyScientificName.toString())){
                                  _documentSnapshot2.add(_documentSnapshot[i]);
                                }
                                print("working 3");
                              }

                            //

                          }
                        }
                        if(resultLength>1) {
                          for(int i=0;i<_documentSnapshot.length;i++) {
                            for(int b=0;b<nameList2.length;b++) {
                              if(_documentSnapshot[i]['name'].contains(nameList2[b].toString().toLowerCase())){
                                _documentSnapshot3.add(_documentSnapshot[i]);
                                print("working 1st add");
                                print("working 2nd");
                                break;
                              }}
                            if(_documentSnapshot3.length==0) {
                              if(_documentSnapshot[i]['botanical-name'].contains(scientificName2.toString())){
                                _documentSnapshot3.add(_documentSnapshot[i]);
                              } else if(_documentSnapshot[i]['botanical-name'].contains(familyScientificName2.toString())){
                                _documentSnapshot3.add(_documentSnapshot[i]);
                              }
                              print("working 3");
                            }

                            //

                          }
                          if((_documentSnapshot3.length!=0 && _documentSnapshot2.length!=0)) {
                            if(_documentSnapshot2[0]['name']==_documentSnapshot3[0]['name']){
                              _documentSnapshot3.clear();
                            }
                          }
                        }
                        print("working 4");

                        print(_documentSnapshot2.length);
                        print(_documentSnapshot3.length);

                      }

                      return SizedBox(

                        child: Column(
                          children: [
                           resultLength>0? ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 2000),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _documentSnapshot2.length,
                                itemBuilder: (BuildContext context, index) {
                                  DocumentSnapshot _documentSnapshot =
                                  _documentSnapshot2[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          //builder: (builder) => DetailsPage(plant: plants[index]),
                                          builder: (builder) => SinglePlantCat(category1: _documentSnapshot["botanical-name"]),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 0, bottom: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        /*boxShadow: [
                                                    BoxShadow(
                                                      color: green.withOpacity(0.02),
                                                      blurRadius: 10,
                                                      offset: const Offset(0, 5),
                                                    ),
                                                  ],*/
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            trailing: CircularStepProgressIndicator(
                                              totalSteps: 100,
                                              currentStep: (scoreOne*100).round(),
                                              stepSize: 2,
                                              selectedColor: tabcolor1.withOpacity(0.3),
                                              unselectedColor: Colors.grey[200],
                                              padding: 0,
                                              width: (MediaQuery.of(context).size.width-30)*0.14,
                                              height: (MediaQuery.of(context).size.width-30)*0.14,
                                              child: Center(child: Text("${(scoreOne*100).round().toStringAsFixed(0)}%")),
                                              selectedStepSize: 5,
                                              roundedCap: (_, __) => true,
                                            ),

                                            title: Text(_documentSnapshot['name'], style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45),),


                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(_documentSnapshot['imagePath']),
                                            ),
                                            subtitle: Text("Tap to see all", ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ):SizedBox(),
                            Container(
                              margin: const EdgeInsets.only(right: 5, bottom: 5,left: 5,top: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                /*boxShadow: [
                                              BoxShadow(
                                                color: green.withOpacity(0.02),
                                                blurRadius: 10,
                                                offset: const Offset(0, 5),
                                              ),
                                            ],*/
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text("Didn't match? Submit the photo."),
                                    ElevatedButton(
                                      onPressed: () {

                                        ck=0;

                                        uploadImageToFirebase();

                                        _showMyDialog();
                                      },
                                      child: Text(" Submit "),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(tabcolor1.withOpacity(0.6)),
                                        overlayColor: MaterialStateProperty.all(Colors.red),
                                      ),),

                                  ],
                                ),
                              ),
                            ),
                            _documentSnapshot3.length>0? ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 2000),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _documentSnapshot3.length,
                                itemBuilder: (BuildContext context, index) {
                                  DocumentSnapshot _documentSnapshot =
                                  _documentSnapshot3[index];
                                  return GestureDetector(
                                    onTap: () {

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          //builder: (builder) => DetailsPage(plant: plants[index]),
                                          builder: (builder) => SinglePlantCat(category1: _documentSnapshot["botanical-name"]),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 0, bottom: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                                    BoxShadow(
                                                      color: green.withOpacity(0.02),
                                                      blurRadius: 10,
                                                      offset: const Offset(0, 5),
                                                    ),
                                                  ],
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            trailing: CircularStepProgressIndicator(
                                              totalSteps: 100,
                                              currentStep: (scoreTwo*100).round(),
                                              stepSize: 2,
                                              selectedColor: tabcolor1.withOpacity(0.3),
                                              unselectedColor: Colors.grey[200],
                                              padding: 0,
                                              width: (MediaQuery.of(context).size.width-30)*0.14,
                                              height: (MediaQuery.of(context).size.width-30)*0.14,
                                              child: Center(child: Text("${(scoreTwo*100).round().toStringAsFixed(0)}%")),
                                              selectedStepSize: 5,
                                              roundedCap: (_, __) => true,
                                            ),

                                            title: Text(_documentSnapshot['name'], style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45),),


                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(_documentSnapshot['imagePath']),
                                            ),
                                            subtitle: Text("Tap to see all", ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ):SizedBox(),
                          ],
                        ),
                      );
                    }),
              ) :Container(
                margin: const EdgeInsets.all(10),
                child: const Opacity(
                  opacity: 0.8,
                  child: Center(
                    child: Text(""),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future pickImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image=File(pickedFile!.path);

    if(image!=null) {

      imageSelect=true;
      _image=image;
      _upload(image);
      setState(() {
        loading=true;

      });
    }

  }
  Future pickPhoto()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    File image=File(pickedFile!.path);
    if(image!=null) {
      imageSelect=true;
      _image=image;
      _upload(image);
      setState(() {

        loading=true;
      });
    }

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
}