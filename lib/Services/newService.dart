import 'dart:convert';

import 'package:arm_test/model/newsModel.dart';
import 'package:http/http.dart' as http;

abstract class AbstractNews {
Future<Map<String, dynamic>> getNews();

}

class NewsImpl implements AbstractNews{
  @override
  Future<Map<String, dynamic>> getNews() async{
    Map<String, dynamic> result = {};
    final String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=8e33ee34c7384342975e83dc319e18e8";
    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;

      if (statusCode != 200 && statusCode != 500) {
        result["message"] = jsonDecode(response.body)["error"];

        print("eeroror${result["message"]}");
        result['error'] = true;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["error"] = false;
        List<NewsModel> newsModel = [];

        (jsonDecode(response.body)['articles'] as List).forEach((dat){
          newsModel.add(NewsModel.fromJson(dat));
        });
        result['newsModel'] = newsModel;
      }
    } catch (error) {
      // print(error.toString());
      result["message"] = error.toString();
    }

    return result;
  }


}


