//
//
//
// import 'package:flutter/material.dart';
// import 'package:haggle/model/marketModel.dart';
//
// class MarketWidget extends StatelessWidget {
//   MarketModel marketModel;
//   MarketWidget({this.marketModel});
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//           child:Row(
//             children: [
//               Container(
//
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xffF3F3F3)
//                   // marketModel.color ?? Colors.transparent
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: marketModel.color,
//                         // marketModel.color ?? Colors.transparent
//                       ),
//
//                       child: Transform.scale(
//                           scale:marketModel.editSize  ?   1.5 : marketModel.scaledown? 0.6 : 1.0 ,
//                           child: Image.asset( marketModel.image))),
//                 ),
//                 height: 40,
//                 width: 40,
//
//               ),
//               SizedBox(width: 10,),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(marketModel.name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),),
//
//                   SizedBox(height: 4,),
//                   RichText(
//                     text: TextSpan(
//                       text: "${marketModel.currency}${marketModel.amount}",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 9,
//
//                       ),
//                       children: [
//                         TextSpan(
//                             text:   marketModel.percentage == null ? " " : "   ${marketModel.percentage}" ,
//                             style: TextStyle(fontWeight: FontWeight.normal, color: Colors.green)
//                         ),
//
//                       ],
//                     ),
//                   ),
//
//
//                   // Text("${marketModel.currency}${marketModel.amount}",style: TextStyle(fontSize: 9, ),)
//                 ],
//               ),
//               Spacer(),
//               Column(
//                 children: [
//                   SizedBox(height: 10,),
//                   Image.asset(marketModel.chartImage, height: 22,),
//                 ],
//               )
//             ],
//           ),
//         ),
//
//         Divider()
//       ],
//     );
//   }
// }