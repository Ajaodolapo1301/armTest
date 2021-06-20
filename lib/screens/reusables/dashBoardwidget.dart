


import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/screens/Dashboard/PostView.dart';
import 'package:arm_test/screens/Dashboard/newsPage.dart';
import 'package:arm_test/screens/reusables/homeCard.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonalDashboardView extends StatefulWidget {
  final AnimationController fadeController;




  const PersonalDashboardView({
    Key key,
    this.fadeController,

  }) : super(key: key);

  @override
  _PersonalDashboardViewState createState() => _PersonalDashboardViewState();
}

class _PersonalDashboardViewState extends State<PersonalDashboardView> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {


    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [

        FadeTransition(
          opacity: widget.fadeController.drive(Tween(begin: 0.4, end: 1.0)),
          child: Container(
            color: Colors.white,
            width: double.maxFinite,
            padding: EdgeInsets.only(bottom: 10, top: 5),
            child: Center(
              child: Text(
                "Click a button to get to the main view",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ),
        ) ,






        SizedBox(height: 5),
        Expanded(
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: HomeCard(
                      imagePath: "assets/images/home/fund_transfer.png",
                      mainText: "Post",
                      subText: "Post private thoughts",
                      color: almostRed,
                      onTap: () {
              pushTo(context, PostPage());
                      }
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: HomeCard(
                      imagePath: "assets/images/home/reserve_fund.png",
                      mainText: "News",
                      subText: "See whats going on in the world",
                      color: almostCyan,
                      onTap: (){
                        pushTo(context, NewsPage());
                        // CommonUtils.modalBottomSheetMenu(context: context, body: StashModal());
                        // CommonUtils.kShowSnackBar(ctx: context, msg: "Feature Coming soon");
                        // pushTo(context, ReserveFundsPage());
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: HomeCard(
                      imagePath: "assets/images/home/airtime_and_bills.png",
                      mainText: "Announcement",
                      subText: "Make an announcement",
                      color: almostPurple,
                      onTap: (){
                        CommonUtils.modalBottomSheetMenu(context: context, body:buildModal());
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: HomeCard(
                      imagePath: "assets/images/home/account_statement.png",
                      mainText: "Invite",
                      subText: "Invite your friends",
                      color: almostGreen,
                      onTap: (){
                      CommonUtils.modalBottomSheetMenu(context: context, body:buildModal());
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}


Widget buildModal({text, subText, String status  }) {

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 15,),
        Container(
          child: SvgPicture.asset(
            "assets/images/sad.svg", height: 70,
          ),
        ),
        SizedBox(height: 10,),
        Text("Feature not ready",
            style: TextStyle(
              color: blue,

              fontWeight: FontWeight.bold,
              fontSize:15,
            )),

        SizedBox(
          height: 10,
        ),
        Text(

  "Check back later" ,
          textAlign: TextAlign.center,
          style:TextStyle(
              color: blue,
              fontSize: 10),
        ),
        SizedBox(
          height: 30,
        ),

//        9921738168
//           Container(
//             child: SizedBox(
//               width: double.maxFinite,
//               height: 50,
//               child: RaisedButton(
//                 onPressed: () {
//                   Clipboard.setData(new ClipboardData(
//                       text: loginState.user.bankAaccountNumber));
//
//                   toast("Copied to Clipboard");
//                 },
//                 child: Text(
//                   "COPY ACCOUNT NO",
//                   style: GoogleFonts.mavenPro(
//                     fontSize: 16,
//                   ),
//                 ),
//                 color: kPrimaryColor,
//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 textColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(7),
//                 ),
//               ),
//             ),
//           ),
        SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}