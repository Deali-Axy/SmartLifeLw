import 'package:flutter/material.dart';
import 'package:smart_life_lw/config.dart';
import 'package:smart_life_lw/network/sina_news.dart';
import 'package:smart_life_lw/network/home_news.dart';

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
      this.onDisLikePressed}) {
    _newsManager.init();
    _sinaNewsManager.init();
    _refresh();
  }

  _refresh() async {
    if (GlobalConfig.focusMode) {
      _currentNews = _newsManager.getNext();
    } else {
      SinaNewsObject sinaNews = _sinaNewsManager.getNext();
      if (sinaNews == null) {
        Scaffold.of(_context).showSnackBar(SnackBar(
          content: Text('加载新闻资讯失败！'),
          duration: Duration(milliseconds: 500),
        ));
        return;
      }
      _currentNews = HomeNews(
          title: sinaNews.title,
          synopsis: sinaNews.summary,
          bannerUrl: sinaNews.pics[0],
          bannerAddress: sinaNews.pics[0]);
    }
    if (_currentNews != null) {
      title = _currentNews.title;
      summary = _currentNews.synopsis;
      picUrl = _currentNews.bannerUrl;
      setState(() {});
    }
  }

  _like() {
    _refresh();
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text('喜欢～'),
      duration: Duration(milliseconds: 100),
    ));
  }

  _dislike() {
    _refresh();
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text('不喜欢～'),
      duration: Duration(milliseconds: 100),
    ));
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
            Image.network(picUrl, fit: BoxFit.fitWidth, width: 400),
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
