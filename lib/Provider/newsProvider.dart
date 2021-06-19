

import 'package:arm_test/Services/newService.dart';
import 'package:arm_test/model/newsModel.dart';
import 'package:flutter/cupertino.dart';

class NewsState extends AbstractNewsViewModel with ChangeNotifier{



  List<NewsModel> _news= [];
  List<NewsModel> get news => _news;
  set news(List<NewsModel> news1) {
    _news = news1;
    notifyListeners();
  }
  @override
  Future<Map<String, dynamic>> getNews() async{
    Map<String, dynamic> result = Map();

    try{
      result = await NewsImpl().getNews();
      if(result["error"] == null) {
        result['error'] = true;
        result['message'] = 'An Error occured, please  check your internet connection and try again';
      }else{
        if(result['error'] == false){
          news = result["newsModel"];
        }

      }
    }catch(e){
      print(e.toString());
    }
    return result;
  }


}


abstract class AbstractNewsViewModel {
  Future<Map<String, dynamic>> getNews();
}