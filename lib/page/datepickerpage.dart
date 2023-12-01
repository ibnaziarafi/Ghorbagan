import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:ui_13/data/task_model_with_data.dart';
import 'package:ui_13/page/fertilizer_instruction_page.dart';
import 'package:ui_13/page/water_instruction_page.dart';
import '../core/color.dart';
import 'package:weather/weather.dart';

class Datepickertimeline extends StatefulWidget {


  @override
  _DatepickertimelineState createState() => _DatepickertimelineState();
}

class _DatepickertimelineState extends State<Datepickertimeline> {
  DatePickerController _controller = DatePickerController();


  List<QueryDocumentSnapshot<Object?>> _documentSnapshot2=[];
  List<QueryDocumentSnapshot<Object?>> _documentSnapshot3=[];
  bool isvisible=true;

  //late Position position;
  late double lat=23.0377;
  late double lon=91.4161;
  String key =const String.fromEnvironment('WEATHER_API_KEY');
  late String tempc="00";
  String tempstatus="Cloudy";
  bool istask=false;
  List<dynamic> getDatelist=[];
  String uniqueTaskname='';
  String todatDate='';








  DateTime _selectedValue = DateTime.now();

  List months =
  ['JAN', 'FEB', 'MAR', 'APR', 'MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
  late var now = new DateTime.now();
  late var date = new DateTime(_selectedValue.year, _selectedValue.month, _selectedValue.day);
  late String datewithoutmin = date.toString().replaceAll(" 00:00:00.000", "");


  late var monthindex=_selectedValue.month;
  late int mmindex=monthindex.toInt();

  late DateTime converted;
  late var convertdate=datewithoutmin;

  List<TaskFirebase> data2 = [];
  List<TaskFirebase> datawithtag1 = [];
  List<TaskFirebase> datawithtag2 = [];
  List<TaskFirebase> datawithtag3 = [];

   late TaskFirebase tt;
  late TaskFull tfromdb;
  List<TaskFull> totaltaskfromdb=[];
  loc.Location location=loc.Location();

  Future enabledlocation() async {
    bool service;

    service = await location.serviceEnabled();

    if(!service) {
       location.requestService().then((value) {
         setState(() {
           geofunction();
         });
       });
    }

    print("  nn  ");

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

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  geofunction() async {

    Position position = await _determinePosition();
    lat=position.latitude;
    lon=position.longitude;

    WeatherFactory wf = WeatherFactory(key);
    Weather w = await wf.currentWeatherByLocation(lat, lon);

    int tmpi=w.temperature!.celsius!.toInt();

    setState(() {
     tmpi=w.temperature!.celsius!.toInt();
     tempc=tmpi.toString();
     tempstatus=w.weatherMain.toString();
    });
  }


  function2 () async{
  /*  for(int i=0;i<data1.length;i++) {

      datechanger.add(DateTime.parse(data1[i].id)) ;
    }*/

    for(int i=0;i<_documentSnapshot3.length;i++) {

      tfromdb = TaskFull(

        name: _documentSnapshot3[i]["name"],
        unique_name: _documentSnapshot3[i]["unique-name"],
        full: _documentSnapshot3[i]["datelist"],
        tag: _documentSnapshot3[i]["tag"],
        imagePath: _documentSnapshot3[i]["imagePath"],
      );

      totaltaskfromdb.add(
          tfromdb
      );

    }

      this.totaltaskfromdb=totaltaskfromdb;
    data2.clear();
    datawithtag1.clear();
    datawithtag2.clear();
    datawithtag3.clear();

  }

  function1() {
    setState(() {
    for(int i=0;i<totaltaskfromdb.length;i++) {
      for(int b=0;b<totaltaskfromdb[i].full.length;b++) {
        if (convertdate==totaltaskfromdb[i].full[b]) {
          tt= TaskFirebase(
            id:totaltaskfromdb[i].full[b],
            name:totaltaskfromdb[i].name,
            uniqueName: totaltaskfromdb[i].unique_name,
            tag: totaltaskfromdb[i].tag,
            imagePath: totaltaskfromdb[i].imagePath,
          );
          data2.add(tt);

        }

      }
    }
    this.data2=data2;
    });

  }

  function3() {
    for(int i=0;i<totaltaskfromdb.length;i++) {
      for(int b=0;b<totaltaskfromdb[i].full.length;b++) {
        if (convertdate==totaltaskfromdb[i].full[b]) {
          tt= TaskFirebase(
            id:totaltaskfromdb[i].full[b],
            name:totaltaskfromdb[i].name,
            uniqueName: totaltaskfromdb[i].unique_name,
            tag: totaltaskfromdb[i].tag,
            imagePath: totaltaskfromdb[i].imagePath,
          );
          data2.add(tt);

        }

      }
    }

    if (data2.isNotEmpty) {
      istask=true;
    } else{
      istask =false;
    }

    for(int i=0;i<data2.length;i++) {
      if(data2[i].tag=="water") {
        tt= TaskFirebase(
          id:data2[i].id,
          name:data2[i].name,
          uniqueName: data2[i].uniqueName,
          tag: data2[i].tag,
          imagePath: data2[i].imagePath,
        );
        datawithtag1.add(tt);
      }
    } //watering list
    for(int i=0;i<data2.length;i++) {
      if(data2[i].tag=="mist") {
        tt= TaskFirebase(
          id:data2[i].id,
          name:data2[i].name,
          uniqueName: data2[i].uniqueName,
          tag: data2[i].tag,
          imagePath: data2[i].imagePath,
        );
        datawithtag2.add(tt);
      }
    } //mist list
    for(int i=0;i<data2.length;i++) {
      if(data2[i].tag=="fertilizer") {
        tt= TaskFirebase(
          id:data2[i].id,
          name:data2[i].name,
          uniqueName: data2[i].uniqueName,
          tag: data2[i].tag,
          imagePath: data2[i].imagePath,
        );
        datawithtag3.add(tt);
      }
    } //WM list



  }

  //////



  fatchtask () async{
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("task-v2")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .where("status", isEqualTo: 1)
        .get();


    setState(() {

      for(int i = 0; i<=qn.docs.length;i++) {
        print(qn.docs[i]["name"]);
        print(qn.docs[i]["datelist"]);
        print(qn.docs[i]["tag"]);
        print(qn.docs[i]["imagePath"]);
        print(totaltaskfromdb);





        tfromdb = TaskFull(

          name: qn.docs[i]["name"],
          unique_name: qn.docs[i]["unique-name"],
          full: qn.docs[i]["datelist"],
          tag: qn.docs[i]["tag"],
          imagePath: qn.docs[i]["imagePath"],
        );

        totaltaskfromdb.add(
            tfromdb
        );
        this.totaltaskfromdb=totaltaskfromdb;
      }
    });




    return qn.docs;

  }

  Future updateList() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("task-v2");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(uniqueTaskname)
        .update({

      "datelist":getDatelist,


    }).then((value) => print("Successful"));
  }

  ////


  @override
  void initState() {
    super.initState();
   // function2();

    convertdate = datewithoutmin;
    mmindex=mmindex;
    todatDate=new DateTime(now.year, now.month,now.day).toString().replaceAll(" 00:00:00.000", "");


    enabledlocation();
    geofunction();

    //function2();
   // fatchtask();
    //function2();
   // function1();
  //  print(data1[0].id);
   // print(data2);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      //padding: const EdgeInsets.all(8.0),
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(

                            children: [
                              Icon(FontAwesomeIcons.calendarDays,color: Colors.grey,size: 18,),
                              Text(" "),
                              Text(months[mmindex-1], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, fontFamily: 'Gilroy-Bold')),
                              Text(" "),
                              Text(_selectedValue.year.toString(),style: TextStyle(fontSize: 18,)),
                            ],
                          ),
                          Column(

                            children: [

                              Text(tempc+'\u00B0 C', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, fontFamily: 'Gilroy-Bold')),

                              Text(tempstatus,style: TextStyle(fontSize: 18,)),
                            ],
                          ),

                        ],
                      )
                    ),
                    Container(
                      child: DatePicker(
                        DateTime.now(),
                        width: 60,
                        height: 80,
                        controller: _controller,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: tabcolor2.withOpacity(0.9),
                        selectedTextColor: Colors.white,

                        monthTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 0),
                        dayTextStyle: TextStyle(letterSpacing: 3,fontSize: 10),

                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            _selectedValue = date;

                            date = new DateTime(_selectedValue.year, _selectedValue.month, _selectedValue.day);
                            datewithoutmin = date.toString().replaceAll(" 00:00:00.000", "");
                            convertdate = datewithoutmin;
                             monthindex=_selectedValue.month;
                             mmindex=monthindex.toInt();
                             todatDate=new DateTime(now.year, now.month,now.day).toString().replaceAll(" 00:00:00.000", "");
                            data2.clear();



                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),



                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("task-v2")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("items")
                .where("status", isEqualTo: 1)
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something is wrong"),
                    );
                  }
                  if(snapshot.hasData) {
                    _documentSnapshot2 =snapshot.data!.docs;
                    _documentSnapshot3=_documentSnapshot2;
                    function2();
                    function3();
                    totaltaskfromdb.clear();



                  }





                  return Column(
                    children: [
                      Visibility(
                          visible: istask == false ? true : false,
                          child: SizedBox(height: MediaQuery.of(context).size.width*0.2,)),
                      Visibility(
                          visible: istask == false ? true : false,
                          child: Container(
                            height: MediaQuery.of(context).size.width*0.6,
                            width: MediaQuery.of(context).size.width*0.9,

                            decoration: BoxDecoration(
                              color: Colors.white,

                              image: DecorationImage(
                                  opacity: 0.9,

                                  image: AssetImage("assets/images/notask.jpg"),
                                  fit: BoxFit.cover),

                              borderRadius: BorderRadius.circular(32),


                            ),
                          )),
                      Visibility(
                          visible: istask == false ? true : false,
                          child: SizedBox(height: 10,)),
                      Visibility(
                          visible: istask == false ? true : false,
                          child: Text("it's all clear. Relax and recharge.", style: TextStyle(fontWeight: FontWeight.normal,letterSpacing: 1,fontSize: 12),),),
                      //no task if
                      Visibility(
                        visible: datawithtag1.length == 0 ? false : true,
                        child: SizedBox(
                          height: 35.0,
                          child: Row(
                            children: [
                              Container(
                                height: 12,
                                width: 20,
                                decoration: BoxDecoration(

                                  color: Colors.lightBlue.withOpacity(0.3),
                                  
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12)),
                                ),
                              ),
                              Text("  "),
                              Text("W A T E R", style: TextStyle(fontWeight: FontWeight.normal,letterSpacing: 1,fontSize: 12),),

                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: datawithtag1.length == 0 ? false : true,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(24.5, 0.0, 3.9, 0.0),
                          child: Container(

                            decoration: BoxDecoration(

                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black12,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              /*boxShadow: [
                                BoxShadow(
                                  color: green.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],*/
                            ),

                            child: Column(
                              children: [

                                ConstrainedBox(

                                  constraints: BoxConstraints(maxHeight: 2500),

                                  // **THIS is the important part**
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: datawithtag1.length,
                                    padding: const EdgeInsets.only(left: 0.0),
                                    itemBuilder: (BuildContext context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 0, bottom: 8),
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
                                                leading: CircleAvatar(
                                                  backgroundImage: CachedNetworkImageProvider(datawithtag1[index].imagePath),
                                                ),
                                                title: Text(datawithtag1[index].name, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45),),
                                                subtitle: Text("tap to see instructions",),
                                                trailing: convertdate==todatDate?GestureDetector(
                                                    onTap:() {
                                                      for(int i=0;i<_documentSnapshot2.length;i++) {
                                                        if(_documentSnapshot2[i]['unique-name']==datawithtag1[index].uniqueName) {
                                                          getDatelist=_documentSnapshot2[i]['datelist'];
                                                        }
                                                      }
                                                      print(getDatelist);
                                                      print(getDatelist.length);
                                                      getDatelist.removeWhere((element) => element==datawithtag1[index].id);
                                                      print(getDatelist);
                                                      print(getDatelist.length);

                                                      uniqueTaskname=datawithtag1[index].uniqueName;
                                                      updateList();

                                                    },

                                                    child: Container(
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
                                                        padding: const EdgeInsets.all(7.0),
                                                        child: Icon(Icons.check_rounded,color: tabcolor1,),
                                                      ),
                                                    ),):Container(
                                                  decoration: BoxDecoration(
                                                    color: tabcolor2.withOpacity(0.25),

                                                    borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius.circular(6),
                                                      bottomRight: Radius.circular(6),
                                                      topRight: Radius.circular(6),
                                                      topLeft: Radius.circular(6),
                                                    ),

                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(7.0),
                                                    child: Text("Upcoming", style: TextStyle(color: tabcolor1),),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),),
                      //water list

                      Visibility(
                        visible: datawithtag2.length == 0 ? false : true,
                        child: SizedBox(
                          height: 35.0,
                          child: Row(
                            children: [
                              Container(
                                height: 12,
                                width: 20,
                                decoration: BoxDecoration(

                                  color: tabcolor2.withOpacity(0.48),

                                  borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12)),
                                ),
                              ),
                              Text("  "),
                              Text("M I S T", style: TextStyle(fontWeight: FontWeight.normal,letterSpacing: 1,fontSize: 12),),

                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: datawithtag2.length == 0 ? false : true,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(24.5, 0.0, 3.9, 0.0),
                          child: Container(

                            decoration: BoxDecoration(

                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black12,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),

                            ),

                            child: Column(
                              children: [

                                ConstrainedBox(

                                  constraints: BoxConstraints(maxHeight: 2000),

                                  // **THIS is the important part**
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: datawithtag2.length,
                                    padding: const EdgeInsets.only(left: 0.0),
                                    itemBuilder: (BuildContext context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 0, bottom: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,

                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap:() {

                                              },
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: CachedNetworkImageProvider(datawithtag2[index].imagePath),
                                                ),
                                                title: Text(datawithtag2[index].name, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45),),

                                                trailing: convertdate==todatDate?GestureDetector(
                                                  onTap:() {
                                                    for(int i=0;i<_documentSnapshot2.length;i++) {
                                                      if(_documentSnapshot2[i]['unique-name']==datawithtag2[index].uniqueName) {
                                                        getDatelist=_documentSnapshot2[i]['datelist'];
                                                      }
                                                    }
                                                    print(getDatelist);
                                                    print(getDatelist.length);
                                                    getDatelist.removeWhere((element) => element==datawithtag2[index].id);
                                                    print(getDatelist);
                                                    print(getDatelist.length);


                                                    uniqueTaskname=datawithtag2[index].uniqueName;
                                                    updateList();

                                                  },

                                                  child: Container(
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
                                                      padding: const EdgeInsets.all(7.0),
                                                      child: Icon(Icons.check_rounded,color: tabcolor1,),
                                                    ),
                                                  ),):Container(
                                                  decoration: BoxDecoration(
                                                    color: tabcolor2.withOpacity(0.25),

                                                    borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius.circular(6),
                                                      bottomRight: Radius.circular(6),
                                                      topRight: Radius.circular(6),
                                                      topLeft: Radius.circular(6),
                                                    ),

                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(7.0),
                                                    child: Text("Upcoming", style: TextStyle(color: tabcolor1),),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //mist list
                      Visibility(
                        visible: datawithtag3.length == 0 ? false : true,
                        child: SizedBox(
                          height: 35.0,
                          child: Row(
                            children: [
                              Container(
                                height: 12,
                                width: 20,
                                decoration: BoxDecoration(

                                  color: Colors.yellow.withOpacity(0.4),

                                  borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12)),
                                ),
                              ),
                              Text("  "),
                              Text("F E R T I L I Z E R", style: TextStyle(fontWeight: FontWeight.normal,letterSpacing: 1,fontSize: 12),),

                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: datawithtag3.length == 0 ? false : true,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(24.5, 0.0, 3.9, 0.0),
                          child: Container(

                            decoration: BoxDecoration(

                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black12,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),

                            ),

                            child: Column(
                              children: [

                                ConstrainedBox(

                                  constraints: BoxConstraints(maxHeight: 2000),

                                  // **THIS is the important part**
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: datawithtag3.length,
                                    padding: const EdgeInsets.only(left: 0.0),
                                    itemBuilder: (BuildContext context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 0, bottom: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,

                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          children: [
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
                                                  backgroundImage: CachedNetworkImageProvider(datawithtag3[index].imagePath),
                                                ),
                                                title: Text(datawithtag3[index].name, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45),),
                                                subtitle: Text("tap to see instructions",),
                                                trailing: convertdate==todatDate?GestureDetector(
                                                  onTap:() {
                                                    for(int i=0;i<_documentSnapshot2.length;i++) {
                                                      if(_documentSnapshot2[i]['unique-name']==datawithtag3[index].uniqueName) {
                                                        getDatelist=_documentSnapshot2[i]['datelist'];
                                                      }
                                                    }
                                                    print(getDatelist);
                                                    print(getDatelist.length);
                                                    getDatelist.removeWhere((element) => element==datawithtag3[index].id);
                                                    print(getDatelist);
                                                    print(getDatelist.length);

                                                    uniqueTaskname=datawithtag3[index].uniqueName;
                                                    updateList();

                                                  },

                                                  child: Container(
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
                                                      padding: const EdgeInsets.all(7.0),
                                                      child: Icon(Icons.check_rounded,color: tabcolor1,),
                                                    ),
                                                  ),):Container(
                                                  decoration: BoxDecoration(
                                                    color: tabcolor2.withOpacity(0.25),

                                                    borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius.circular(6),
                                                      bottomRight: Radius.circular(6),
                                                      topRight: Radius.circular(6),
                                                      topLeft: Radius.circular(6),
                                                    ),

                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(7.0),
                                                    child: Text("Upcoming", style: TextStyle(color: tabcolor1),),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //WM list






                    ],
                  );
                },
              ),
            ],
          ),
        ));
  }
}

//
/*
ListView.builder(
physics: const NeverScrollableScrollPhysics(),
shrinkWrap: true,
itemCount: data2.length,
padding: const EdgeInsets.only(left: 0.0),
itemBuilder: (BuildContext context, index) {
return Container(
margin: const EdgeInsets.only(right: 0, bottom: 8),
decoration: BoxDecoration(
color: Colors.green.withOpacity(0.1),
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
leading: CircleAvatar(
backgroundImage: NetworkImage(data2[index].imagePath),
),
title: Text(data2[index].name, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45),),
subtitle: Text("tap to see instructions",),
trailing: Text(data2[index].tag, style: TextStyle(letterSpacing: 4),),
),

],
),
);
},
),*/
