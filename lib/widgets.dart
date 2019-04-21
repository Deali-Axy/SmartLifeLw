import 'dart:ui';
import 'package:flutter/material.dart';
import 'extends/splash_page.dart';
import 'routes.dart';
import 'config.dart';

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
      width: _width,
    );
  }
}

/// 首页抽屉
class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userInfo=GlobalConfig.userInfo;

    Widget header = DrawerHeader(
      padding: EdgeInsets.zero,
      /* padding置为0 */
      child: Stack(children: <Widget>[
        /* 用stack来放背景图片 */
        Opacity(
          opacity: 0.7,
          child: Image.asset(
            'images/food04.jpeg',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Align(
          /* 先放置对齐 */
          alignment: FractionalOffset.bottomLeft,
          child: Container(
            height: 70.0,
            margin: EdgeInsets.only(left: 12.0, bottom: 12.0),
            child: GestureDetector(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                /* 宽度只用包住子组件即可 */
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(userInfo.portrait),
                    radius: 35.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 水平方向左对齐
                      mainAxisAlignment: MainAxisAlignment.center, // 竖直方向居中
                      children: <Widget>[
                        Text(
                          userInfo.username,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        Text(
                          userInfo.signature,
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, UIRoute.user_home);
              },
            ),
          ),
        ),
      ]),
    );

    Widget userHeader = new UserAccountsDrawerHeader(
      accountName: Text('汇智用户'),
      accountEmail: Text('空山新雨后，天气晚来秋'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage('http://lorempixel.com/100/100/'),
        radius: 35.0,
      ),
      onDetailsPressed: () {
        Navigator.pushNamed(context, UIRoute.login_page);
      },
    );

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          header,
          ListTile(
            title: Text('专注时间'),
            leading: CircleAvatar(
              child: Icon(Icons.timer),
            ),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.focus_time);
            },
          ),
          ListTile(
            title: Text('呼叫Life'),
            leading: CircleAvatar(
              child: Icon(Icons.chat),
            ),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.chat);
            },
          ),
          ListTile(
            title: Text('汇智圈子'),
            leading: CircleAvatar(
              child: Icon(Icons.cloud_circle),
            ),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.circle);
            },
          ),
          Divider(),
          ListTile(
            title: Text('启动页'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Splash();
              }));
            },
          ),
          ListTile(
            title: Text('extend用户登录'),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.login_page);
            },
          ),
          ListTile(
            title: Text('extend用户注册'),
            onTap: () {
              Navigator.pushNamed(context, UIRoute.sign_up_page);
            },
          ),
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
