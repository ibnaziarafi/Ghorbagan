import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/data/blog_details_mode.dart';
import 'package:ui_13/page/blog_details_page.dart';
import '../core/color.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key? key}) : super(key: key);

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("blogs")
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
              return SizedBox(
                height: 320.0,
                child: Text("Loading"),
              );
            }

            return ListView.builder(

              physics: const BouncingScrollPhysics(),

              itemCount:
              snapshot.data == null ? 0 : snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot _documentSnapshot =
                snapshot.data!.docs[index];



                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //builder: (builder) => DetailsPage(plant: plants[index]),
                          builder: (builder) => BlogDetails(detailsModel: BlogDetailsModel(
                              name: _documentSnapshot['name'],
                              imagePath: _documentSnapshot['imagePath'],
                              imglist: _documentSnapshot['imglist'],
                              titlelist: _documentSnapshot['titlelist'],
                              deslist: _documentSnapshot['deslist'])),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.width*0.5,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.05),
                            blurRadius: 15,
                            offset: const Offset(5, 5),
                          ),
                        ],
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: lightGreen,
                              boxShadow: [
                                BoxShadow(
                                  color: black.withOpacity(0.05),
                                  blurRadius: 15,
                                  offset: const Offset(5, 5),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25.0),
                              image: DecorationImage(
                                //image: AssetImage(imagePath[index]),
                                image: CachedNetworkImageProvider(_documentSnapshot['imagePath']),
                                fit: BoxFit.cover,
                              ),
                              /*image: DecorationImage(
                image: NetworkImage('https://www.exampledomain.com/images/background.jpg'),
                fit: BoxFit.fill,
              ),*/
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5,left: 6,right: 6),
                              child: Text(
                                _documentSnapshot['name'],
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,

                                ),textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
