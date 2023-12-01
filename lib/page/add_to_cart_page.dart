import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_location_picker/open_location_picker.dart' as asd;
import 'package:ui_13/data/order_model.dart';
import '../core/color.dart';


class AddToCart extends StatefulWidget {
  final OrderPlant orderPlant;
  const AddToCart({Key? key, required this.orderPlant}) : super(key: key);

  @override
  _AddToCartState createState() => _AddToCartState();
}

const kGoogleApiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');
final homeScaffoldKey = GlobalKey<ScaffoldState>();
class _AddToCartState extends State<AddToCart> {

  bool lightonoff=true;
  bool newLocationStatus=true;
  bool findnewLocation=false;
  bool insideStatus=true;
  bool nextbutton =false;
  bool beforenxtbtn= true;
  bool deliveryview=false;
  bool nextbuttonshow=true;

  int temp_rewards_avail=0;
  int spent_rewards=0;
  int left_rewards=0;
  int cost_after_rewards=-1;
  late String stToint;
  String showStatus="";

  
  
  
  late GoogleMapController googleMapController;

  double lat=0.0;
  double lon=0.0;
  var addressFull="";
  TextEditingController _buildingnoController = TextEditingController();
  TextEditingController _floornoController = TextEditingController();
  TextEditingController _streetnoController = TextEditingController();
  TextEditingController _rewardsController = TextEditingController();

  TextEditingController _mobilenoOneController = TextEditingController();
  TextEditingController _mobilenoTwoController = TextEditingController();

  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(23.758169000000002, 90.38168119730067), zoom: 14);
  Set<Marker> markers = {};

  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-cart-items2");
    return _collectionRef
        .doc()
        .set({
      "name": widget.orderPlant.name,
      "id": widget.orderPlant.id,
      "email":currentUser!.email,
      "price": cost_after_rewards==-1?totalpriceWtihDeliveryCost():cost_after_rewards,
      "images": widget.orderPlant.imagePath,
      "lat": lat,
      "lon": lon,
      "adress":addressFull,
      "houseNo":_buildingnoController.text,
      "floorNo":_floornoController.text,
      "street":_streetnoController.text,
      "contactNumber":_mobilenoOneController.text,
      "contactNumberTwo":_mobilenoTwoController.text,
      "status":"On hold",

    }).then((value) {
      print("Added to cart");
      updateRewards();

    });
  }
  
  int totalprice() {
    int a=((widget.orderPlant.quantity)*widget.orderPlant.price);
    return a;
  }

  int priceAfterReward() {
    int a=totalpriceWtihDeliveryCost()-spent_rewards;
    return a;
  }

  int totalpriceWtihDeliveryCost() {
    if(insideStatus==true) {
      return totalprice() +widget.orderPlant.insideCost;
    } else {
      return totalprice() +widget.orderPlant.outsideCost;
    }
    
  }

  Future updateRewards() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("rewards");
    return _collectionRef
        .doc(currentUser!.email)
        .update({

      "temp-rewards":left_rewards,

    }).then((value) => Navigator.of(context).pop());
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  currentLocation() async{
    Position position = await _determinePosition();
    lat=position.latitude;
    lon=position.longitude;
    print(position);
    print("jjjjjjjjjjjjj");
    List<Placemark> placemarks=await placemarkFromCoordinates(23.7581617, 90.3862665);
    Placemark place=placemarks[0];
    addressFull="";
    addressFull='${place.name}, ${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}';


    print(addressFull);



    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lon), zoom: 17)));


    markers.clear();

    markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(lat, lon)));

    setState(() {});
  }

  fatchtask () async{
    var _firestoreInstance = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> qn = await _firestoreInstance.collection("rewards")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    print("function working");


    setState(() {
      //temp_rewards_avail=qn['email'];
      print(qn.data());
      print(qn.get("email"));
      print(qn.get("temp-rewards"));
      temp_rewards_avail=qn.get("temp-rewards");
      left_rewards=temp_rewards_avail;
    });




    return qn;

  }

  @override
  void initState() {
    super.initState();
    //currentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        title: Text("Add to cart", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              beforenxtbtn?Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        Text("where Would you like to receive the product?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: tabcolor1),),

                        SizedBox(height: 14,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        insideStatus=true;
                                      });




                                    },
                                    child: Container(
                                      decoration: BoxDecoration(

                                        color: insideStatus?Colors.greenAccent.withOpacity(0.6):Colors.white,
                                        border: Border.all(
                                          color: insideStatus?Colors.white:Colors.black38,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(24),

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(widget.orderPlant.sellerLoc,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6,),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        insideStatus=false;
                                      });




                                    },
                                    child: Container(
                                      decoration: BoxDecoration(

                                        color: !insideStatus?Colors.greenAccent.withOpacity(0.6):Colors.white,
                                        border: Border.all(
                                          color: !insideStatus?Colors.white:Colors.black38,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(24),

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text("Outside",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 0,),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),

                    Container(),
                    Container(
                      margin: const EdgeInsets.only(right: 0, bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.black12,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black12,
                              backgroundImage: NetworkImage(widget.orderPlant.imagePath),
                            ),
                            title: Text(
                              widget.orderPlant.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,color: Colors.black45, fontSize: 18),
                            ),
                            subtitle: Text(" X${widget.orderPlant.quantity}"),
                            trailing: Text("Total: ${totalprice()}TK",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 6,),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                            title: Text(
                              "Delivery charge",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,color: Colors.black45, fontSize: 18),
                            ),
                            subtitle: Text(insideStatus?"Inside "+widget.orderPlant.sellerLoc:"Outside "+widget.orderPlant.sellerLoc+")"),
                            trailing: Text("     : ${insideStatus?widget.orderPlant.insideCost:widget.orderPlant.outsideCost}TK",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 12),
                            child: Divider(
                              color: Colors.grey.withOpacity(0.6),
                            ),
                          ),
                          ListTile(
                            trailing: Text("Total: ${totalpriceWtihDeliveryCost()}TK",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),

                        ],
                      ),
                    ),


                    SizedBox(height: 14,),

                  ],
                ),
              ):SizedBox(height: 0,),
              nextbutton?Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  children: [
                    Container(
                      decoration: BoxDecoration(

                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Address:",style: TextStyle(
                                  color: black.withOpacity(0.9),
                                  fontSize: 18.0,
                                  height: 1.4,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          lightonoff=true;
                                        });
                                        newLocationStatus=true;
                                        findnewLocation=false;

                                        currentLocation();

                                      },
                                      child: Container(
                                        decoration: BoxDecoration(

                                          color: lightonoff?Colors.blueAccent.withOpacity(0.6):Colors.white,
                                          border: Border.all(
                                            color: lightonoff?Colors.white:Colors.black38,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(24),

                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text("Current"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 3,),
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          lightonoff=false;
                                        });
                                        newLocationStatus=false;
                                        findnewLocation=true;





                                      },
                                      child: Container(
                                        decoration: BoxDecoration(

                                          color: !lightonoff?Colors.blueAccent.withOpacity(0.6):Colors.white,
                                          border: Border.all(
                                            color: !lightonoff?Colors.white:Colors.black38,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(24),

                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text("Find new"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),

                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(

                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black87,
                                  width: 1,
                                ),
                                //borderRadius: BorderRadius.circular(24),

                              ),
                              height: MediaQuery.of(context).size.width*0.4,
                              width: MediaQuery.of(context).size.width,
                              child: GoogleMap(
                                initialCameraPosition: initialCameraPosition,
                                markers: markers,
                                zoomControlsEnabled: true,
                                mapType: MapType.normal,
                                onMapCreated: (GoogleMapController controller)  async {
                                  googleMapController = controller;


                                  /*Position position = await _determinePosition();

                              googleMapController
                                  .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 17)));


                              markers.clear();

                              markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));

                              setState(() {});*/
                                },
                              ),
                            ),
                            SizedBox(height: 6,),
                            Visibility(
                              visible: !findnewLocation?false:true,
                              child: asd.OpenMapPicker(

                                options: asd.OpenMapOptions(center: asd.LatLng(23.7580743,90.3871886)),
                                decoration: const InputDecoration(
                                  hintText: "Tap here to search location",
                                ),
                                onChanged: (asd.FormattedLocation? v) {

                                  lat=v!.lat;
                                  lon=v.lon;

                                  googleMapController
                                      .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lon), zoom: 17)));


                                  markers.clear();

                                  markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(lat, lon)));

                                  setState(() {});


                                  print(v.displayName);
                                  addressFull="";
                                  addressFull=v.displayName;
                                  print("lat: "+lat.toString());
                                  print("lon: "+lon.toString());
                                },
                                onSaved: (asd.FormattedLocation? newValue) {
                                  // save new value

                                },
                              ),
                            ),
                            SizedBox(height: 6,),
                            ExpansionTile(
                                title: Text("More details (optional)"),
                                children: [
                                  TextField(

                                    controller: _buildingnoController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: "Building number (optional)",
                                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey)
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  TextField(

                                    controller: _floornoController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: "Floor number (optional)",
                                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey)
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  TextField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: "street number (optional)",
                                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey)
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey)
                                      ),
                                    ),
                                  ),
                                ],
                            ),
                            ExpansionTile(
                              title: Text("use cradits"),
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: tabcolor2.withOpacity(0.25),

                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                          topLeft: Radius.circular(12),
                                        ),

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Available: "+temp_rewards_avail.toString(), style: TextStyle(color: tabcolor1,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                TextField(

                                  controller: _rewardsController,
                                  obscureText: false,
                                  keyboardType: TextInputType.number,

                                  decoration: InputDecoration(
                                    labelText: "Enter amount",
                                    hintText: "ex 50"+temp_rewards_avail.toString(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey)
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey)
                                    ),
                                  ),
                                  onChanged: (val) {

                                    setState(() {
                                      stToint=val.toString();
                                      print(stToint);
                                      if(num.tryParse(stToint) !=null) {
                                        spent_rewards = int.parse(stToint);
                                        left_rewards=temp_rewards_avail-spent_rewards;
                                        if(left_rewards<0) {
                                          showStatus="insufficient credits";
                                          print(showStatus);
                                          left_rewards=temp_rewards_avail;
                                        } else {
                                          showStatus="Total cost after using credits: ";
                                          print(showStatus);
                                          cost_after_rewards=priceAfterReward();
                                        }
                                        print(spent_rewards);
                                        print(left_rewards);
                                        print(cost_after_rewards==-1?totalpriceWtihDeliveryCost():cost_after_rewards);

                                      } else {
                                        showStatus="Type in only number!";
                                      }
                                      if(val.isEmpty) {
                                        showStatus="";
                                        left_rewards=temp_rewards_avail;
                                        cost_after_rewards=totalpriceWtihDeliveryCost();
                                      }

                                    });
                                  },
                                ),
                                Visibility(
                                    visible: showStatus.length<2?false:true,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(height: 1.5,),
                                    )),

                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(fontSize: 16),
                                  children: [
                                    showStatus=="Total cost after using credits: "?TextSpan(text: showStatus+"dkjsdkjcnsdkjnckdjcsdnckjsjdc", style: TextStyle(fontSize: 16,color: Colors.black87)):TextSpan(text: ""),
                                    showStatus=="Total cost after using credits: "?TextSpan(text: cost_after_rewards.toString()+"TK",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black87)):TextSpan(text: ""),
                                    showStatus=="insufficient credits"?TextSpan(text: showStatus, style: TextStyle(fontSize: 16,color: Colors.red)):TextSpan(text: ""),
                                    showStatus=="Type in only number!"?TextSpan(text: showStatus, style: TextStyle(fontSize: 16,color: Colors.blueGrey)):TextSpan(text: ""),

                                  ]),
                                ),
                                Visibility(
                                    visible: showStatus.length<2?false:true,
                                    child: SizedBox(height: 6,)),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),


                    SizedBox(height: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your contact number:",style: TextStyle(
                          color: black.withOpacity(0.9),
                          fontSize: 18.0,
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),),
                        SizedBox(height: 6,),
                        TextField(

                          controller: _mobilenoOneController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: "01XXXXXXXX9",
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        SizedBox(height: 6,),
                        TextField(

                          controller: _mobilenoTwoController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: "01XXXXXXXX9 (optional)",
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),

                      ],
                    ),


                  ],
                ),
              ):SizedBox(height: 0,),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: nextbuttonshow?true:false,
            child: ElevatedButton(


              onPressed: () {
                setState(() {
                  nextbuttonshow=false;
                  nextbutton=true;
                  beforenxtbtn=false;
                });
                currentLocation();
                fatchtask();
              },
              child: const Text('     Next     ', style: TextStyle(fontWeight: FontWeight.bold),),
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
          Visibility(
            visible: !nextbuttonshow?true:false,
            child: ElevatedButton(


              onPressed: () {
                if(showStatus=="" || showStatus=="Total cost after using credits: ") {
                  Fluttertoast.showToast(msg: "Wait..",toastLength: Toast.LENGTH_SHORT, textColor: Colors.white,backgroundColor: Colors.pink);
                  addToCart();
                } else {
                  Fluttertoast.showToast(msg: "left 'use credits' field blank or enter sufficient credits");
                }

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('     Confirm Order     ', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
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
    );
  }


}