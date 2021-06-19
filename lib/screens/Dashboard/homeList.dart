
import 'dart:io';

import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/model/newsModel.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'add.dart';





class HomeList extends StatefulWidget {
  const HomeList({Key key}) : super(key: key);

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  Firestore firestore = Firestore.instance;
  final auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  List isEmpty = [
    "1",
    "2",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Builder(builder: (context) {
          bool isEmpty1 = false;
          if(isEmpty1){
            return Center(child: CupertinoActivityIndicator(),);
          }
          else if (isEmpty.isEmpty) {
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
          return StreamBuilder(
            stream:firestore.collection("messages").snapshots(),
            builder: (context, snapshot){
              List <Post> posts = [];
                if(snapshot.hasData){

                  List messages = snapshot.data.documents;
                  (messages as List).forEach((dat){

                    print(dat.documentID);
                    posts.add(Post(

                      id: dat.documentID,
                      title: dat["title"],
                      sender: dat["sender"],
                      image: dat["images"],
                      desc: dat["Description"]
                    ));
                  });

                  return Column(
                    children: posts.map((e) {
                      return addItem(context, news: e);
                    }).toList(),
                  );

                  // for ( var  post in posts) {
                  //   return  Column(
                  //     children: posts.,
                  //   )
                  // }


              // post.forEach((element, index) {
              //
              //   return addItem(context, news: post[element])
              // })







                    // for (var message in messages) {
                    // final  List<Post> post = [];

             // var post  =   Post.fromJson(message);

    }else if(!snapshot.data ) {
                  return Text("No post");
                }
               else if (snapshot.hasError ){
               return   Text("An error occured");
                }
                return Center(child: CupertinoActivityIndicator());
            },
          );


        }),
      ),
    );
  }





  Widget addItem(BuildContext context, {Post news}) {
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
          color: kSelectedCardBackgroundColor,
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
                    news.title,
                    // news["title"],
                    // CommonUtils.formatDate(news.publishedAt),
                    style: TextStyle(color: kSurfaceColor, fontSize: 10),
                  ),
                  SizedBox(height: 3),
                  Text(
                    news.desc,
                    // news["Description"],
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


class FileClass {
  File file;

  @override
  String toString() {
    super.toString();
    return "${file.path}";
  }

  void changeFile(File newFile) {
    file = newFile;
  }
}

Future<File> getFile({File file}) async {

  File  result = await ImagePicker.pickImage(source: ImageSource.gallery);
  if(result != null) {
    File file = File(result.path);
    int sizeInBytes = file.lengthSync();
    // if(sizeInBytes < 307200){
      return file;
    // }else{
    //   // toast("Files too large, maximum is 300kb");
    //
    // }

  // } else {
  //   return null;
  }

}



class Post{
  String id;
  String title;
  String desc;
  String image;
  String sender;



  Post({this.sender, this.desc, this.title, this.image, this.id});
  factory Post.fromJson(Map<String , dynamic> json)=>Post(
    title: json["title"],
    desc: json["Description"],
    image: json["images"],
    sender: json["sender"],
      id: json["id"]
  );
}

