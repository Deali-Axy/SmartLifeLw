import 'package:flutter/material.dart';
import 'config.dart' as Config;
import 'page/choose_labels.dart';
import 'page/choose_peoples.dart';
import 'page/chat.dart';
import 'page/circle.dart';
import 'page/circle_content.dart';
import 'page/focus_time.dart';
import 'package:smart_life_lw/network/weather.dart';
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
        iconTheme: new IconThemeData(
          color: Colors.grey[700],
        ),
        hintColor: Colors.grey[400],
      ),
      home: _AppHome(),
      routes: {
        UIRoute.chooseLabels: (context) => ChooseLabels(),
        UIRoute.choosePeoples: (context) => ChoosePeoples(),
        UIRoute.chat: (context) => Chat(),
        UIRoute.circle: (context) => SmartCircle(),
        UIRoute.circle_content: (context) => SmartCircleContent(),
        UIRoute.focusTime: (context) => FocusTime(),
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
  WeatherInfo _weatherInfo =
      WeatherInfo(summary: '等待刷新', iconName: '', temperature: 80);

  _getWeather() async {
    _weatherInfo = await WeatherUtils.getWeather();
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
              Navigator.pushNamed(context, UIRoute.chooseLabels);
            },
          ),
          ListTile(
            title: Text('选择群体'),
            leading: new CircleAvatar(
              child: new Icon(Icons.people),
            ),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.choosePeoples);
            },
          ),
          ListTile(
            title: Text('专注时间'),
            leading: new CircleAvatar(
              child: new Icon(Icons.timer),
            ),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.focusTime);
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
        title: Text('汇智Life'),
      ),
      drawer: drawer,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Card(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Image.asset(
                      'images/weather/${_weatherInfo.iconName}.png',
                      fit: BoxFit.fitHeight,
                      height: 50,
                    ),
                    title: Text(
                        '湛江天气：${_weatherInfo.temperature.roundToDouble()} ℃'),
                    subtitle: Text(_weatherInfo.summary),
                    trailing: IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => _getWeather()),
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network('http://lorempixel.com/400/400/'),
                      Divider(height: 10),
                      Text('资讯标题12', style: TextStyle(fontSize: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.favorite_border, size: 30),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.favorite,
                                  color: Colors.pink, size: 30),
                              onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
