import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/data/order_model.dart';
import 'package:ui_13/data/plant_model_firestore.dart';
import 'package:ui_13/page/add_to_cart_page.dart';

class DetailsPage3 extends StatefulWidget {
  final PlantF plant;
  const DetailsPage3({Key? key, required this.plant}) : super(key: key);

  @override
  State<DetailsPage3> createState() => _DetailsPage3State();
}

class _DetailsPage3State extends State<DetailsPage3> {

  List<int> items2=[1,2,3,4,5,6,7,8,9,10];
  dynamic selectedIndex1 = 1;

  List<QueryDocumentSnapshot<Object?>> _documentSnapshot2=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot3=[];
  late OrderPlant orderPlant;
  String listID='';
  String sellerID='';
  String sellerNAME='';
  int insideCOST=45;
  int outsideCOST=120;
  String sellerLOC='';

  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.plant.name,
      "price": widget.plant.price,
      "images": widget.plant.imagePath,
    }).then((value) => print("Added to cart"));
  }
////
  fatchtask2 () async{
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("users-item-listing")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .get();

    print("function working 1");

    if(qn.docs.length!=0){
      listID=qn.docs[0]['id'];
    }

    print(listID);

    return qn.docs;
  }
  fatchtask3 () async{
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("seller-user-v2")
        .where("id",isEqualTo: widget.plant.id)
        .get();

    print("function working 1");

    if(qn.docs.length!=0){
      sellerID=qn.docs[0]['id'];
      sellerLOC=qn.docs[0]['location'];
      sellerNAME=qn.docs[0]['store-name'];
    }

    print(sellerID);

    return qn.docs;
  }
  ////

  Future addToCartListing() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-item-listing");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "id":widget.plant.id,
      "name": widget.plant.name,
      "price": widget.plant.price,
      "quantity":selectedIndex1,
      "inside-cost":insideCOST,
      "outside-cost":outsideCOST,
      "sellerloc":sellerLOC,
      "seller-name":sellerNAME,
      "images": widget.plant.imagePath,
    }).then((value) => Fluttertoast.showToast(msg: " Checkout cart!"));
  }

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.plant.name,
      "price": widget.plant.price,
      "images": widget.plant.imagePath,
    }).then((value) => print("Added to favourite"));
  }

  @override
  void initState() {
    // TODO: implement initState
    fatchtask2();
    fatchtask3();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height / 2,
                    decoration: BoxDecoration(
                      color: lightGreen,
                      boxShadow: [
                        BoxShadow(
                          color: green.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.plant.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(widget.plant.name,style: TextStyle(
                            color: tabcolor1.withOpacity(0.9),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),),
                          subtitle: Text("Price: "+widget.plant.price.toString()+"TK",style: TextStyle(
                            color: black.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        const SizedBox(height: 20.0),
                        RichText(
                          text: TextSpan(
                            text: widget.plant.description,
                            style: TextStyle(
                              color: black.withOpacity(0.5),
                              fontSize: 15.0,
                              height: 1.4,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),




                      ],
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
      floatingActionButton:  SizedBox(
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 4),
              child: Container(
                width: MediaQuery.of(context).size.width*0.20,
                height: 35,
                decoration: BoxDecoration(

                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(18)),

                ),

                child: Center(
                  child: DropdownButton(
                    underline: SizedBox(),
                    items: items2.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString(),),
                    ) ).toList(),
                    value: selectedIndex1,
                    onChanged: (e) => setState(()=>selectedIndex1=e),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 4),
              child: ElevatedButton(

                onPressed: () {
                  //addToCart();
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => AddToCart(orderPlant: orderPlant=OrderPlant(
                          id: widget.plant.id,
                          name: widget.plant.name,
                          imagePath: widget.plant.imagePath,
                          quantity: selectedIndex1,
                          price: widget.plant.price,
                          insideCost: 35,
                          outsideCost: 100,
                          sellerLoc: "dhaka"
                      ),),
                    ),
                  );
                },
                /*${widget.plant.price}*/
                child:  Text('Order now', style: TextStyle(fontWeight: FontWeight.bold),),
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 4),
              child: ElevatedButton(

                onPressed: () {
                  if(listID=='') {
                    addToCartListing();
                  } else if(listID==widget.plant.id){
                    addToCartListing();

                  } else{
                    Fluttertoast.showToast(msg: "You still have product in cart from another shop.", toastLength: Toast.LENGTH_LONG);
                  }

                },
                /*${widget.plant.price}*/
                child:  Text('Add to cart', style: TextStyle(fontWeight: FontWeight.bold),),
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
          ],
        ),
      ),
    );
  }
}
