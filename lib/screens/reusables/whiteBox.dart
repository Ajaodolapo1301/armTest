


import 'package:flutter/material.dart';


class WhiteCard extends StatelessWidget {
  final Widget child;


  WhiteCard({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
//            margin: EdgeInsets.symmetric(horizontal: 20,  ),
      child: Material(
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(10),
        child: Container(

          // padding: EdgeInsets.symmetric(horizontal: 1.8 * SizeConfig.textMultiplier, vertical:1.8 * SizeConfig.textMultiplier, ),
          // padding:  EdgeInsets.symmetric(horizontal: 2 * SizeConfig.widthMultiplier, vertical: 2 * SizeConfig.widthMultiplier,),
          // padding: EdgeInsets.only(left: 1.2 * SizeConfig.textMultiplier, top: 1.2 * SizeConfig.textMultiplier, bottom: 1.2 * SizeConfig.textMultiplier,),
          // height: 11.3 * SizeConfig.heightMultiplier ,
          child: child,
        ),
      ),
    );
  }
}