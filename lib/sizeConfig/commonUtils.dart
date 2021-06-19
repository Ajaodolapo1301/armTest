



import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:progress_dialog/progress_dialog.dart';

Color barrierColor = Color(0xff364A7D).withOpacity(0.85);
class CommonUtils{
  final auth = FirebaseAuth.instance;
  static formatDate(String date) {
    if (date == null) {
      return date ?? "";
    }

    var fmtDate = DateFormat.yMMMd().format(DateTime.parse(date));
//    String fmtDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
    String fmtTime =DateFormat('kk:mm:a').format(DateTime.parse(date));
    return "${fmtDate.toString()} - ${fmtTime.toString()}";
  }

  static formatTime(String date) {
    if (date == null) {
      return date ?? "";
    }

    String fmtTime =DateFormat('kk:mm:a').format(DateTime.parse(date));
    return fmtTime.toString();
  }



  static   showAlertDialogLog(BuildContext context,) async{
    // final SharedPreferences preferences = await SharedPreferences.getInstance();
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(color: kPrimaryColor),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes", style: TextStyle(color: kPrimaryColor),),
      onPressed:  () {
      auth.signOut();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Login()),
                (Route<dynamic> route) => false);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertDialog({BuildContext context, String text, VoidCallback onClose}) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("OK", style:TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: kPrimaryColor
      ),),
      onPressed: onClose,
    );

//  // set up the AlertDialog
//  AlertDialog alert = AlertDialog(
////    title: Text("Logout"),
//    content: Text("Password change successfully"),
//    actions: [
////      cancelButton,
//      continueButton,
//    ],
//  );

    // show the dialog
    showDialog(

        barrierDismissible: false,
        barrierColor: barrierColor,
        context: context,
        builder: (_) => new AlertDialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(5.0))),
          content: Builder(
            builder: (context) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;

              return Container(
                  height: 20,
                  width: width ,
                  child: Text(text,         textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor
                    ),)
              );
            },
          ),
          actions: [
            continueButton
          ],
        )
    );
  }

static   modalBottomSheetMenu({BuildContext context, Widget body, }){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
        ),
        context: context,
        builder: (builder){
          return new Container(
            height: 300.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color:  Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0))),
                child: body
            ),
          );
        }
    );
  }

 static Widget checkMArk() {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 800),
      curve: Curves.elasticInOut,
      tween: Tween<double>(begin: 5, end: 25),
      builder: (__, value, child) {
        return Container(
            child: Icon(Icons.done,

                color: Color(0xff009845)
            )
        );
      },
    );
  }


 static  Widget checkCancel() {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 800),
      curve: Curves.elasticInOut,
      tween: Tween<double>(begin: 5, end: 25),
      builder: (__, value, child) {
        return Container(
            child: Icon(Icons.cancel,

                color: Colors.red
            )
        );
      },
    );
  }
//
//   static  showSuccessDialog({text, context,  VoidCallback onClose, String buttonText }) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return SimpleDialog(
//           contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           children: <Widget>[
//             Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SvgPicture.asset(
//                     "images/yes.svg",
//                     height: 100,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Success!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w600,
//                       color:Colors.white ,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     text,
//                     textAlign: TextAlign.center,
//                     style:
//                     GoogleFonts.karla(color: themeChangeProvider.darkTheme? Colors.white : smallTextColor, fontSize: 15),
//                   ),
//                   SizedBox(height: 20),
//
//                   SizedBox(
//                     width: double.maxFinite,
//                     height: 50,
//                     child: RaisedButton(
//                       onPressed: onClose,
//                       child: Text(
//                         buttonText  ?? "Okay",
//                         style: GoogleFonts.karla(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                       color: kPrimaryColor,
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       textColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(7),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
//
//
// static showFlushBar({BuildContext context, String title , String message , Color backgroundColor}) async {
//   Flushbar(
//     title: title,
//     message: message,
//     isDismissible: true,
//     flushbarPosition: FlushbarPosition.TOP,
//     backgroundColor: backgroundColor,
//     duration: Duration(seconds: 2),
//     flushbarStyle: FlushbarStyle.FLOATING,
//     margin: EdgeInsets.all(5),
//     borderRadius: 12,
//   )..show(context);
// }


  static Future<ProgressDialog> showProgressDialog(
      BuildContext context, String title) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        progressWidget: Container(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: SpinKitRing(
                size: 50,
                lineWidth: 4,
                color:kPrimaryColor,
//                itemBuilder: (_, __) {
//                  return SizedBox(
//                    height: 3,
//                    width: 3,
//                    child: DecoratedBox(
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                        color: Colors.amber[700],
//                      ),
//                    ),
//                  );
//                },
              ),
            )),
        message: title,
        messageTextStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 15,
            fontWeight: FontWeight.w400));
    await pr.show();
    return pr;
  }

  static kShowSnackBar({BuildContext ctx, String msg, Color color}) {
    return Flushbar(
      flushbarPosition:  FlushbarPosition.BOTTOM,
      backgroundColor: color ?? kPrimaryColor,
      messageText: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      duration: Duration(seconds: 3),
    )..show(ctx);
  }

  static   showMsg(body,  context, scaffoldKey, Color snackColor ) {
    final snackBar = SnackBar(
      backgroundColor: snackColor,
      content: Text(body),
      action: SnackBarAction(
        textColor: Colors.white,
        label: "Close",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}