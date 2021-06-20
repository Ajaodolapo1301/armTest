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

import 'add.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {


  final auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  PageController pageController = PageController();

  getCurrent() async {
    final user = await auth.currentUser();
    if (user != null) {
      loggedInUser = user;
    }
    print(loggedInUser.email);
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
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Transform.translate(
                offset: Offset(4, -2.5),
                child: Transform.rotate(
                  angle: 5.5,
                  child: Icon(Icons.send_rounded),
                ),
              ),
              label: "Send",
            ),
          ],
        ),

        body: SafeArea(
          child: PageView(
            controller: pageController,
            children: <Widget>[
              HomeList(),
              NewsPage(),
              // Container(),
              // Container(),
              // Container(),
            ],
          ),
        ),
        floatingActionButton: currentIndex == 1
            ? SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  pushTo(context, Add());
                },
                // child: Text("+", style: TextStyle(color: Colors.white),),
                child: Icon(Icons.add),
              ));
  }
}
