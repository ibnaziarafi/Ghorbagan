import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_13/data/category_model.dart';
import 'package:ui_13/page/fertilizer_instruction_page.dart';
import 'package:ui_13/page/light_instruction_page.dart';
import 'package:ui_13/page/plant_diagnosis_page.dart';
import 'package:ui_13/page/soil_instruction_page.dart';
import 'package:ui_13/page/water_instruction_page.dart';
import '../core/color.dart';
import '../data/plant_model_firestore.dart';
import '../data/task_model_with_data.dart';
import '../widgets/light_meter.dart';
import 'manage_task_page.dart';

class MyHouseplantsTabbarPage extends StatefulWidget {
  final HousePlantMy plant;

  const MyHouseplantsTabbarPage({Key? key, required this.plant}) : super(key: key);

  @override
  _MyHouseplantsTabbarPageState createState() => _MyHouseplantsTabbarPageState();
}

class _MyHouseplantsTabbarPageState extends State<MyHouseplantsTabbarPage> {
  late Taskpass2 tkpass;
  int selectId = 0;
  String selesctedcat="Overview";
  var today= DateTime.now();
  int number1=0;

  List<String> monthList=["January","February","March","April",
    "May","June","July","August","September","October","November","December"
  ];


  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

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

  int wateringOverview() {
    var list=widget.plant.list;
    print(list);
    var list2 =[];
    int minusNum=0;
    List<int> difNumber=[];
    List<int> temp_difnumber=[];

    int differenceNum=0;
    for(int i=0;i<list.length;i++) {
      list2.add(DateTime.parse(list[i]));
      print(today.toString()+"working");
    }
    print(list2);
    for(int i=0;i<list2.length;i++){

        print(today);
        difNumber.add(daysBetween(today, list2[i]));

    }
    print(difNumber);
    temp_difnumber=difNumber;
    print(temp_difnumber);
    for(int i=0;i<temp_difnumber.length;i++) {
        temp_difnumber.removeWhere((element) =>element.isNegative);

    }
    print(temp_difnumber);
    temp_difnumber.sort();
    differenceNum=temp_difnumber.first;

    return differenceNum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.47,
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
                  image: CachedNetworkImageProvider(widget.plant.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text(widget.plant.name, style: TextStyle(
                color: black.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                overflow: TextOverflow.ellipsis
              ),),
              subtitle: Text(widget.plant.botanical_name,),
            ),
            const SizedBox(height: 0.0),
            SizedBox(
                height: 35.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < overviewCat.length; i++)
                      GestureDetector(
                        onTap: () {
                          setState(() => selectId = overviewCat[i].id);
                          setState(() {
                            selectId = overviewCat[i].id;
                            selesctedcat = overviewCat[i].name;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              overviewCat[i].name,
                              style: TextStyle(
                                color: selectId == i
                                    ? green
                                    : black.withOpacity(0.7),
                                fontSize: 16.0,
                              ),
                            ),
                            if (selectId == i)
                              Container(
                                height: 4,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(60),
                                    bottomRight: Radius.circular(60),
                                    topRight: Radius.circular(60),
                                    topLeft: Radius.circular(60),
                                  ),
                                ),
                              )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            Visibility(
              visible: selectId==1?true:false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

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
                ),),
            Visibility(
              visible: selectId==0?true:false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width*0.07,
                              backgroundColor: Colors.blue.withOpacity(0.2),
                              child: Icon(Icons.water_drop_outlined, color: Colors.blueGrey,),
                            ),
                            const SizedBox(height: 8,),
                            Text("Watering", style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.fade, ),),
                            const SizedBox(height: 2,),
                            Text(wateringOverview()==0?"Today!":"In "+wateringOverview().toString()+"days"),
                            const SizedBox(height: 5,),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width*0.07,
                              backgroundColor: Colors.green.withOpacity(0.2),
                              child: Icon(FontAwesomeIcons.sprayCan, color: tabcolor1,),
                            ),
                            const SizedBox(height: 8,),
                            Text("Fertilizing", style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.fade, ),),
                            const SizedBox(height: 2,),
                            Text(widget.plant.fertilizer==0?"Not needed":"Every "+widget.plant.fertilizer.toString()+"th days"),
                            const SizedBox(height: 5,),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //builder: (builder) => DetailsPage(plant: plants[index]),
                            builder: (builder) => PlantDiagnosis(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(0.07),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric( vertical: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width*0.07,
                                backgroundColor: Colors.grey.withOpacity(0.3),
                                backgroundImage: CachedNetworkImageProvider("https://thumbs.dreamstime.com/b/drug-natural-plant-extraction-doctor-scientist-researching-herbal-medicine-drug-natural-plant-extraction-doctor-148805975.jpg"),

                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.28,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text("Ask Experts", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.black.withOpacity(0.7)),),
                                    const SizedBox(height: 3,),
                                    Text("Get the perfect solution for all of your gardening problems",
                                    style: TextStyle(color: Colors.black54),)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 1,),
                              Icon(Icons.arrow_forward_ios_rounded),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text("Care plan based on", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width*0.3,
                              width: MediaQuery.of(context).size.width*0.35,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.07),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(Icons.calendar_today),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(monthList[(today.month)-1],
                                        style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                                      Text("Month",
                                        style: TextStyle(color: Colors.black54),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              height: MediaQuery.of(context).size.width*0.3,
                              width: MediaQuery.of(context).size.width*0.35,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.07),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                  topLeft: Radius.circular(0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(FontAwesomeIcons.globe),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("North.",
                                        style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                                      Text("Hemisph.",
                                        style: TextStyle(color: Colors.black54),),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width*0.3,
                              width: MediaQuery.of(context).size.width*0.35,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.07),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(Icons.location_on_rounded),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Dhaka",
                                        style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                                      Text("Location",
                                        style: TextStyle(color: Colors.black54),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              height: MediaQuery.of(context).size.width*0.3,
                              width: MediaQuery.of(context).size.width*0.35,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.07),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(0),
                                  topLeft: Radius.circular(0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(Icons.wb_sunny_outlined),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("part sun",
                                        style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                                      Text("Light",
                                        style: TextStyle(color: Colors.black54),),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),),

          ]),
        ),
      ),
      floatingActionButton: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 5),
              child: ElevatedButton(

                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      //builder: (builder) => DetailsPage(plant: plants[index]),
                      builder: (builder) => TempPage2(light: widget.plant.light),
                    ),
                  );
                },
                child: const Icon(Icons.light),
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
            ElevatedButton(

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder: (builder) => DetailsPage(plant: plants[index]),
                    builder: (builder) => ManageTask(tkpass: tkpass=Taskpass2(name: widget.plant.name,
                      unique_name: widget.plant.auto_taskname,
                      imagePath: widget.plant.imagePath,
                      list: widget.plant.list,
                      summer: widget.plant.water_summer,
                      uid: widget.plant.uid,
                    )),
                  ),
                );
              },
              child: const Text('      Manage task      ', style: TextStyle(fontWeight: FontWeight.bold),),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(tabcolor1.withOpacity(0.6)),
                overlayColor: MaterialStateProperty.all(tabcolor2.withOpacity(0.7)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
