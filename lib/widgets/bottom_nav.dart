import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_13/page/My_plant_tabbar_page.dart';
import 'package:ui_13/page/dashboard2_page.dart';
import 'package:ui_13/page/datepickerpage.dart';
import 'package:ui_13/page/home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PageController pageController = PageController();
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: child.length,
        controller: pageController,
        onPageChanged: (value) => setState(() => selectIndex = value),
        itemBuilder: (itemBuilder, index) {
          return Container(
            child: child[index],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        elevation: 0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,

        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        onTap: (index)=>setState(() {
          pageController.jumpToPage(index);
          selectIndex=index;
        }),

        items: const [

          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded),  label: 'Home', ),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.plantWilt), label: "My plants", ),
          BottomNavigationBarItem(icon: Icon(Icons.search),  label: 'Find Plants',),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: "Dashboard", ),
        ],
      ),
    );
  }
}

List<Widget> child = [

  Datepickertimeline(),
  //const HomePage(),
  const TabBarPage(),
  HomePage(),
  Dashboard2(),
  //QuestionList(),
  //AddBlog(),






  /*Container(color: white),
  Container(color: white),
  Container(color: white),*/
];

/*bottomNavigationBar: BottomAppBar(
elevation: 0,
child: SizedBox(
height: 60.0,
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
for (int i = 0; bottomMenu.length > i; i++)
GestureDetector(
onTap: () {
setState(() {
pageController.jumpToPage(i);
selectIndex = i;
});
},
child: Image.asset(
bottomMenu[i].imagePath,
color: selectIndex == i ? green : grey.withOpacity(0.5),
),
)
],
),
),
),*/
