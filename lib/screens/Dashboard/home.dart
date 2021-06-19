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

  TabController _tabController;

  final auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;




  getCurrent()async{
    final user = await auth.currentUser();
    if(user != null){
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


  final List<Tab> _tabs = <Tab>[
    Tab(
      text: "Home",
      // icon: Icon(Icons.person),
    ),
    Tab(
      text: "News",
      // icon: Icon(Icons.group),
    ),
    // Tab(
    //   icon: Icon(Icons.business_center),
    // ),
    // Tab(
    //   icon: Icon(Icons.exposure_plus_1),
    // ),
    // Tab(
    //   icon: Icon(Icons.exposure_plus_2),
    // ),
  ];
  void _onTabChanged() {
    /// Only manually set the index if it is changing from a swipe, not a tab selection (indexIsChanging is only true when selecting a tab, and tab index is automatically changed) to avoid setting the index twice when a tab is selected
    if (!_tabController.indexIsChanging)
      setState(() {
        print('Changing to Tab: ${_tabController.index}');
        _currentTabIndex = _tabController.index;
        initialAppBarTitle = appBarTitles[_tabController.index];
      });
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);

    _tabController.addListener(_onTabChanged);

    _currentTabIndex = 0;
    getCurrent();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: (){
          CommonUtils.showAlertDialogLog(context);

          })
        ],
          title: Text(initialAppBarTitle),
          centerTitle: true,
          bottom: TabBar(

            tabs: _tabs,
            controller: _tabController,
            indicatorColor: kSurfaceColor,
          )),
      body: TabBarView(

        controller: _tabController,
        children: <Widget>[
          HomeList(),
          NewsPage(),
          // Container(),
          // Container(),
          // Container(),
        ],
      ),
      floatingActionButton: _currentTabIndex == 1 ? SizedBox() : FloatingActionButton(

        onPressed: (){
          pushTo(context, Add());
        },
        // child: Text("+", style: TextStyle(color: Colors.white),),
        child: Icon(Icons.add),
      ),
    );
  }
}
