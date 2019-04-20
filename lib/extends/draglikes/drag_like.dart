import 'package:flutter/material.dart';
import 'drag_like_stack.dart';
import 'package:oktoast/oktoast.dart';
import 'package:smart_life_lw/network/sina_news.dart';
import 'package:smart_life_lw/routes.dart';
import 'package:smart_life_lw/config.dart' as Config;

class NewsCard {
  final String description;
  final String imgUrl;

  NewsCard(this.description, this.imgUrl);
}

class DragLikePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DragLikeState();
}

class DragLikeState extends State<DragLikePage> with TickerProviderStateMixin {
  AnimationController controller;

  int aboveIndex = 0;
  int belowIndex = 1;

  final double bottomHeight = 100.0;
  final double defaultIconSize = 30.0;
  final Color defaultIconColor =
      Color.lerp(Color(0xFFFF80AB), Color(0xFFC51162), 0.0);

  double position = 0.0;
  SlideDirection slideDirection;

  double get leftIconSize => slideDirection == SlideDirection.left
      ? defaultIconSize * (1 + position * 0.8)
      : defaultIconSize;

  double get rightIconSize => slideDirection == SlideDirection.right
      ? defaultIconSize * (1 + position * 0.8)
      : defaultIconSize;

  Color get leftIconColor => slideDirection == SlideDirection.left
      ? Color.lerp(Color(0xFFFF80AB), Color(0xFFC51162), position)
      : defaultIconColor;

  Color get rightIconColor => slideDirection == SlideDirection.right
      ? Color.lerp(Color(0xFFFF80AB), Color(0xFFC51162), position)
      : defaultIconColor;

  List<NewsCard> cards = [
    NewsCard('测试', '123'),
    NewsCard('测试', '123'),
    NewsCard('测试', '123'),
  ];

  void setAboveIndex() {
    if (aboveIndex < cards.length - 1) {
      aboveIndex++;
    } else {
      aboveIndex = 0;
    }
  }

  void setBelowIndex() {
    if (belowIndex < cards.length - 1) {
      belowIndex++;
    } else {
      belowIndex = 0;
    }
  }

  void onSlide(double position, SlideDirection direction) {
    setState(() {
      this.position = position;
      this.slideDirection = direction;
    });
  }

  void onSlideCompleted() {
    controller.forward();
    String isLike =
        (slideDirection == SlideDirection.left) ? 'dislike' : 'like';
//    showToast('You $isLike this !',
//        duration: const Duration(milliseconds: 1500));
    setAboveIndex();
  }

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    )
      ..addListener(() {
        setState(() {
          if (position != 0) {
            position = 1 - controller.value;
          }
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  _refresh() async {
    var newsList = SinaNewsUtils.getAllNews();
    cards.clear();
    for (SinaNewsObject newsItem in newsList) {
      cards.add(NewsCard(
          newsItem.title, newsItem.pics.length > 0 ? newsItem.pics[0] : ''));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 左侧抽屉的用户头像
    Widget userHeader = new UserAccountsDrawerHeader(
      accountName: new Text('汇智用户'),
      accountEmail: new Text('空山新雨后，天气晚来秋'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: NetworkImage('http://lorempixel.com/200/200/'),
        radius: 35.0,
      ),
    );

    // 左侧抽屉布局
    Widget drawer = new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          userHeader, // 可在这里替换自定义的header
          ListTile(
            title: Text('选择标签'),
            leading: new CircleAvatar(
              child: new Icon(Icons.label),
            ),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.choose_labels);
            },
          ),
          ListTile(
            title: Text('选择群体'),
            leading: new CircleAvatar(
              child: new Icon(Icons.people),
            ),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.choose_peoples);
            },
          ),
          ListTile(
            title: Text('专注时间'),
            leading: new CircleAvatar(
              child: new Icon(Icons.timer),
            ),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.focus_time);
            },
          ),
          ListTile(
            title: Text('呼叫Life'),
            leading: new CircleAvatar(
              child: new Icon(Icons.chat),
            ),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.chat);
            },
          ),
          ListTile(
            title: Text('汇智圈子'),
            leading: new CircleAvatar(
              child: new Icon(Icons.cloud_circle),
            ),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.circle);
            },
          ),
          Divider(),
          ListTile(
            title: Text('检查更新'),
            leading: CircleAvatar(
              child: Icon(Icons.update),
            ),
          ),
          ListTile(
            title: Text('设置'),
            leading: CircleAvatar(
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(Config.TITLE),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () => _refresh())
        ],
      ),
      drawer: drawer,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                '左滑不感兴趣，右滑收藏～',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: _buildCard(),
              ),
            ),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Stack(
      children: <Widget>[
        _buildBackground(),
        Positioned(
          child: SlideStack(
            child: _buildChooseView(cards[aboveIndex]),
            below: _buildChooseView(cards[belowIndex]),
            slideDistance: MediaQuery.of(context).size.width - 40.0,
            onSlide: onSlide,
            onSlideCompleted: onSlideCompleted,
            refreshBelow: setBelowIndex,
            rotateRate: 0.4,
          ),
          left: 10.0,
          top: 20.0,
          bottom: 40.0,
          right: 10.0,
        ),
      ],
    );
  }

  Widget _buildChooseView(NewsCard girl) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Image.network(
            'http://lorempixel.com/400/500/business?id=${girl.imgUrl}',
            fit: BoxFit.cover,
          ),
          left: 35.0,
          right: 35.0,
          top: 20.0,
          bottom: 50.0,
        ),
        Positioned(
          child: Text(
            girl.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
      ],
    );
  }

  Stack _buildBackground() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Card(
            child: Text('test'),
          ),
          left: 40.0,
          top: 40.0,
          bottom: 10.0,
          right: 40.0,
        ),
        Positioned(
          child: Card(
            child: Text('test'),
          ),
          left: 30.0,
          top: 30.0,
          bottom: 20.0,
          right: 30.0,
        ),
        Positioned(
          child: Card(
            child: Text('test'),
          ),
          left: 20.0,
          top: 30.0,
          bottom: 30.0,
          right: 20.0,
        ),
      ],
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      height: bottomHeight,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Icon(
              Icons.favorite_border,
              size: leftIconSize,
              color: leftIconColor,
            )),
            Expanded(
                child: Icon(
              Icons.favorite,
              size: rightIconSize,
              color: rightIconColor,
            ))
          ],
        ),
      ),
    );
  }
}
