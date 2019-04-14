import 'package:flutter/material.dart';
import 'routes.dart';

/// 文字图标混合按钮
class TextIconButton extends StatelessWidget {
  IconData _icon;
  String _text;

  TextIconButton({@required IconData icon, @required String text}) {
    _icon = icon;
    _text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 60,
        width: Theme.of(context).textTheme.display1.fontSize * 1.1 + 90,
      ),
      alignment: Alignment.center,
//      color: Colors.teal.shade700,
      child: Column(
        children: <Widget>[
          Icon(
            _icon,
            size: 50,
            color: Colors.blue,
          ),
          Text(
            _text,
            style: TextStyle(fontSize: 30, color: Colors.blue),
          )
        ],
      ),
    );
  }
}

/// 简单分割线
class SimpleDivider extends StatelessWidget {
  double _height = 0;
  double _width = 0;

  SimpleDivider({@required double height, double width}) {
    _height = height;
    _width = width;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
    );
  }
}

/// 首页抽屉
class HomeDrawer extends StatelessWidget {
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

    return Drawer(
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
  }
}
