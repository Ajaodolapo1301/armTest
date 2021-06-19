//
//
// import 'package:arm_test/sizeConfig/sizeConfig.dart';
// import 'package:flutter/material.dart';
// import 'package:haggle/constants/colorConstants.dart';
// import 'package:haggle/model/doMore.dart';
// import 'package:haggle/utils/sizeConfig/sizeConfig.dart';
//
// class DoMoreWidget extends StatelessWidget {
//   final DoMoreModel doMoreModel;
//   DoMoreWidget({this.doMoreModel});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 3,
//               blurRadius: 7,
//               offset: Offset(0, 3),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(10)
//       ),
//       margin: EdgeInsets.symmetric(vertical: 7),
//
//       child: Material(
//         borderRadius: BorderRadius.circular(10),
//         elevation: 0.2,
//         child: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: 1.9 * SizeConfig.heightMultiplier, vertical:  1.5 * SizeConfig.heightMultiplier, ),
//           child: Row(
//
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//
//               Container(
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xfff6f4ff)
//                 ),
//                 child: Padding(
//                   padding:  EdgeInsets.all(3.0),
//                   child: doMoreModel.isIcon ? Icon(Icons.credit_card_sharp, color: kPrimaryColor): Image.asset(doMoreModel.image),
//                 ),
//                 height: 6.1 * SizeConfig.heightMultiplier,
//                 width: 10.6 * SizeConfig.widthMultiplier,
//
//               ),
//               SizedBox(width: 10,),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(doMoreModel.title,  style: TextStyle(fontSize: 1.3 * SizeConfig.textMultiplier, fontWeight: FontWeight.w600),),
//                   SizedBox(height: 6,),
//                   Text(doMoreModel.subTitle,  style: TextStyle(fontSize:  1.3 * SizeConfig.textMultiplier, fontWeight: FontWeight.w400),)
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }