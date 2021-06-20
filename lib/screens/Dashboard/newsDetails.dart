

import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/model/newsModel.dart';
import 'package:arm_test/sizeConfig/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class NewsDetails extends StatefulWidget {
  NewsModel newsModel;
   NewsDetails({Key key, this.newsModel}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: true,
              snap: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.newsModel.urlToImage)
                    )
                  ),
                )
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin:EdgeInsets.symmetric(vertical: 20, horizontal: 10) ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Title", style: TextStyle(
                                color: Colors.black,

                                fontSize: 1.9 * SizeConfig.textMultiplier),),
                            SizedBox(height: 10,),
                            Text(widget.newsModel.title, style: TextStyle(
                                color: Colors.black,

                                fontSize: 2.0 * SizeConfig.textMultiplier),),
                          ],
                        ),
                      ),

                      Container(
                        margin:EdgeInsets.symmetric(vertical: 10, horizontal: 10) ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Description",  style: TextStyle(
                            color: blue,

                            fontSize: 1.9 * SizeConfig.textMultiplier),
                        ),
                            SizedBox(height: 10,),
                            Text(
                              widget.newsModel.description, style: TextStyle(
                                color: Colors.black,

                                fontSize: 2.0 * SizeConfig.textMultiplier),),
                          ],
                        ),
                      ),

                      TextButton(
                        onPressed: _launchURL,
                          child: Text("Click here for more info", style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline )  ))
                    ]
              ),
            ),
          ],
        )
    );
  }

  void _launchURL() async =>
      await canLaunch(widget.newsModel.url) ? await launch(widget.newsModel.url) : throw 'Could not launch ${widget.newsModel.url}';
}
