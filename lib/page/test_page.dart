import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/data/order_model.dart';
import 'package:ui_13/data/plant_model_firestore.dart';
import 'package:ui_13/page/add_to_cart_page.dart';
import 'package:ui_13/page/soil_instruction_page.dart';
import 'package:ui_13/page/water_instruction_page.dart';

import 'fertilizer_instruction_page.dart';
import 'light_instruction_page.dart';

class DetailsPage2 extends StatefulWidget {
/*  final Plants plant;
  const DetailsPage({Key? key, required this.plant}) : super(key: key);*/

  final PlantF plant;
  const DetailsPage2({Key? key, required this.plant}) : super(key: key);

  @override
  State<DetailsPage2> createState() => _DetailsPage2State();
}

class _DetailsPage2State extends State<DetailsPage2> {

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

  var today= DateTime.now();
  List<String> monthList=["January","February","March","April",
    "May","June","July","August","September","October","November","December"
  ];

  int waterDaysNumber() {
    var winter=widget.plant.water_winter;
    var summer=widget.plant.water_summer;


    int jan=(winter-((winter*10)/100)).round();
    int fab=(winter-((winter*15)/100)).round();
    int mar=(winter-((winter*15)/100)).round();
    int apr=(summer-((summer*10)/100)).round();
    int may=(summer-((summer*15)/100)).round();
    int jun=(summer-((summer*20)/100)).round();
    int jul=(summer-((summer*25)/100)).round();
    int aug=(summer-((summer*15)/100)).round();
    int sep=(summer-((summer*10)/100)).round();
    int oct=(summer-((summer*5)/100)).round();
    int nov=(winter-((winter*10)/100)).round();
    int dec=(winter-((winter*10)/100)).round();

    List<int> monNo=[jan,fab,mar,apr,may,jun,jul,aug,sep,oct,nov,dec];
    int mNum=today.month.toInt();


    return monNo[mNum-1];
  }

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

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-favourite-items-v2");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "id": widget.plant.id,
      "name": widget.plant.name,
      "category": widget.plant.category,

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
                        horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(widget.plant.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                color: black.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),),
                            ),

                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection("users-favourite-items-v2").doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection("items")
                                  .where("name",isEqualTo: widget.plant.name)
                                  .where("id",isEqualTo: widget.plant.id)
                                  .where("category",isEqualTo: widget.plant.category)
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot snapshot){
                                if(snapshot.data==null){
                                  return Text("");
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () => snapshot.data.docs.length==0?addToFavourite():print("Already Added"),
                                      icon: snapshot.data.docs.length==0? Icon(
                                        Icons.favorite_outline,
                                        color: Colors.blueGrey,
                                      ):Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                );
                              },

                            ),

                            /*Container(
                              height: 30.0,
                              width: 30.0,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: green,
                                boxShadow: [
                                  BoxShadow(
                                    color: green.withOpacity(0.2),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Image.asset(
                                'assets/icons/heart.png',
                                color: white,
                              ),
                            ),*/
                          ],
                        ),
                        Text(widget.plant.price.toString()+"TK", style: TextStyle(fontSize: 15,),),
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
                        Text(
                          'Treatment',
                          style: TextStyle(
                            color: black.withOpacity(0.9),
                            fontSize: 18.0,
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 20.0),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap:() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    //builder: (builder) => DetailsPage(plant: plants[index]),
                                    builder: (builder) => LightIns(),
                                  ),
                                );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.width*0.21,
                                width: MediaQuery.of(context).size.width*0.235,
                                decoration: BoxDecoration(
                                  color: tabcolor2.withOpacity(0.3),
                                  /*boxShadow: [
                                  BoxShadow(
                                    color: tabcolor2.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],*/
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),

                                ),
                                child: Center(

                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Light",style: TextStyle(fontWeight: FontWeight.bold),),
                                        SingleChildScrollView(child: Text(widget.plant.light.toString(), textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,overflow: TextOverflow.fade))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width*0.21,
                              width: MediaQuery.of(context).size.width*0.235,
                              decoration: BoxDecoration(
                                color: tabcolor2.withOpacity(0.3),
                                /*boxShadow: [
                                BoxShadow(
                                  color: tabcolor2.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],*/
                                borderRadius: const BorderRadius.all(Radius.circular(12)),

                              ),
                              child: Center(

                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Care",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(widget.plant.care.toString(), style: TextStyle(color: Colors.black54,overflow: TextOverflow.ellipsis)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width*0.21,
                              width: MediaQuery.of(context).size.width*0.235,
                              decoration: BoxDecoration(
                                color: tabcolor2.withOpacity(0.3),
                                /*boxShadow: [
                                BoxShadow(
                                  color: tabcolor2.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],*/
                                borderRadius: const BorderRadius.all(Radius.circular(12)),

                              ),
                              child: Center(

                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Toxic",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(widget.plant.toxic=="toxic"?"Yes":"No", style: TextStyle(color: Colors.black54,)),
                                          Text("", style: TextStyle(color: Colors.black54,fontSize: 7)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 20.0),

                        Text(
                          'Water',
                          style: TextStyle(
                            color: black.withOpacity(0.9),
                            fontSize: 18.0,
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        GestureDetector(
                          onTap:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                //builder: (builder) => DetailsPage(plant: plants[index]),
                                  builder: (builder) => WaterIns()),
                            );
                          },
                          child: ListTile(
                            leading:CircleAvatar(
                              backgroundColor: white,
                              child: Icon(Icons.water_drop,color: Colors.blueAccent.withOpacity(0.4),),
                            ),


                            title: Text("Water every ${waterDaysNumber()}th day"),
                            subtitle: Text("in ${monthList[(today.month.toInt())-1]}"),
                          ),
                        ),
                        GestureDetector(
                          onTap:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                //builder: (builder) => DetailsPage(plant: plants[index]),
                                  builder: (builder) => WaterIns()),
                            );
                          },
                          child: ListTile(
                            //leading: ,
                            title: Text("top layer should be dry"),
                            subtitle: Text("Tap to learn more"),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Fertilizing',
                          style: TextStyle(
                            color: black.withOpacity(0.9),
                            fontSize: 18.0,
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        GestureDetector(
                          onTap:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                //builder: (builder) => DetailsPage(plant: plants[index]),
                                  builder: (builder) => FertilizerIns()),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: white,
                              child: Icon(FontAwesomeIcons.sprayCan,color: Colors.green.withOpacity(0.4),),
                            ),
                            title: Text("fertilize every ${widget.plant.fertilizer}th day"),
                            subtitle: Text("in ${monthList[(today.month.toInt())-1]}"),
                          ),
                        ),
                        GestureDetector(
                          onTap:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                //builder: (builder) => DetailsPage(plant: plants[index]),
                                  builder: (builder) => FertilizerIns()),
                            );
                          },
                          child: ListTile(
                            //leading: ,
                            title: Text("Tap to know about fertilizing"),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Ideal temperature',
                          style: TextStyle(
                            color: black.withOpacity(0.9),
                            fontSize: 18.0,
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: white,
                            child: Icon(FontAwesomeIcons.temperatureHigh,color: Colors.pinkAccent.withOpacity(0.4),),
                          ),
                          title: Text("${widget.plant.temp_from}\u00B0 C - ${widget.plant.temp_to}\u00B0 C"),
                          subtitle: Text("in ${monthList[(today.month.toInt())-1]}"),
                        ),

                        const SizedBox(height: 20.0),
                        Text(
                          'Soil and repotting',
                          style: TextStyle(
                            color: black.withOpacity(0.9),
                            fontSize: 18.0,
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: white,
                            child: Icon(FontAwesomeIcons.jarWheat,color: Colors.deepOrange.withOpacity(0.4),),
                          ),
                          title: Text("every year"),
                          subtitle: Text("Repot"),
                        ),
                        GestureDetector(
                          onTap:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                //builder: (builder) => DetailsPage(plant: plants[index]),
                                  builder: (builder) => SoilIns()),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: white,
                              child: Icon(FontAwesomeIcons.jarWheat,color: Colors.yellow.shade700,),
                            ),
                            title: Text("Soil type"),
                            subtitle: Text("Soil type"),
                          ),
                        ),
                        const SizedBox(height: 20.0),


                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Image.asset('assets/icons/cart.png',
                      color: black, height: 40.0),
                ],
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
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
                    Fluttertoast.showToast(msg: "You still have product in cart from another shop. place order for thm first", toastLength: Toast.LENGTH_LONG);
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
