import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_13/core/color.dart';
import 'package:ui_13/data/plant_model_firestore.dart';
import 'package:ui_13/data/task_model_with_data.dart';

import '../page/fertilizer_instruction_page.dart';
import '../page/light_instruction_page.dart';
import '../page/soil_instruction_page.dart';
import '../page/water_instruction_page.dart';

class MyhouseplantAddDetailspage extends StatefulWidget {
/*  final Plants plant;
  const DetailsPage({Key? key, required this.plant}) : super(key: key);*/

  final HousePlantL plant;

  const MyhouseplantAddDetailspage({Key? key, required this.plant}) : super(key: key);

  @override
  State<MyhouseplantAddDetailspage> createState() => _MyhouseplantAddDetailspageState();
}

class _MyhouseplantAddDetailspageState extends State<MyhouseplantAddDetailspage> {
  late Taskpass tkpass;
  bool insideStatus=true;
  bool fstNext=true;
  bool secNext=false;
  bool trdNext=false;
  bool frthNext=false;
  bool circularCheck=false;

  String site="";
  String pot="";
  String taskName="";
  String drain="yes";
  ////
  var winter = 3;
  var summer =2;
  late var fertilize=0;

  var list=[];
  var list2=[];

  var list4=[];
  List<String> list5=[];

  var now = new DateTime.now();
  var now2= new DateTime.now();
  late var now3;
  late var t;
  late var dif2;
  late var delay;

  late var prechanger;
  late var changer;
  late var replacer;

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



  ////

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }



  makeDatelistWater() {
    winter=widget.plant.water_winter;
    summer=widget.plant.water_summer;

    var jan=(winter-((winter*10)/100)).round();
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

    for(int i=0;i<5;i++) {

      now3=(now2.month < 12) ? new DateTime(now2.year, now2.month + 1, 0) : new DateTime(now2.year + 1, 1, 0);
      int dif=daysBetween(now2,now3);

      if(now2.month==1) {
        dif2=dif/jan;
        delay=jan;
      } else if (now2.month==2) {
        dif2=dif/fab;
        delay=fab;
      } else if (now2.month==3) {
        dif2=dif/mar;
        delay=mar;
      }else if (now2.month==4) {
        dif2=dif/apr;
        delay=apr;
      }else if (now2.month==5) {
        dif2=dif/may;
        delay=may;
      }else if (now2.month==6) {
        dif2=dif/jun;
        delay=jun;
      }else if (now2.month==7) {
        dif2=dif/jul;
        delay=jul;
      }else if (now2.month==8) {
        dif2=dif/aug;
        delay=aug;
      }else if (now2.month==9) {
        dif2=dif/sep;
        delay=sep;
      }else if (now2.month==10) {
        dif2=dif/oct;
        delay=oct;
      }else if (now2.month==11) {
        dif2=dif/nov;
        delay=nov;
      }else if (now2.month==12) {
        dif2=dif/dec;
        delay=dec;
      }


      int dif3=dif2.round();
      print(dif3);
      if (dif3==0) {
        t=now2.add(new Duration(days: delay));
        now2=t;
        list.add(t);
        print(list);
        print(now2);
      } else {
        int ii=1;



        while(ii <=dif3) {
          t=now2.add(new Duration(days: delay));
          now2=t;
          list.add(t);
          ii=ii+1;
        }


        i=i+dif3;


      }

    }
    print(list);

    if(drain=="no" && winter<=6) {
      int increament=((summer*25)/100).round();

      for(int b=0; b<list.length;b++) {
        replacer=list[b].add(new Duration(days: increament*(b+1)));
        prechanger=new DateTime(replacer.year, replacer.month, replacer.day);
        changer=prechanger.toString().replaceAll(" 00:00:00.000", "");

        list2.add(changer);
      }

    } else {
      for(int b=0; b<list.length;b++) {
        replacer=list[b].add(new Duration(days: 0));
        prechanger=new DateTime(replacer.year, replacer.month, replacer.day);
        changer=prechanger.toString().replaceAll(" 00:00:00.000", "");

        list2.add(changer);
      }
    }


  }

  makeDatelistFertilize() {
    fertilize=widget.plant.fertilizer;

    if(fertilize==0) {
      print("no task");
    } else {

      for(int i=0;i<30;i+=fertilize) {

          t=now.add(new Duration(days: i));
          list4.add(t);

      }
      print(list4);

      for(int b=0; b<list4.length;b++) {
        replacer=list4[b].add(new Duration(days: 0));
        prechanger=new DateTime(replacer.year, replacer.month, replacer.day);
        changer=prechanger.toString().replaceAll(" 00:00:00.000", "");

        list5.add(changer);
      }

    }


  }



////

  Future addtasktodbWater() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("task-v2");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(taskName+"water")
        .set({
      "name": widget.plant.name,
      "unique-name":taskName+"water",
      "datelist": list2,
      "tag": "water",
      "status":1,
      "imagePath": widget.plant.imagePath,
    }).then((value) => addtasktodbFertilizer());
  }

  Future addtasktodbFertilizer() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("task-v2");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(taskName+"fertilizer")
        .set({
      "name": widget.plant.name,
      "unique-name":taskName+"fertilizer",
      "datelist": list5,
      "tag": "fertilizer",
      "status":1,
      "imagePath": widget.plant.imagePath,
    }).then((value) {
      Fluttertoast.showToast(msg: "Successfully added!");
      Navigator.pop(context);
    });
  }



////
  Future addToMyplantList() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-myplant-items-v2");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({


      "name": widget.plant.name,
      "botanical-name": widget.plant.botanical_name,
      "imagePath": widget.plant.imagePath,
      "category": widget.plant.category,
      "care": widget.plant.care,
      "site": site,
      "water_winter": widget.plant.water_winter,
      "water_summer": widget.plant.water_winter,
      "fertilizer": widget.plant.fertilizer,
      "temp_from": widget.plant.temp_from,
      "temp_to": widget.plant.temp_to,
      "auto_taskname": taskName,
      "light": widget.plant.light,
      "toxic": widget.plant.toxic,
      "drain": drain,
      "pot": pot,
      "water_list":list2,

    }).then((value) => addtasktodbWater());
  }
  ////



  ////

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Visibility(
                visible: fstNext?true:false,
            child: Column(
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
                        ListTile(
                          title: Text(widget.plant.name, style: TextStyle(fontWeight: FontWeight.bold,),),
                          subtitle: Text(widget.plant.botanical_name),
                        ),
                        const SizedBox(height: 20.0),

                        Center(
                          child: ElevatedButton(

                            onPressed: () {
                              setState(() {
                                fstNext=false;
                                secNext=true;
                              });
                            },
                            child: const Text('     Add to my list     ', style: TextStyle(fontWeight: FontWeight.bold),),
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
              ),),

              Visibility(
                  visible: secNext?true:false,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                children: [

                  const SizedBox(height: 4,),
                  Text("Select a site:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: tabcolor1),),
                  const SizedBox(height: 14,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.07),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {

                          setState(() {
                            site="living-room";
                            secNext=false;
                            trdNext=true;
                          });
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey.withOpacity(0.1),
                            backgroundImage: CachedNetworkImageProvider("https://hgtvhome.sndimg.com/content/dam/images/hgtv/fullset/2019/8/1/1/uo2019_living-room-01-wide-blinds-up-KB2A8968_h.jpg.rend.hgtvcom.966.644.suffix/1564684055231.jpeg"),
                          ),
                          title: Text("Living Room"),
                          subtitle: Text("Dark, Shade, part sun"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.07),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {

                          setState(() {
                            site="bed-room";
                            secNext=false;
                            trdNext=true;
                          });
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey.withOpacity(0.1),
                            backgroundImage: CachedNetworkImageProvider("https://images.unsplash.com/photo-1560185893-a55cbc8c57e8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGJlZHJvb218ZW58MHx8MHx8&w=1000&q=80"),
                          ),
                          title: Text(" BedRoom"),
                          subtitle: Text("Dark, Shade, part sun"),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.07),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {

                          setState(() {
                            site="kitchen-room";
                            secNext=false;
                            trdNext=true;
                          });
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey.withOpacity(0.1),
                            backgroundImage: CachedNetworkImageProvider("https://assets.architecturaldigest.in/photos/60ab3a15b872edd1c5ce586f/master/pass/7%20things%20to%20consider%20when%20designing%20a%20modular%20kitchen%202.jpeg"),
                          ),
                          title: Text("Kitchen"),
                          subtitle: Text("Dark, Shade, part sun"),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.07),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {

                          setState(() {
                            site="bath-room";
                            secNext=false;
                            trdNext=true;
                          });
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey.withOpacity(0.1),
                            backgroundImage: CachedNetworkImageProvider("https://jumanji.livspace-cdn.com/magazine/wp-content/uploads/sites/2/2021/08/18133115/cover-15-1.png"),
                          ),
                          title: Text("BathRoom"),
                          subtitle: Text("Dark, Shade, part sun"),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.07),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {

                          setState(() {
                            site="belcony-room";
                            secNext=false;
                            trdNext=true;
                          });
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey.withOpacity(0.1),
                            backgroundImage: CachedNetworkImageProvider("https://media.designcafe.com/wp-content/uploads/2020/08/29114351/options-for-seating-in-balcony-interior-design.jpg"),
                          ),
                          title: Text("Balcony"),
                          subtitle: Text("Dark, Shade, part sun"),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.07),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {

                          setState(() {
                            site="terrace-room";
                            secNext=false;
                            trdNext=true;
                          });
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey.withOpacity(0.1),
                            backgroundImage: CachedNetworkImageProvider("https://www.thespruce.com/thmb/-LVPkU0HRx0UuFPKLV_typYRAt0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/wooden-furniture-kept-on-building-terrace-1282124857-fc6facdb301145ddb491071a0e230b7e.jpg"),
                          ),
                          title: Text("Terrace"),
                          subtitle: Text("Dark, Shade, part sun"),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.07),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {

                          setState(() {
                            site="office-room";
                            secNext=false;
                            trdNext=true;
                          });
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey.withOpacity(0.1),
                            backgroundImage: CachedNetworkImageProvider("https://images.unsplash.com/photo-1606857521015-7f9fcf423740?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fG9mZmljZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                          ),
                          title: Text("Office"),
                          subtitle: Text("Dark, Shade, part sun"),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8,),

                ],
              ),
                  )),

              Visibility(
                  visible: trdNext?true:false,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 4,),
                        Text("How is it planted?:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: tabcolor1),),
                        const SizedBox(height: 14,),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.07),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {

                              setState(() {
                                pot="plastic";
                                trdNext=false;
                                frthNext=true;
                              });
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueGrey.withOpacity(0.1),
                                backgroundImage: CachedNetworkImageProvider("https://images.othoba.com/images/thumbs/0430483_modern-flower-tub-1830l-with-tray-sw-tel_300.jpeg"),
                              ),
                              title: Text("Plastic pot"),
                              subtitle: Text("Decrease the warering need"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.07),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {

                              setState(() {
                                pot="terracotta";
                                trdNext=false;
                                frthNext=true;
                              });
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueGrey.withOpacity(0.1),
                                backgroundImage: CachedNetworkImageProvider("https://content.instructables.com/F1V/K3JA/K8ZZPMOG/F1VK3JAK8ZZPMOG.jpg?auto=webp"),
                              ),
                              title: Text("Terracotta pot"),
                              subtitle: Text("Increasing the warering need"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.07),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {

                              setState(() {
                                pot="ceramic";
                                trdNext=false;
                                frthNext=true;
                              });
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueGrey.withOpacity(0.1),
                                backgroundImage: CachedNetworkImageProvider("https://jenniferrizzo.com/wp-content/upload/2021/03/Plastic-textured-pots-to-look-like-ceramic-Jennifer-Rizzo.jpg"),
                              ),
                              title: Text("Ceramic / glass pot"),
                              subtitle: Text("Decrease the warering need"),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),



                      ],
                    ),
                  )),

              Visibility(
                  visible: frthNext?true:false,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [

                         SizedBox(height: MediaQuery.of(context).size.width*0.4,),
                        Text("Does the pot has drainage?", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: tabcolor1),),
                        const SizedBox(height: 8,),

                        Text("We recommend that you only use pots with drainage.", style: TextStyle(fontWeight: FontWeight.bold,),),
                        const SizedBox(height: 12,),

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
                                        drain="yes";
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
                                        child: Text("Yes, it has",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6,),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        insideStatus=false;
                                        drain="no";
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
                                        child: Text("No drainage",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 0,),
                          ],
                        ),
                        SizedBox(height: 40.0),
                        Center(
                          child: ElevatedButton(

                            onPressed: () {
                              setState(() {
                                circularCheck=true;
                              });
                              taskName=widget.plant.name+now.toString();
                              makeDatelistWater();
                              makeDatelistFertilize();
                              print(list2);
                              addToMyplantList();
                            },
                            child: const Text('        Confirm        ', style: TextStyle(fontWeight: FontWeight.bold),),
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
                        Center(
                          child: circularCheck?CircularProgressIndicator():SizedBox(),
                        ),




                      ],
                    ),
                  )),





            ],
          ),
        ),
      ),
    );
  }
}
