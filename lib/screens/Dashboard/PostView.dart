


import 'package:after_layout/after_layout.dart';
import 'package:arm_test/Provider/newsProvider.dart';
import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/model/newsModel.dart';
import 'package:arm_test/model/postModel.dart';
import 'package:arm_test/screens/Dashboard/add.dart';
import 'package:arm_test/screens/Dashboard/homeList.dart';
import 'package:arm_test/screens/reusables/postWidget.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/header.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'newsDetails.dart';

class PostPage extends StatefulWidget {

  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formkey;

  PostPage({this.scaffoldKey, this.formkey});
  @override
  _PostPageState createState() =>
      _PostPageState();
}

class _PostPageState extends State<PostPage> with AfterLayoutMixin<PostPage> {
  NewsState newsState;
  bool isLoading = false;
  Firestore firestore = Firestore.instance;
  final auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  List<NewsModel> news = [];
  @override
  Widget build(BuildContext context) {
    newsState = Provider.of<NewsState>(context);
    return Scaffold(
        floatingActionButton:
             FloatingActionButton(
          onPressed: () {
            pushTo(context, Add());
          },
          // child: Text("+", style: TextStyle(color: Colors.white),),
          child: Icon(Icons.add),
        ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child:
          Column(
            children: [

              Header(
                text: "Posts",
                preferredActionOnBackPressed: (){
                  pop(context);

                },
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Builder(builder: (context) {
                  bool isEmpty1 = false;
                  return StreamBuilder(
                    stream:firestore.collection("messages").snapshots(),
                    builder: (context, snapshot){
                      List <Post> postsList = [];
                      if(snapshot.hasData) {
                        List messages = snapshot.data.documents;
                        (messages as List).forEach((dat) {
                          print(dat.documentID);
                          postsList.add(Post(

                              id: dat.documentID,
                              title: dat["title"],
                              sender: dat["sender"],
                              image: dat["images"],
                              desc: dat["Description"]
                          ));
                        });

                        return Column(
                          children: postsList.map((e) {
                            return postWidget(context, news: e);
                          }).toList(),
                        );
                      }
                      else if (snapshot.hasError ){
                        return   Text("An error occured");
                      }
                      return Center(child: CupertinoActivityIndicator());
                    },
                  );


                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loanItem(BuildContext context, NewsModel news) {
    return GestureDetector(
      onTap: () {
        pushTo(context, NewsDetails(
          newsModel: news,

        ));
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