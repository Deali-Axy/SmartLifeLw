import 'package:flutter/material.dart';
import 'package:smart_life_lw/config.dart';
import 'package:smart_life_lw/network/sina_news.dart';
import 'package:smart_life_lw/network/home_news.dart';
import 'package:smart_life_lw/utils/toast.dart';
import 'package:smart_life_lw/widget/network_image_ex.dart';

class NewsCard extends StatefulWidget {
  final String title;
  final String summary;
  final String picUrl;

  final Function onLikePressed;
  final Function onDisLikePressed;

  NewsCard(
      {@required this.title,
      @required this.summary,
      @required this.picUrl,
      this.onLikePressed,
      this.onDisLikePressed});

  @override
  _NewsCardState createState() => _NewsCardState(
      title: title,
      summary: summary,
      picUrl: picUrl,
      onLikePressed: onLikePressed,
      onDisLikePressed: onDisLikePressed);
}

class _NewsCardState extends State<NewsCard> {
  BuildContext _context;
  String title;
  String summary;
  String picUrl;

  Function onLikePressed;
  Function onDisLikePressed;

  HomeNews _currentNews;
  HomeNewsManager _newsManager = HomeNewsManager();
  SinaNewsManager _sinaNewsManager = SinaNewsManager();

  _NewsCardState(
      {@required this.title,
      @required this.summary,
      @required this.picUrl,
      this.onLikePressed,
      this.onDisLikePressed});

  _refresh() async {
    if (GlobalConfig.focusMode) {
      _currentNews = _newsManager.getNext();
    } else {
      SinaNewsObject sinaNews = _sinaNewsManager.getNext();
      if (sinaNews == null) {
        if (_context != null)
          Toast.show(context, '加载新闻资讯失败！');
        else
          print('加载新闻资讯失败，而且也找不到context对象');

        return;
      }
      _currentNews = HomeNews(
          title: sinaNews.title,
          synopsis: sinaNews.summary,
          bannerUrl: sinaNews.pics.isEmpty ? '' : sinaNews.pics[0],
          bannerAddress: sinaNews.pics.isEmpty ? '' : sinaNews.pics[0]);
    }
    if (_currentNews != null) {
      title = _currentNews.title;
      summary = _currentNews.synopsis;
      picUrl = _currentNews.bannerUrl;
      print('刷新新闻卡片！');
      setState(() {});
    } else
      print('没有新闻可以刷新！');
  }

  _like() {
    _refresh();
    Toast.show(_context, '喜欢～');
//    Scaffold.of(_context).showSnackBar(SnackBar(
//      content: Text('喜欢～'),
//      duration: Duration(milliseconds: 100),
//    ));
  }

  _dislike() {
    _refresh();
    Toast.show(_context, '不喜欢～');
//    Scaffold.of(_context).showSnackBar(SnackBar(
//      content: Text('不喜欢～'),
//      duration: Duration(milliseconds: 100),
//    ));
  }

  _init() async {
    await _newsManager.init();
    await _sinaNewsManager.init();
    _refresh();
  }

  @override
  void initState() {
    print('初始化新闻卡片');
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NetworkImageEx(
              assetName: 'images/friend_circle_cover_bg.jpg',
              indicator: true,
              imageUrl:
                  picUrl.isEmpty ? 'http://lorempixel.com/400/400/' : picUrl,
              fit: BoxFit.fitWidth,
              width: 400,
            ),
            Divider(height: 10),
            Text(title, style: TextStyle(fontSize: 20)),
            Text(summary, style: TextStyle(fontSize: 14)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.favorite_border, size: 30),
                    onPressed: _dislike),
                IconButton(
                    icon: Icon(Icons.favorite, color: Colors.pink, size: 30),
                    onPressed: _like),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
