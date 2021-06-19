
import 'package:arm_test/Services/auth.dart';
import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/screens/reusables/customTextField.dart';
import 'package:arm_test/screens/reusables/custom_button.dart';
import 'package:arm_test/screens/reusables/whiteBox.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/header.dart';
import 'package:arm_test/sizeConfig/sizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:hive/hive.dart';
import 'package:progress_dialog/progress_dialog.dart';








class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
var email;
var  firstname;
var password;
var surname;
var phonenumber;
var refcode;
  Box box;
  // User user;
  ProgressDialog pd;
  void showLoadingDialog(context) async {
    pd = await CommonUtils.showProgressDialog(
        context, "Processing...Please wait!");
  }
  final formKey = GlobalKey<FormState>();

  bool isVisiblePassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kPrimaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Header(
                  text: "",
                ),
                SizedBox(height: 3.8 * SizeConfig.heightMultiplier,),

                WhiteCard(
                  child:  Padding(
                    padding: const EdgeInsets.all(27),
                    child: Container(
                      child: Form(
                    key: formKey,
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Create a new account", style: TextStyle(fontSize: 1.9 * SizeConfig.textMultiplier, color: Colors.black, fontWeight: FontWeight.bold),),
                            SizedBox(height: 3.6* SizeConfig.heightMultiplier,),
                            CustomTextField(

                              type: FieldType.text,
                              cursorColor: Colors.black,
                              textActionType: ActionType.next,
                              label: "Surname",
                              onSubmit: (v){

                              },
                              validator: (v) {
                                if (v.isEmpty) {
                                  return "Field is required";
                                }
                                surname = v;
                                return null;
                              },

                            ),
                            SizedBox(height: 3.6* SizeConfig.heightMultiplier,),
                            CustomTextField(

                              type: FieldType.text,
                              cursorColor: Colors.black,
                              textActionType: ActionType.next,
                              label: "First name",
                              onSubmit: (v){

                              },
                              validator: (v) {
                                if (v.isEmpty) {
                                  return "Field is required";
                                }
                                firstname = v;
                                return null;
                              },

                            ),
                            SizedBox(height: 3.6* SizeConfig.heightMultiplier,),
                            CustomTextField(
                              cursorColor: Colors.black,

                              textActionType: ActionType.next,
                              label: "Email Address",
                              type: FieldType.email,
                              onSubmit: (v){

                              },
                              validator: (v) {
                                if (v.isEmpty) {
                                  return "Field is required";
                                }
                                email = v;
                                return null;
                              },
                              // prefixIcon: Icons.phone
                            ),
                            SizedBox(height: 3.6* SizeConfig.heightMultiplier,),
                            CustomTextField(
                              obscureText: !isVisiblePassword ,
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisiblePassword = !isVisiblePassword;
                                  });
                                },
                                child: Text(
                                  isVisiblePassword ? "HIDE" : "SHOW",
                                  style: TextStyle(fontSize: 10, color: kPrimaryColor),
                                ),
                              ),
                              type: FieldType.text,
                              cursorColor: Colors.black,

                              textActionType: ActionType.next,
                              label: "Password (Min. 8 characters)",
                              onSubmit: (v){

                              },
                              validator: (v) {
                                if (v.isEmpty) {
                                  return "Field is required";
                                }
                              password = v;
                                return null;
                              },

                            ),
                            SizedBox(height: 3.6* SizeConfig.heightMultiplier,),


                            SizedBox(height: 3.6* SizeConfig.heightMultiplier,),
                            Center(child: Text("By signing, you agree to Ar terms and privacy policy.", style: TextStyle(fontSize: 1.2 * SizeConfig.textMultiplier, color: Colors.black, fontWeight: FontWeight.w300),)),
                            SizedBox(height: 3.6* SizeConfig.heightMultiplier,),
                            CustomButton(
                        type: ButtonType.gradient,
                              textColor: Colors.white,
                              text: "SIGN UP".toUpperCase(),
                              onPressed: () async{
                                if (formKey.currentState.validate()) {
                                    // register(surname, firstname, email, password);

                                      }


                                }
                            ),
                            SizedBox(height: 2.4 * SizeConfig.heightMultiplier,),
                          ],
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ) ,
    );
  }


  void register(firstname, lastname, email, password)async{
    var user = await FireAuth
        .registerUsingEmailPassword(
      firstname: firstname,
      lastname: lastname,
      email: email,
      password: password,
    );
    print(user);
  }
}




