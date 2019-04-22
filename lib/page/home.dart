import 'package:flutter/material.dart';
import 'package:smart_life_lw/config.dart' as Config;
import 'package:smart_life_lw/widgets.dart';
import 'package:smart_life_lw/widget/weather_card.dart';
import 'package:smart_life_lw/widget/news_card.dart';
import 'package:smart_life_lw/widget/hitokoto_card.dart';
import 'package:smart_life_lw/utils/toast.dart';

class AppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _AppPage();
}

class _AppPage extends StatefulWidget {
  _AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<_AppPage> {
  BuildContext _context;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  double progress = 0.0;
  ScrollController _scrollController;

  @override
  void initState() {
    var userid = Config.GlobalConfig.userId;
    if (Config.GlobalConfig.isLogin)
      print('已登录');
    else
      print('未登录！');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    // 滚动到底部
    _scrollController?.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('汇智Life ${Config.GlobalConfig.focusMode ? '(专注时间)' : ''}'),
      ),
      drawer: HomeDrawer(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              WeatherCard(),
              HitokotoCard(),
              NewsCard(
                title: '自己想做的事情就要坚持下去',
                summary: '不要在意别人的眼光，别人的意见只是让你参考的，自己心里想的才是最重要的，别给自己的人生留遗憾!',
                picUrl:
                    'https://yangchengsen.oss-cn-shenzhen.aliyuncs.com/Picture4.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
