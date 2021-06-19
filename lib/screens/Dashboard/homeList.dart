
import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/model/newsModel.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





class HomeList extends StatefulWidget {
  const HomeList({Key key}) : super(key: key);

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        bool isEmpty = true;
        if(isEmpty){
          return Center(child: CupertinoActivityIndicator(),);
        }
        else if (isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Text(
                "No history yet.",
                style: TextStyle(
                    color: kPrimaryLight, fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Text(
                "Make transactions to see history",
                textAlign: TextAlign.center,
                style: TextStyle(color: kPrimaryLight, fontSize: 11),
              )
            ],
          );
        }
        return ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 20,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Add(context, );
          },
        );
      }),
    );
  }


  Widget Add(BuildContext context, {NewsModel news}) {
    return GestureDetector(
      onTap: () {
        // pushTo(context, NewsDetails(
        //   newsModel: news,
        //
        // ));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kPrimaryLight,
          border: Border.all(
            // color: borderBlue.withOpacity(0.05),
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
                    style: TextStyle(color: kSurfaceColor, fontSize: 10),
                  ),
                  SizedBox(height: 3),
                  Text(news.title,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(color:kSurfaceColor,


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
}
