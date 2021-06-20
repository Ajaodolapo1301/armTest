import 'package:after_layout/after_layout.dart';
import 'package:arm_test/Services/auth.dart';
import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/screens/Dashboard/homeList.dart';
import 'package:arm_test/screens/Dashboard/newsPage.dart';
import 'package:arm_test/screens/auth/login.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin, AfterLayoutMixin<Home> {


  final auth = FirebaseAuth.instance;
  // FirebaseUser loggedInUser;
  User user;
  PageController pageController = PageController();

  getCurrent() async {


  User user = auth.currentUser;
    print("hgy$user");
  }

  int _currentTabIndex = 0;
  String initialAppBarTitle = 'Personal Messages';
  List<String> appBarTitles = [
    'Personal Messages',
    'News',
  ];




  @override
  void initState() {
    super.initState();
    _currentTabIndex = 0;
    getCurrent();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: blue,
          unselectedItemColor: blue.withOpacity(0.35),
          onTap: (v) {
            setState(() {
              currentIndex = v;
              pageController.animateToPage(
                currentIndex,
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              );
            });
          },
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Post",
            ),
            BottomNavigationBarItem(
              icon: Transform.translate(
                offset: Offset(4, -2.5),
                child: Transform.rotate(
                  angle: 5.5,
                  child: Icon(Icons.send_rounded),
                ),
              ),
              label: "News",
            ),
          ],
        ),

        body: SafeArea(
          child: PageView(
            controller: pageController,
            children: <Widget>[
              HomeList(),
              NewsPage(),

            ],
          ),
        ),
 );
  }

  @override
  void afterFirstLayout(BuildContext context) async{
    SharedPreferences  pref = await SharedPreferences.getInstance();

  }
}
