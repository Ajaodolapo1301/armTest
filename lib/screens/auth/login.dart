import 'dart:convert';

import 'package:arm_test/Services/auth.dart';
import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/screens/Dashboard/add.dart';
import 'package:arm_test/screens/Dashboard/home.dart';
import 'package:arm_test/screens/auth/signup.dart';
import 'package:arm_test/screens/reusables/customTextField.dart';
import 'package:arm_test/screens/reusables/custom_button.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:arm_test/sizeConfig/sizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:hive/hive.dart';
import 'package:progress_dialog/progress_dialog.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var email;

  var password;
  bool isVisiblePassword = false;
  // User user;
  ProgressDialog pd;
  void showLoadingDialog(context) async {
    pd = await CommonUtils.showProgressDialog(
        context, "Processing...Please wait!");
  }

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: blue,
      // kPrimaryColor,

      body: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.all(4.5 * SizeConfig.heightMultiplier),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 9.8 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    "Welcome!",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 40),
                  ),
                  SizedBox(
                    height: 7.3 * SizeConfig.heightMultiplier,
                  ),
                  CustomTextField(
                    type: FieldType.email,
                    textActionType: ActionType.next,
                    label: "Email Address",
                    onSubmit: (v) {},
                    validator: (v) {
                      if (v.isEmpty) {
                        return "Field is required";
                      }
                      email = v;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 3.6 * SizeConfig.heightMultiplier,
                  ),
                  CustomTextField(
                    type: FieldType.text,
                    obscureText: !isVisiblePassword,
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisiblePassword = !isVisiblePassword;
                        });
                      },
                      child: Text(
                        isVisiblePassword ? "HIDE" : "SHOW",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                    textActionType: ActionType.next,
                    label: "Password (Min. 8 characters)",
                    onSubmit: (v) {},
                    validator: (v) {
                      if (v.isEmpty) {
                        return "Field is required";
                      }
                      password = v;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 3.0 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 1.3 * SizeConfig.textMultiplier),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.4 * SizeConfig.heightMultiplier,
                  ),
              CustomButton(
                textColor: Colors.black,
                text: "Log In".toUpperCase(),
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    login( email, password);
                  }

                },
              ),
                  // FutureBuilder(
                  //   // future: Firebase.initializeApp(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasError) {
                  //       return Text('Error initializing Firebase');
                  //     } else if (snapshot.connectionState ==
                  //       ConnectionState.done) {
                  //       return CustomButton(
                  //         textColor: Colors.black,
                  //         text: "Log In".toUpperCase(),
                  //         onPressed: () async {
                  //           // if (formKey.currentState.validate()) {
                  //           //   login( email, password);
                  //           // }
                  //
                  //           pushTo(context, Home());
                  //         },
                  //       );
                  //     }
                  //     return CircularProgressIndicator(
                  //       valueColor: AlwaysStoppedAnimation<Color>(
                  //         kPrimaryColor,
                  //       ),
                  //     );
                  //   },
                  // ),

                  SizedBox(
                    height: 3.9 * SizeConfig.heightMultiplier,
                  ),
                  Center(
                      child: GestureDetector(
                          onTap: () {
                            pushTo(context, Register());
                          },
                          child: Text(
                            "New User? Create a new account",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 1.3 * SizeConfig.textMultiplier),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  void login(email, password)async{
    showLoadingDialog(context);
    var user = await FireAuth.signInUsingEmailPassword(email: email, password: password,);

    pd.hide();
      if(user !=  null){
         pushToAndClearStack(context, Home());
      }else{
        pd.hide();
        CommonUtils.kShowSnackBar(color: Colors.red, msg: "An Error occued", ctx: context);
      }
  }

}
