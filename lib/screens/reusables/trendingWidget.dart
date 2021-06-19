import 'package:flutter/material.dart';


// class TrendingNewsWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 5 * SizeConfig.heightMultiplier,
//
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8.0),
//                 child: Image.asset(
//                   "assets/images/bit.png",
//                 ),
//               ),
//               SizedBox(width: 5.0 * SizeConfig.widthMultiplier,),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//
//                         child: Text("Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars", textAlign: TextAlign.start, style: TextStyle(fontSize: 1.4 * SizeConfig.textMultiplier, fontWeight: FontWeight.w500),)),
//
//                     Container(
//                       width: MediaQuery.of(context).size.width / 1.7,
//                       child: Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children:[
//                           Text("6hrs ago",  style: TextStyle(fontSize: 1.1 * SizeConfig.textMultiplier),),
//                           SizedBox(width: 5.3 * SizeConfig.widthMultiplier,),
//
//                           RichText(
//                             text: TextSpan(
//                               text: "Category:",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize:  1.1 * SizeConfig.textMultiplier,
//
//                               ),
//                               children: [
//                                 TextSpan(
//                                     text:" DeFi",
//                                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize:  1.1 * SizeConfig.textMultiplier)
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//
//         ),
//         SizedBox(height: 4.4 * SizeConfig.heightMultiplier,)
//
//       ],
//     );
//   }
// }