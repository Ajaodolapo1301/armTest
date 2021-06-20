
import 'dart:async';
import 'dart:io';

import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/model/newsModel.dart';
import 'package:arm_test/screens/reusables/dashBoardwidget.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'add.dart';





class HomeList extends StatefulWidget {
  const HomeList({Key key}) : super(key: key);

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> with  TickerProviderStateMixin {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  User user;


  getCurrent() async {
     user = auth.currentUser;
    print(user);
  }

  AnimationController fadeController;
  @override
  void initState() {
  getCurrent();
    super.initState();
    fadeController =
    AnimationController(vsync: this, duration: Duration(seconds: 2))
      ..forward()
      ..repeat(reverse: true);


    Timer(Duration(milliseconds: 1), () {

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(

              children: [
                Container(
                  decoration: BoxDecoration(
                    color: cyan.withOpacity(0.35),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cyan,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${  user.displayName[0]}${user.displayName[1]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    user.displayName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: blue,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                  user.email,
                      style: TextStyle(
                        color: blue,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      CommonUtils.showAlertDialogLog(context);
                    })
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.maxFinite,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: deepCyan,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 4,
                    child: Image.asset(
                      "assets/images/curve.png",
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: lightDeepCyan),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your Space",
                          style: TextStyle(color: blue, fontSize: 13),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                                "Your Thoughts",
                              style: TextStyle(
                                  color: blue,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 26),
                            ),
                          ],
                        ),



                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: PersonalDashboardView(
                fadeController: fadeController,

              ),
            ),



          ],
        ),
      ),
    );
  }






}




Future<File> getFile({File file}) async {

  File  result = await ImagePicker.pickImage(source: ImageSource.gallery);
  if(result != null) {
    File file = File(result.path);
    int sizeInBytes = file.lengthSync();

      return file;

  }

}





