

import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/model/postModel.dart';
import 'package:arm_test/screens/Dashboard/add.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:flutter/material.dart';

Widget postWidget(BuildContext context, {Post news}) {
  return GestureDetector(
    onTap: () {
      pushTo(context, Add(
        post: news,
      ));
      // newsModel: news,
      //
      // ));
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
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
                  news.title,
                  // news["title"],
                  // CommonUtils.formatDate(news.publishedAt),
                  style: TextStyle(color: blue, fontSize: 10),
                ),
                SizedBox(height: 3),
                Text(
                  news.desc,
                  // news["Description"],
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(color:blue,


                  ),
                )
              ],
            ),
          ),
           Container(
             height: 40,
             width: 40,
             decoration: BoxDecoration(


               shape: BoxShape.circle,
               image: DecorationImage(
                 fit: BoxFit.cover,
                 image: NetworkImage(news?.image)
               )
             ),
           )
        ],
      ),
    ),
  );
}