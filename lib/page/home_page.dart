import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/data/category_model.dart';
import 'package:ui_13/data/seller_model.dart';
import 'package:ui_13/page/accessories_details_page.dart';
import 'package:ui_13/page/cart_tabbar_page.dart';
import 'package:ui_13/page/category_page.dart';
import 'package:ui_13/page/image_detection_plantnet_page.dart';
import 'package:ui_13/page/search_page.dart';
import 'package:ui_13/page/seller_details_page.dart';
import 'package:ui_13/page/single_plant_category_page.dart';
import 'package:ui_13/page/test_page.dart';
import '../data/plant_model_firestore.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<PlantF> plantF = <PlantF>[];
  late PlantF plantj;
  late PlantF plantk;
  List <String> testf=[];
  List _plantlist =[];
  int? _selectedin;
  String skill="";
  String pet="";
  String finalPet="";

  List<String> items = [
    "Tools",
    "cat2",
    "cat3",
  ];
  dynamic selecteditem="Tools";
  //////////////////

  List <int>  id = [];
  List <String>  name= [];
  List <String>  imagePath= [];
  List <String>  category= [];
  List <String>  description=[];
  List <int>  price= [];
  List <bool>  isFavorit= [];
  List <bool>  toxic= [];
  List <int>  temp= [];
  List <int>  light= [];

///////////////////


  bool isDrawerOpen = false;
  Future<void> ukid2() async {
    final SharedPreferences prefs = await _prefs;
    final String counter = (prefs.getString('skill') ?? '');
    final String counter2 = (prefs.getString('pet') ?? '');
    setState(() {
      skill=counter;
      pet=counter2;
      if(pet=="yes") {
        finalPet="toxic";
      } else{
        finalPet="non toxic";
      }

    });
  }





  @override
  void initState() {
    controller = PageController(viewportFraction: 0.6, initialPage: 0);
    ukid2();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              height: 6,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Plant shop", style: TextStyle(color: tabcolor1,fontSize: 23,fontWeight: FontWeight.bold),),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //builder: (builder) => DetailsPage(plant: plants[index]),
                            builder: (builder) => CartTab(),
                          ),
                        );

                  }, icon: Icon(Icons.shopping_cart, color: Colors.black54,))
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45.0,
                    width: h-(h*0.24),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: green),
                      boxShadow: [
                        BoxShadow(
                          color: green.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         SizedBox(
                          height: 45,
                          width: h-(h*0.4),
                          child: TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(

                                      builder: (builder) => SearchScreen()));
                            },
                          )
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(

                                    builder: (builder) => SearchScreen()));

                          },
                          child: Image.asset(
                            'assets/icons/search.png',
                            height: 25,
                          ),
                        )
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //builder: (builder) => DetailsPage(plant: plants[index]),
                          builder: (builder) => ImageDetectPN(),
                        ),
                      );
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: tabcolor1.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(FontAwesomeIcons.camera, color: Colors.white,),
                    ),
                  ),
                ],
              ),
            ),
            /*SizedBox(
              height: 35.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < categories.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() => selectId = categories[i].id);
                        setState(() {
                          selectId = categories[i].id;
                          selesctedcat = categories[i].name;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            categories[i].name,
                            style: TextStyle(
                              color: selectId == i
                                  ? green
                                  : black.withOpacity(0.7),
                              fontSize: 16.0,
                            ),
                          ),
                          if (selectId == i)
                            const CircleAvatar(
                              radius: 3,
                              backgroundColor: green,
                            )
                        ],
                      ),
                    )
                ],
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended',
                    style: TextStyle(
                      color: black.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  PopupMenuButton(
                    // add icon, by default "3 dot" icon
                      icon: Icon(Icons.more_horiz, color: Colors.black45,),
                      itemBuilder: (context){
                        return [
                          PopupMenuItem<int>(
                            value: 0,
                            child: Text("Tools"),
                          ),
                          PopupMenuItem<int>(
                            value: 1,
                            child: Text("Soil"),
                          ),

                          PopupMenuItem<int>(
                            value: 2,
                            child: Text("fertize"),
                          ),

                        ];
                      },
                      onSelected:(value){
                        if(value == 0){

                          setState(() {
                            selecteditem="Tools";
                          });
                          print("tools selected.");
                        }else if(value == 1){
                          setState(() {
                            selecteditem="soil";
                          });
                          print("selected.");
                        }else if(value == 2){
                          setState(() {
                            selecteditem="soil";
                          });
                          print("selected.");
                        }
                      }
                  ),

                ],
              ),
            ),

            Container(
              child: skill=="easy"?StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("houseplant-v3")
                      .where('care',isEqualTo: "easy")
                      .where('toxic',isEqualTo: finalPet)
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
                      return   Container(
                        width: MediaQuery.of(context).size.width*0.32,
                        height: (MediaQuery.of(context).size.width*0.32)*1.2,
                        margin: const EdgeInsets.only(right: 0, bottom: 0),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(0.05),

                          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),

                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: (MediaQuery.of(context).size.width*0.32)*1.65,
                        child: ListView.builder(
                          //physics: const ClampingScrollPhysics(),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                            snapshot.data == null ? 0 : snapshot.data!.docs.length,
                            itemBuilder: (_, index) {
                              DocumentSnapshot _documentSnapshot =
                              snapshot.data!.docs[index];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
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
                                    width: MediaQuery.of(context).size.width*0.32,
                                    margin: const EdgeInsets.only(right: 0, bottom: 0),
                                    decoration: BoxDecoration(


                                      borderRadius: BorderRadius.circular(20.0),
                                      /*image: DecorationImage(
                                        //image: AssetImage(imagePath[index]),
                                        image: NetworkImage(_documentSnapshot['imagePath']),
                                        fit: BoxFit.cover,
                                      ),*/
                                    ),
                                    child: Expanded(
                                      child: Column(

                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.32,
                                            height: (MediaQuery.of(context).size.width*0.32)*1.2,
                                            margin: const EdgeInsets.only(right: 0, bottom: 0),
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey.withOpacity(0.05),

                                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                              image: DecorationImage(
                                                //image: AssetImage(imagePath[index]),
                                                image: CachedNetworkImageProvider(_documentSnapshot['imagePath']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 2,),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              _documentSnapshot['name'],
                                              overflow: TextOverflow.fade,
                                              maxLines: 2,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,color: Colors.black54,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );

                            }),
                      ),
                    );
                  }):StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("houseplant-v3")
                      .where('toxic',isEqualTo: finalPet)
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
                        child: Text(""),

                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: (MediaQuery.of(context).size.width*0.32)*1.65,
                        child: ListView.builder(
                          //physics: const ClampingScrollPhysics(),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                            snapshot.data == null ? 0 : snapshot.data!.docs.length,
                            itemBuilder: (_, index) {
                              DocumentSnapshot _documentSnapshot =
                              snapshot.data!.docs[index];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
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
                                    width: MediaQuery.of(context).size.width*0.32,
                                    margin: const EdgeInsets.only(right: 0, bottom: 0),
                                    decoration: BoxDecoration(


                                      borderRadius: BorderRadius.circular(20.0),
                                      /*image: DecorationImage(
                                        //image: AssetImage(imagePath[index]),
                                        image: NetworkImage(_documentSnapshot['imagePath']),
                                        fit: BoxFit.cover,
                                      ),*/
                                    ),
                                    child: Expanded(
                                      child: Column(

                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.32,
                                            height: (MediaQuery.of(context).size.width*0.32)*1.2,
                                            margin: const EdgeInsets.only(right: 0, bottom: 0),
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey.withOpacity(0.05),

                                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                              image: DecorationImage(
                                                //image: AssetImage(imagePath[index]),
                                                image: NetworkImage(_documentSnapshot['imagePath']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 2,),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              _documentSnapshot['name'],
                                              overflow: TextOverflow.fade,
                                              maxLines: 2,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,color: Colors.black54,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );

                            }),
                      ),
                    );
                  }),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'All Categories',
                style: TextStyle(
                  color: black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.width*0.4,
              child: ListView.builder(
                //physics: const ClampingScrollPhysics(),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories2.length,
                  itemBuilder: (_, index) {


                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              //builder: (builder) => DetailsPage(plant: plants[index]),
                              builder: (builder) => CategoryAll(category1: categories2[index].lebel, category2: categories2[index].name),
                            ),
                          );

                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.19,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width*0.09,
                                backgroundColor: Colors.greenAccent.withOpacity(0.4),
                                backgroundImage: NetworkImage(categories2[index].imagePath),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                categories2[index].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,color: Colors.black45,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  }),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Featured Shops',
                style: TextStyle(
                  color: black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("seller-user-v2")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }



                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width*0.4,
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                          snapshot.data == null ? 0 : snapshot.data!.docs.length,
                          itemBuilder: (_, index) {
                            DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];

                            return Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      //builder: (builder) => DetailsPage(plant: plants[index]),
                                      builder: (builder) => SellerDetails(seller: Seller(
                                          id: _documentSnapshot['id'],
                                          name: _documentSnapshot['store-name'],
                                          imagePath:_documentSnapshot['imagePath'],
                                      )),
                                    ),
                                  );

                                },
                                child: Container(


                                  margin: const EdgeInsets.only(right: 0, bottom: 0),
                                  decoration: BoxDecoration(


                                    borderRadius: BorderRadius.circular(20.0),
                                    /*image: DecorationImage(
                                        //image: AssetImage(imagePath[index]),
                                        image: NetworkImage(_documentSnapshot['imagePath']),
                                        fit: BoxFit.cover,
                                      ),*/
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.50,
                                        height: MediaQuery.of(context).size.width*0.25,
                                        margin: const EdgeInsets.only(right: 0, bottom: 0),
                                        decoration: BoxDecoration(
                                          color: lightGreen,

                                          borderRadius: BorderRadius.circular(20.0),
                                          image: DecorationImage(
                                            //image: AssetImage(imagePath[index]),
                                            image: NetworkImage(_documentSnapshot['imagePath']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        _documentSnapshot['store-name'],
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,color: Colors.black54,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                            /*Card(
                elevation: 0.4,
                child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(_documentSnapshot['images']),
                      ),
                      title: Text(
                        _documentSnapshot['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
                      ),
                      subtitle: Text("\$ ${_documentSnapshot['price']}"),
                      trailing: GestureDetector(
                        child: CircleAvatar(
                          child: Icon(Icons.cancel_outlined),
                        ),
                        onTap: () {
                        },
                      ),
                ),
              );*/
                          }),
                    ),
                  );
                }),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pots and accessories',
                    style: TextStyle(
                      color: black.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  PopupMenuButton(
                    // add icon, by default "3 dot" icon
                      icon: Icon(Icons.more_horiz, color: Colors.black45,),
                      itemBuilder: (context){
                        return [
                          PopupMenuItem<int>(
                            value: 0,
                            child: Text("Tools"),
                          ),
                          PopupMenuItem<int>(
                            value: 1,
                            child: Text("Soil"),
                          ),

                          PopupMenuItem<int>(
                            value: 2,
                            child: Text("fertize"),
                          ),

                        ];
                      },
                      onSelected:(value){
                        if(value == 0){

                          setState(() {
                            selecteditem="Tools";
                          });
                          print("tools selected.");
                        }else if(value == 1){
                          setState(() {
                            selecteditem="soil";
                          });
                          print("selected.");
                        }else if(value == 2){
                          setState(() {
                            selecteditem="soil";
                          });
                          print("selected.");
                        }
                      }
                  ),

                ],
              ),
            ),


            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("products-accessories")
                    .where('category',isEqualTo: selecteditem)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }



                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 110,
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                          snapshot.data == null ? 0 : snapshot.data!.docs.length,
                          itemBuilder: (_, index) {
                            DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];

                            return Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
            context,
            MaterialPageRoute(
              //builder: (builder) => DetailsPage(plant: plants[index]),
              builder: (builder) => DetailsPage3(plant: plantk= PlantF(
                id:_documentSnapshot['id'],
                name:_documentSnapshot['name'],
                botanical_name: "",
                imagePath:_documentSnapshot['imagePath'],
                category:_documentSnapshot['category'],
                care: "",
                description:_documentSnapshot['description'],
                water_winter: 0,
                water_summer: 0,
                fertilizer: 0,
                temp_from: 0,
                temp_to: 0,
                price:11,
                isFavorit:_documentSnapshot['isFavorit'],

                light:"",
                toxic:"",
              )),
            ),
          );

                                },
                                child: Container(

                                  width: MediaQuery.of(context).size.width*0.75,
                                  margin: const EdgeInsets.only(right: 0, bottom: 0),
                                  decoration: BoxDecoration(
                                    color: lightGreen,
                                    boxShadow: [
                                      BoxShadow(
                                        color: green.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.black12,
                                        backgroundImage: NetworkImage(_documentSnapshot['imagePath']),
                                      ),
                                      title: Text(
                                        _documentSnapshot['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,color: Colors.black45, fontSize: 18),
                                      ),
                                      subtitle: Text(" ${_documentSnapshot['category']}"),
                                      trailing: Icon(Icons.arrow_right),
                                    ),
                                  ),
                                ),
                              ),
                            );

                            /*Card(
                elevation: 0.4,
                child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(_documentSnapshot['images']),
                      ),
                      title: Text(
                        _documentSnapshot['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
                      ),
                      subtitle: Text("\$ ${_documentSnapshot['price']}"),
                      trailing: GestureDetector(
                        child: CircleAvatar(
                          child: Icon(Icons.cancel_outlined),
                        ),
                        onTap: () {
                        },
                      ),
                ),
              );*/
                          }),
                    ),
                  );
                }),


            SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }

  AnimatedContainer slider(active, index) {
    double margin = active ? 20 : 30;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      child: mainPlantsCard(index),
    );
  }

  Widget mainPlantsCard(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            //builder: (builder) => DetailsPage(plant: plants[index]),
            builder: (builder) => DetailsPage2(plant: plantF[index]),
          ),
        );
      },
      child: Container(
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
          border: Border.all(color: green, width: 2),
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
                  image: NetworkImage(plantF[index].imagePath),
                  fit: BoxFit.cover,
                ),
                /*image: DecorationImage(
                  image: NetworkImage('https://www.exampledomain.com/images/background.jpg'),
                  fit: BoxFit.fill,
                ),*/
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: CircleAvatar(
                backgroundColor: green,
                radius: 15,
                child: Image.asset(
                  'assets/icons/add.png',
                  color: white,
                  height: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  //'${plants[index].name} - \$${plants[index].price.toStringAsFixed(0)}'
                  '${name[index]} - \$${price[index].toStringAsFixed(0)}',
                  style: TextStyle(
                    color: black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  } 

  int selectId = 0;
  String selesctedcat="Indoor";
  int activePage = 0;
}
