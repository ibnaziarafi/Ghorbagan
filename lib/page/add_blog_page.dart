import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/data/blog_model.dart';
import '../core/color.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  List<BlogModel> fullList=[];
  List<String> imglist=[];
  List<String> titlelist=[];
  List<String> deslist=[];

  late BlogModel blogModel;
  TextEditingController _imagecontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _detailscontroller = TextEditingController();

  TextEditingController _mainImagecontroller = TextEditingController();
  TextEditingController _mainNamecontroller = TextEditingController();


  addtolist() {
    blogModel=BlogModel(name: _namecontroller.text, imagePath: _imagecontroller.text, details: _detailscontroller.text);

    fullList.add(blogModel);
    imglist.add(blogModel.imagePath);
    titlelist.add(blogModel.name);
    deslist.add(blogModel.details);
    _namecontroller.clear();
    _imagecontroller.clear();
    _detailscontroller.clear();
    setState(() {
      fullList=fullList;
      imglist=imglist;
      titlelist=titlelist;
      deslist=deslist;
    });
    print(imglist);
    print(titlelist);
    print(deslist);
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
                SizedBox(height: 4,),
                TextField(

                  controller: _imagecontroller,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "image url",
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                ),
                SizedBox(height: 4,),

                TextField(

                  controller: _namecontroller,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "Title",
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                ),

                SizedBox(height: 4,),
                TextField(

                  controller: _detailscontroller,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "Details",
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                ),
                SizedBox(height: 4,),
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
              child: Text('Done'),
              onPressed: () {
                addtolist();
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }

  Future addBlog() async {


    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("blogs");
    return _collectionRef
        .doc()
        .set({
      "name": _mainNamecontroller.text,
      "imagePath": _mainImagecontroller.text,
      "imglist":imglist,
      "titlelist":titlelist,
      "deslist":deslist,



    }).then((value) {
      print("added");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 4,),
              TextField(

                controller: _mainImagecontroller,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "image url",
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                ),
              ),
              SizedBox(height: 4,),

              TextField(

                controller: _mainNamecontroller,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Title",
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                ),
              ),

              SizedBox(height: 12,),

              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                  fullList.length == 0 ? 0 : fullList.length,
                  itemBuilder: (_, index) {
                    BlogModel _documentSnapshot =
                    fullList[index];

                    return GestureDetector(
                      onTap: () {
                      },
                      child: Card(
                        elevation: 0.09,
                        color: lightGreen,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(_documentSnapshot.imagePath),
                          ),
                          title: Text(
                            _documentSnapshot.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
                          ),
                          subtitle: Text("\$ ${_documentSnapshot.details}"),

                        ),
                      ),
                    );
                  }),
              ElevatedButton(

                onPressed: () {
                  _showMyDialog();
                },
                child: const Text('  Add sub  ', style: TextStyle(fontWeight: FontWeight.bold),),
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
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(

        onPressed: () {
          addBlog();
        },
        child: const Text('  Add sub  ', style: TextStyle(fontWeight: FontWeight.bold),),
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
