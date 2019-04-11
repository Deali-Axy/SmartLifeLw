import 'dart:convert';
import 'package:smart_life_lw/utils/http.dart';

class NewsObject {
  String id;
  String title;
  String stitle;
  String url;
  String pc_url;
  String basetype;
  String news_id;
  String cTime;
  String cdateTime;
  List<String> pics = List<String>();
  String source;
  String summary;

  NewsObject(
      {this.id,
      this.title,
      this.stitle,
      this.url,
      this.pc_url,
      this.basetype,
      this.news_id,
      this.cTime,
      this.cdateTime,
      this.source,
      this.summary});

  @override
  String toString() {
    return this.title;
  }
}

class SinaNews {
  static getAllNews() async {
    String responseStr =
        await get('http://interface.sina.cn/wap_api/layout_col.d.json?');
    var newsList = List<NewsObject>();
    var jsonMap = jsonDecode(responseStr);
    for (var newsItem in jsonMap['result']['data']['list']) {
      var newsObj = NewsObject(
          id: newsItem['_id'],
          title: newsItem['title'],
          stitle: newsItem['stitle'],
          url: newsItem['URL'],
          pc_url: newsItem['pc_url'],
          news_id: newsItem['news_id'],
          cTime: newsItem['cTime'],
          cdateTime: newsItem['cdateTime'],
          source: newsItem['source'],
          summary: newsItem['summary']);
      if (newsItem['allPics']['total'] >= 1) {
        for (var picItem in newsItem['allPics']['pics']) {
          newsObj.pics.add(picItem['imgurl']);
          print('Hint Picture: ${picItem["imgurl"]}');
        }
      }
      newsList.add(newsObj);
      print('Hint News: $newsObj');
    }
    return newsList;
  }
}
