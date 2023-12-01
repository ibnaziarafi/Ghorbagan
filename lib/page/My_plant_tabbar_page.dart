import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_13/page/All_blog_page.dart';
import 'package:ui_13/page/add_houseplant_list_page.dart';
import 'package:ui_13/page/houseplant_site_page.dart';
import 'package:ui_13/page/my_site_page.dart';
import 'package:ui_13/page/splash_page.dart';
import 'package:ui_13/widgets/hidden_drawer_nav.dart';
import '../core/color.dart';


class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;



  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String email='';

  Future<void> ukid2() async {
    final SharedPreferences prefs = await _prefs;
    final String counter = (prefs.getString('uniqueid') ?? '');
    setState(() {
      email=counter;

    });
  }

  void logout() async{
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      //builder: (builder) => DetailsPage(plant: plants[index]),
      builder: (builder) => SplashPage(),
    ), ModalRoute.withName('/'));
  }

  Future<void> _showMyDialog2() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(''),
                Text('Press Confirm to log out.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                logout();
              },
            ),

          ],
        );
      },
    );
  }


  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    ukid2();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Plant", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        actions: [

          PopupMenuButton(
            // add icon, by default "3 dot" icon
             icon: Icon(Icons.menu_open, color: Colors.black45,),
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("Light meter"),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("Blog"),
                  ),

                  PopupMenuItem<int>(
                    value: 2,
                    child: Text("Tutorial"),
                  ),

                  PopupMenuItem<int>(
                    value: 3,
                    child: Text("Logout"),
                  ),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => TempPage(),
                    ),
                  );
                  print("My account menu is selected.");
                }else if(value == 1){
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (builder) => Blogs(),
                    ),
                  );
                  print("Blog menu is selected.");
                }else if(value == 2){
                  print("Tutorial menu is selected.");
                }else if(value == 3){
                  _showMyDialog2();
                  print("Logout menu is selected.");
                }
              }
          ),

        ],

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 02),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 8),
              Container(
                 //height: 50,
                width: (MediaQuery.of(context).size.height)*0.28,
                decoration: BoxDecoration(
                    color: tabcolor2,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: TabBar(
                        unselectedLabelColor: Colors.white,
                        labelColor: Colors.white,
                        indicatorColor: Colors.white,
                        indicatorWeight: 0,
                        indicator: BoxDecoration(
                          color: tabcolor1.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        controller: tabController,
                        tabs: [
                          Tab(
                            text: 'Sites',
                          ),
                          Tab(
                            text: 'Plants',
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                   // Sitefirebase(),
                    HouseplantSite(),
                    MySite()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => AddhouseplantsList(),
              // builder: (builder) => AddPlantMenually(),
            ),
          );
        },
        child: const Text('  Add plant  ', style: TextStyle(fontWeight: FontWeight.bold),),
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
    );
  }
}