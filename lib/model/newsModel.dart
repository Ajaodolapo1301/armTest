


class NewsModel{
  String author;
  String title;
  String description;
  String url;

  String urlToImage;
  String publishedAt;
  String content;
  // Source source;
  NewsModel({this.author, this.title,  this.content, this.description, this.publishedAt, this.url, this.urlToImage});
  // this.source,
  NewsModel.fromJson(Map <String,  dynamic> json){
    author =  json['author'];
    title = json["title"];

    description =  json['description'];
    url = json["url"];
    urlToImage =  json['urlToImage'];
    publishedAt = json["publishedAt"];
    // source = json["source"];
  }
}



class Source {
  String id;
  String name;

  Source({this.id, this.name});

  Source.fromJson(Map <String, dynamic> json){
    id = json['id'];
    name = json["name"];
  }

}
