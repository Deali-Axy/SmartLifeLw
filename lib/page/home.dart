import 'package:flutter/material.dart';
import 'package:smart_life_lw/config.dart' as Config;
import 'package:smart_life_lw/widgets.dart';

import 'package:smart_life_lw/extends/fake/home.dart';

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

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('汇智Life ${Config.GlobalConfig.focusMode ? '(专注时间)' : ''}'),
      ),
      drawer: HomeDrawer(),
      body: FakeHome(),
    );
  }
}
