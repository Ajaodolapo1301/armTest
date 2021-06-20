

import 'package:after_layout/after_layout.dart';
import 'package:arm_test/Provider/newsProvider.dart';
import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/model/newsModel.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/header.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'newsDetails.dart';

class NewsPage extends StatefulWidget {

  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formkey;

  NewsPage({this.scaffoldKey, this.formkey});
  @override
  _NewsPageState createState() =>
      _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with AfterLayoutMixin<NewsPage> {
  NewsState newsState;
  bool isLoading = false;

  List<NewsModel> news = [];
  @override
  Widget build(BuildContext context) {
    newsState = Provider.of<NewsState>(context);
    return Scaffold(
      body:  SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Builder(builder: (context) {
            bool isEmpty = true;
            if(isLoading){
              return Center(child: CupertinoActivityIndicator(),);
            }
            else if (newsState?.news?.isEmpty ) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5),
                  Text(
                    "No News yet.",
                    style: TextStyle(
                        color: kPrimaryLight, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    "Refresh to see news",
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
              itemCount: newsState.news.length,
              itemBuilder: (context, index) {
                return newsWidget(context, newsState.news[index]);
              },
            );
          }),
        ),
      ),
    );
  }

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

  @override
  void afterFirstLayout(BuildContext context) {
    fetchNew();
  }

  void fetchNew()async{
    setState(() {
      isLoading = true;
    });
    var result = await  newsState.getNews();
    setState(() {
      isLoading = false;
    });
    if(result["error"] == false){
      setState(() {
        news = result["newsModel"];
        print(news);
      });
    }else{

      CommonUtils.kShowSnackBar(color: Colors.red, ctx: context, msg: result["message"]);
    }

  }


}
