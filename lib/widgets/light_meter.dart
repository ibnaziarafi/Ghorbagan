import 'package:flutter/material.dart';
import 'dart:async';
import 'package:environment_sensors/environment_sensors.dart';
import 'dart:convert';

import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:ui_13/core/color.dart';

import '../page/light_instruction_page.dart';

class TempPage2 extends StatefulWidget {
  final String light;
  const TempPage2({Key? key, required this.light}) : super(key: key);
  @override
  _TempPage2State createState() => _TempPage2State();
}

class _TempPage2State extends State<TempPage2> {

  bool _lightAvailable = false;

  final environmentSensors = EnvironmentSensors();
  late String luxvalue;
  late String projectedLight;
  String currentState='';
  late String result;
  bool dark=false,shade=false,part =false,sun=false;
  int current=0;
  late var b,c;
  List<String> stateList=['dark','shade','part','full sun'];
  int indexofState=0;
  int indexofState2=0;

  @override
  void initState() {
    super.initState();
    environmentSensors.pressure.listen((pressure) {
      print(pressure.toString());
    });

    if(widget.light.contains("part")){
      projectedLight='part';
    } else{
      projectedLight=widget.light;
    }
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool lightAvailable;

    lightAvailable =
    await environmentSensors.getSensorAvailable(SensorType.Light);


    setState(() {
      _lightAvailable = lightAvailable;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                (_lightAvailable)
                    ? StreamBuilder<double>(
                    stream: environmentSensors.light,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      if(snapshot.hasData) {
                        luxvalue =snapshot.data!.toStringAsFixed(0);
                        b = int. parse(luxvalue);
                        if(b<=100) {
                          current = 1;
                          dark=true;
                          shade=false;
                          part=false;
                          sun=false;
                          currentState='dark';

                        } else if(b>100 && b<=600) {
                          dark=false;
                          shade=true;
                          part=false;
                          sun=false;
                          current = 2;
                          currentState='shade';
                        } else if(b>600 && b<=5000) {
                          dark=false;
                          shade=false;
                          part=true;
                          sun=false;
                          current=3;
                          currentState='part';
                        } else{
                          dark=false;
                          shade=false;
                          part=false;
                          sun=true;
                          current=4;
                          currentState='full sun';
                        }
                        indexofState=stateList.indexOf(projectedLight);
                        print(projectedLight);
                        indexofState2=stateList.indexOf(currentState);
                        print(indexofState);
                        print(indexofState2);


                        if(indexofState==indexofState2){
                          result='Suitable';
                        } else if (indexofState2<indexofState){
                          result='Low';
                        } else{
                          result='';
                        }

                      }
                      return Column(


                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*0.18,),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Container(
                              decoration: BoxDecoration(

                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("For the most accurate result: point the device's light sensor towards the light. The sensor is most often located on the front of the device", style: TextStyle(),),
                              ),

                            ),
                          ),
                          SizedBox(height: 6,),

                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width/6.88,
                            backgroundColor: dark==true?Colors.orange.withOpacity(0.2):(shade==true?Colors.green.withOpacity(0.4):(part==true?Colors.blueAccent.withOpacity(0.6):Colors.deepPurple.withOpacity(0.9))),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width/7,
                              backgroundColor: Colors.white,
                              child: Text(luxvalue.toString(), style: TextStyle(fontSize: MediaQuery.of(context).size.width/18),),
                            ),
                          ),
                          Container(
                              transform: Matrix4.translationValues(0.0, -MediaQuery.of(context).size.width/3.45, 0.0),
                              child: Icon(Icons.light,color: dark==true?Colors.orange.withOpacity(0.2):(shade==true?Colors.green.withOpacity(0.4):(part==true?Colors.blueAccent.withOpacity(0.6):Colors.deepPurple.withOpacity(0.9))),)),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 16),
                            child: Container(

                              child: StepProgressIndicator(
                                totalSteps: 4,
                                currentStep: current,
                                size: 20,
                                selectedColor: Colors.green,
                                unselectedColor: Colors.grey.withOpacity(0.2),
                                roundedEdges: Radius.circular(10),
                                selectedGradientColor: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.orange.withOpacity(0.2), Colors.deepOrangeAccent.withOpacity(0.6)],
                                ),

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Dark", style: TextStyle(color:dark==false?Colors.black26:Colors.orange.withOpacity(0.8), ),),
                                Text("shade", style: TextStyle(color:shade==false?Colors.black26:Colors.orange.withOpacity(0.8), ),),
                                Text("part", style: TextStyle(color:part==false?Colors.black26:Colors.orange.withOpacity(0.8), ),),
                                Text("sun", style: TextStyle(color:sun==false?Colors.black26:Colors.orange.withOpacity(0.8), ),),
                              ],
                            ),
                          ),

                          SizedBox(height: 25,),
                          Text(result,style: TextStyle(color: result=="Suitable"?Colors.green.withOpacity(0.7):Colors.red.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(height: 12,),
                          Text("Projected light:",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold,fontSize: 17),),
                          Text(widget.light,style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold,fontSize: 17),),

                          const SizedBox(height: 10,),
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 16),
                              child:  Container(
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
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text('Tap to know about light', style: TextStyle(color: tabcolor1,decoration: TextDecoration.underline,),),
                                ),
                              ),
                            ),
                          ),

                        ],
                      );
                    })
                    : Text('No light sensor found on your device'),
              ],
            ),
          ),
        ));
  }

}


