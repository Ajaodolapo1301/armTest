




import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/model/newsModel.dart';
import 'package:arm_test/screens/Dashboard/newsDetails.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:flutter/material.dart';

Widget newsWidget(BuildContext context, NewsModel news) {
  return GestureDetector(
    onTap: () {
      pushTo(context, NewsDetails(
        newsModel: news,

      ));
    },
    child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lightBlue,
        border: Border.all(
          color: borderBlue.withOpacity(0.05),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CommonUtils.formatDate(news.publishedAt),
                  style: TextStyle(color: blue, fontSize: 10),
                ),
                SizedBox(height: 3),
                Text(news.title,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(color:blue,


                  ),
                )
              ],
            ),
          ),
          // Text(
          //   news.description),
          // style: TextStyle(color:   creditHistory.status == "pending" || creditHistory.status == "pause" ||   creditHistory.status == "awaiting-user-response" || creditHistory.status == "under-review"   ?  Colors.yellow[900] :
          // creditHistory.status == "approved" || creditHistory.status == "active" ? Colors.green
          //     : creditHistory.status == "cancelled" || creditHistory.status == "rejected" || creditHistory.status == "closed" ?Colors.red : Colors.black12
          //     ,
          //     fontWeight: FontWeight.bold),
        ],
      ),
    ),
  );
}