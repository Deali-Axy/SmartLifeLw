import 'dart:convert';
import 'package:smart_life_lw/utils/http.dart';

class HomeNews {
  int id;
  String title;
  String synopsis;
  String bannerAddress;
  String bannerUrl;

  HomeNews(
      {this.id, this.title, this.synopsis, this.bannerAddress, this.bannerUrl});
}

class HomeNewsUtils {
  static getAll() async {
    var newsList = List<HomeNews>();
    var url = 'http://47.106.203.63:8080/HZlife/bannerAll';
    var responseStr = await get(url);
    Map jsonMap = jsonDecode(responseStr);
    for (Map item in jsonMap['data']) {
      newsList.add(HomeNews(
          id: item['id'],
          title: item['title'],
          synopsis: item['synopsis'],
          bannerAddress: item['bannerAddress'],
          bannerUrl: item['bannerUrl']));
    }

    print('获取全部新闻完成！');
    return newsList;
  }
}

class HomeNewsManager {
  List<HomeNews> newsList = List();
  int currentIndex = 0;

  init() async {
    this.newsList = await HomeNewsUtils.getAll();
  }

  getNext() {
    if (newsList.length == 0) {
      print('新闻列表里面根本没东西！');
      return null;
    }
    var index = currentIndex++;
    if (currentIndex >= newsList.length) {
      currentIndex = 0;
    }
    return newsList[index];
  }
}
