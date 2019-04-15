import 'package:flutter/material.dart';
import 'package:smart_life_lw/widgets.dart';
import 'config.dart' as Config;
import 'page/choose_labels.dart';
import 'page/choose_peoples.dart';
import 'page/chat.dart';
import 'page/circle.dart';
import 'page/focus_time.dart';
import 'page/login.dart';
import 'package:smart_life_lw/widget/news_card.dart';
import 'package:smart_life_lw/widget/weather_card.dart';
import 'package:smart_life_lw/widget/hitokoto_card.dart';
import 'routes.dart';

main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.grey[50],
        scaffoldBackgroundColor: Colors.grey[50],
        dialogBackgroundColor: Colors.grey[50],
        primaryColorBrightness: Brightness.light,
        buttonColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        hintColor: Colors.grey[400],
      ),
      home: _AppHome(),
      routes: {
        UIRoute.chooseLabels: (context) => ChooseLabels(),
        UIRoute.choosePeoples: (context) => ChoosePeoples(),
        UIRoute.chat: (context) => Chat(),
        UIRoute.circle: (context) => SmartCircle(),
        UIRoute.focusTime: (context) => FocusTime(),
        UIRoute.login: (context) => LoginPage(),
      },
    );
  }
}

class _AppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _AppPage();
}

class _AppPage extends StatefulWidget {
  _AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<_AppPage> {
  double progress = 0.0;
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    // 滚动到底部
    _scrollController?.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    return Scaffold(
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
