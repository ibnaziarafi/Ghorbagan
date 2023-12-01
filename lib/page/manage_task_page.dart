import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/color.dart';
import '../data/task_model_with_data.dart';


class ManageTask extends StatefulWidget {
  final Taskpass2 tkpass;
  const ManageTask({Key? key, required this.tkpass}) : super(key: key);

  @override
  _ManageTaskState createState() => _ManageTaskState();
}

class _ManageTaskState extends State<ManageTask> {
  final GlobalKey<ExpansionTileCardState> cardA=new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB=new GlobalKey();

  bool insideStatus=true;
  int status=1;
  late List<dynamic> previousList;
  late List<dynamic> newList=[];
  late var t;
  late var prechanger;
  late var changer;
  late var replacer;
  late var summer;

  var today= DateTime.now();
  String taskname="";
  late var drain="yes";

  List<String> items = [
    "One Day",
    "Two Day",
    "Three Day",
    "One Week",
    "Two Week",
  ];
  List<int> interval=[1,2,3,7,14];
  List<int> items2=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
  List<String> tagitems=[
    "water",
    "mist",
    "fertilizer"
  ];
  dynamic selecteditem="One Day";
  dynamic selecttag="water";
  dynamic selectiteminterval=1;
  dynamic selectedIndex1 = 1;





  late var now = new DateTime.now();
  late var now2 = new DateTime.now();
  late var date = new DateTime(now.year, now.month, now.day);
  late String datewithoutmin = date.toString().replaceAll("00:00:00.000", "");
  List maindatelist=[];
  dynamic maindatelist2=[];
  List<String> convertedList=[];

  makeDatelist(var date,int num,num2)  {
    late var t;
    List mm=[];
    int num3=num2;
    List<String> nn=[];
    late var prechanger;
    late String changer;


    for(int i=0;i<num;i+=num3) {
      t = date.add(new Duration(days: i));
      mm.add(t);
    }

    for(int b=0; b<mm.length;b++) {
      prechanger=new DateTime(mm[b].year, mm[b].month, mm[b].day);
      changer=prechanger.toString().replaceAll(" 00:00:00.000", "");

      nn.add(changer);
    }

    setState(() {
      maindatelist2=mm;
      convertedList=nn;
    });

  }




  Future addtasktodb() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("task-v2");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(taskname)
        .set({
      "name": widget.tkpass.name,
      "unique-name":taskname,
      "datelist": convertedList,
      "tag": selecttag,
      "status":1,
      "imagePath": widget.tkpass.imagePath,
    }).then((value) => Fluttertoast.showToast(msg: "Successfully added!"));
  }

  Future updateStatus() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("task-v2");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget.tkpass.unique_name+"water")
        .update({

      "status":status,

    }).then((value) => updateStatusfer());
  }
  Future updateStatusfer() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("task-v2");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget.tkpass.unique_name+"fertilizer")
        .update({

      "status":status,

    }).then((value) => Fluttertoast.showToast(msg: "Successfully added!"));
  }

  increaseWaterDateListWithDrain() {


      int increament=((summer*25)/100).round();
      print(increament);

      if(summer<=10) {
        for(int i=0;i<previousList.length;i++) {
          t=DateTime.parse(previousList[i]);
          print(t);
          replacer=t.add(new Duration(days: (increament*(i+1))));
          print(replacer);
          prechanger=new DateTime(replacer.year, replacer.month, replacer.day);
          changer=prechanger.toString().replaceAll(" 00:00:00.000", "");
          print(changer);
          newList.add(changer);
        }
      } else {
        for(int i=0;i<previousList.length;i++) {
          t=DateTime.parse(previousList[i]);
          print(t);
          replacer=t.add(new Duration(days: 0));
          print(replacer);
          prechanger=new DateTime(replacer.year, replacer.month, replacer.day);
          changer=prechanger.toString().replaceAll(" 00:00:00.000", "");
          print(changer);
          newList.add(changer);
        }
      }


  }
  decreaseWaterDateListWithDrain() {



    int decreament=((summer*25)/100).round();
    print(decreament);

    if(summer<=10) {
      for(int i=0;i<previousList.length;i++) {
        t=DateTime.parse(previousList[i]);
        print(t);
        replacer=t.subtract(new Duration(days: (decreament*(i+1))));
        print(replacer);
        prechanger=new DateTime(replacer.year, replacer.month, replacer.day);
        changer=prechanger.toString().replaceAll(" 00:00:00.000", "");
        print(changer);
        newList.add(changer);
      }
    } else {
      for(int i=0;i<previousList.length;i++) {
        t=DateTime.parse(previousList[i]);
        print(t);
        replacer=t.add(new Duration(days: 0));
        print(replacer);
        prechanger=new DateTime(replacer.year, replacer.month, replacer.day);
        changer=prechanger.toString().replaceAll(" 00:00:00.000", "");
        print(changer);
        newList.add(changer);

      }
      print(newList);
    }

  }
  Future updateList() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("task-v2");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget.tkpass.unique_name+"water")
        .update({

      "datelist":newList,


    }).then((value) => updateDrain());
  }
  Future updateDrain() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-myplant-items-v2");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget.tkpass.uid)
        .update({

      "drain":drain,
      "water_list":newList,

    }).then((value) {
      Fluttertoast.showToast(msg: "Successfully added!");

    });
  }

  ////

  ////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        title: Text("Manage Task", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),

      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(padding: const EdgeInsets.only(right: 10,left: 10),
                child: Column(
                  children: [
                    //SizedBox(height: 150,),
                    Column(
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Automatic task schedule:",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: tabcolor1),),
                        const SizedBox(height: 8,),
                        SizedBox(height: 5,),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("task-v2")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection("items")
                              .where("unique-name", isEqualTo: widget.tkpass.unique_name+"water")
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Something is wrong"),
                              );
                            }
                            if(snapshot.hasData) {

                              status=snapshot.data!.docs[0]["status"];
                              status==1?insideStatus=true:insideStatus=false;




                            }





                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: ()  {

                                      insideStatus=true;
                                      status=1;
                                      updateStatus();




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
                                        child: Text("On",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6,),
                                  GestureDetector(
                                    onTap: ()  {

                                      insideStatus=false;
                                      status=0;
                                      updateStatus();




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
                                        child: Text("Off",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 5,),

                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users-myplant-items-v2")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection("items")
                              .where("auto_taskname", isEqualTo: widget.tkpass.unique_name)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Something is wrong"),
                              );
                            }
                            if(snapshot.hasData) {

                              drain=snapshot.data!.docs[0]["drain"];
                              previousList=snapshot.data!.docs[0]["water_list"];
                              print("---");
                              print(DateTime.parse(previousList[0]).add(new Duration(days: 1)));
                              print(drain);
                              summer=snapshot.data!.docs[0]["water_summer"];
                              print(widget.tkpass.summer);
                              print("---");


                            }





                            return ExpansionTileCard(
                              key: cardB,
                              title: Text("Does it has drainage?", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black54),),
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if(drain=="yes") {
                                      print("no change"+drain);
                                      print(newList);
                                      print(drain);
                                    } else{
                                      //decrease
                                      drain="yes";
                                      decreaseWaterDateListWithDrain();
                                      updateList().then((value) {
                                        print(newList);
                                        print(drain);
                                        Navigator.of(context).pop();
                                      });


                                    }
                                    cardB.currentState?.collapse();
                                  },
                                  child: Container(
                                    child: ListTile(
                                      title: Text("Yes, it has drainage"),

                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if(drain=="no") {
                                      print("no change"+drain);
                                      print(newList);
                                      print(drain);
                                    } else{
                                      print("no change---"+drain);
                                      //increase
                                      drain="no";
                                      print("no change---"+drain);
                                      increaseWaterDateListWithDrain();
                                      updateList().then((value) {
                                        print(newList);
                                        print(drain);

                                        Navigator.of(context).pop();
                                      });
                                    }
                                    cardB.currentState?.collapse();

                                  },
                                  child: Container(
                                    child: ListTile(
                                      title: Text("No drainage"),

                                    ),
                                  ),
                                ),

                              ],
                            );
                          },
                        ),

                      ],
                    ),
                    const SizedBox(height: 5,),
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
                          child: Text("Recommended: Turn 'Automatic task' off before creating task menually.", style: TextStyle(),),
                        ),

                      ),
                    ),

                    Divider(thickness: 1.5,),
                    const SizedBox(height: 5,),
                    Text("Create Task:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: tabcolor1),),

                    const SizedBox(height: 14,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("From (Select Date):", style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87
                        ),),
                        SizedBox(height: 5,),
                        Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width*0.7,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: Colors.grey),
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
                            children: [
                              SizedBox(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width*0.56,
                                  child: TextButton(onPressed: () async{
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: date,
                                      firstDate: now2,
                                      lastDate: DateTime(2030),
                                    );
                                    if(newDate==null) return;
                                    setState(() {
                                      now=newDate;

                                      date = new DateTime(now.year, now.month, now.day);


                                      datewithoutmin = date.toString().replaceAll("00:00:00.000", "");
                                    });


                                    print(datewithoutmin);
                                    print(date);
                                  }, child: Text(date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString()))
                              ),

                              GestureDetector(
                                  onTap: () async{
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: date,
                                      firstDate: now2,
                                      lastDate: DateTime(2030),
                                    );
                                    if(newDate==null) return;
                                    setState(() {
                                      now=newDate;

                                      date = new DateTime(now.year, now.month, now.day);


                                      datewithoutmin = date.toString().replaceAll("00:00:00.000", "");
                                    });


                                    print(datewithoutmin);
                                    print(date);

                                  },
                                  child: Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Type:", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87
                            ),),
                            SizedBox(height: 5,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),

                              ),

                              child: Center(
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  items: tagitems.map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e,),
                                  ) ).toList(),
                                  value: selecttag,
                                  onChanged: (e) => setState(()=>selecttag=e),
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Interval:", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87
                            ),),
                            SizedBox(height: 5,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),

                              ),

                              child: Center(
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  items: items.map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e,),
                                  ) ).toList(),
                                  value: selecteditem,
                                  onChanged: (e) {
                                    setState(() {
                                      selecteditem=e;
                                      if(selecteditem=="One Day") {
                                        selectiteminterval=1;
                                      } else if(selecteditem=="Two Day") {
                                        selectiteminterval=2;
                                      } else if(selecteditem=="Three Day") {
                                        selectiteminterval=3;
                                      } else if(selecteditem=="One Week") {
                                        selectiteminterval=7;
                                      } else if(selecteditem=="Two Week") {
                                        selectiteminterval=14;
                                      }
                                    });
                                  }

                                  ,
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Repeat:", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87
                            ),),
                            SizedBox(height: 5,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.23,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),

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
                            SizedBox(height: 30,),
                          ],
                        ),


                      ],
                    ),

                    ElevatedButton(

                      onPressed: () {
                        //Navigator.of(context).pop();
                        taskname=widget.tkpass.name+today.toString()+selecttag;
                        int num =selectedIndex1*selectiteminterval;

                        makeDatelist(date, num, selectiteminterval);
                        print(convertedList);
                        print(selectiteminterval.toString());
                        addtasktodb();
                        Navigator.pop(context);
                      },
                      child: const Text('    Add task    ', style: TextStyle(fontWeight: FontWeight.bold),),
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
                ),)
          )
      ),
    );
  }
}

