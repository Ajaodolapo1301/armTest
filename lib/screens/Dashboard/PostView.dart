import 'package:after_layout/after_layout.dart';
import 'package:arm_test/Provider/newsProvider.dart';
import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/model/newsModel.dart';
import 'package:arm_test/model/postModel.dart';
import 'package:arm_test/screens/Dashboard/add.dart';

import 'package:arm_test/screens/reusables/postWidget.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/header.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:arm_test/sizeConfig/sizeConfig.dart';
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
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with AfterLayoutMixin<PostPage> {
  NewsState newsState;
  bool isLoading = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  User user;

  getCurrent() async {
    user = auth.currentUser;
    print(user);
  }

  List<NewsModel> news = [];

  @override
  void initState() {
    getCurrent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newsState = Provider.of<NewsState>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushTo(context, Add());
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Header(
                text: "Posts",
                preferredActionOnBackPressed: () {
                  pop(context);
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Builder(builder: (context) {
                  return StreamBuilder(
                    stream: firestore.collection("messages").snapshots(),
                    builder: (context, snapshot) {
                      List<Post> postsList = [];
                      if (snapshot.hasData) {
                        List messages = snapshot.data.docs;
                        (messages as List).forEach((dat) {
                          print(dat.id);
                          postsList.add(Post(
                              id: dat.id,
                              title: dat["title"],
                              sender: dat["sender"],
                              image: dat["images"],
                              desc: dat["Description"]));
                        });

                        return postsList.isEmpty
                            ? Container(
                            // height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
                                  Text(
                                    "No Post yet.",
                                    style: TextStyle(
                                        color: kPrimaryLight,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    "Add some posts to see posts",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: kPrimaryLight, fontSize: 11),
                                  )
                                ],
                              ),
                            )
                            : Column(
                                children: postsList.map((e) {
                                  return postWidget(context, post: e);
                                }).toList(),
                              );
                      } else if (snapshot.hasError) {
                        return Text("An error occured");
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
        pushTo(
            context,
            NewsDetails(
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
                  Text(
                    news.title,
                    style: TextStyle(
                      color: kSurfaceColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // fetchNew();
  }

  // void fetchNew() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var result = await newsState.getNews();
  //   setState(() {
  //     isLoading = false;
  //   });
  //   if (result["error"] == false) {
  //     setState(() {
  //       news = result["newsModel"];
  //       print(news);
  //     });
  //   } else {
  //     CommonUtils.kShowSnackBar(
  //         color: Colors.red, ctx: context, msg: result["message"]);
  //   }
  // }
}
