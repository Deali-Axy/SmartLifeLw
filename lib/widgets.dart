import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smart_life_lw/extends/sharedelement/shared_element_shop.dart';
import 'package:smart_life_lw/page/new_home.dart';
import 'package:smart_life_lw/page/shop.dart';
import 'package:smart_life_lw/page/shopDetails.dart';
import 'package:smart_life_lw/page/splash_page.dart';
import 'package:smart_life_lw/utils/toast.dart';
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
    var userInfo = GlobalConfig.userInfo;

    print(userInfo.toMap());

    Widget header = DrawerHeader(
      padding: EdgeInsets.zero,
      /* padding置为0 */
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
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
                      // 恶心的双层三元表达式嵌套
                      backgroundImage: NetworkImage(userInfo == null
                          ? 'http://lorempixel.com/100/100/'
                          : userInfo.portrait == null
                              ? 'http://lorempixel.com/100/100/'
                              : userInfo.portrait),
                      radius: 35.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // 水平方向左对齐
                        mainAxisAlignment: MainAxisAlignment.center,
                        // 竖直方向居中
                        children: <Widget>[
                          Text(
                            userInfo.username,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          Text(
                            userInfo.signature == null
                                ? '我们所过的每个平凡的日常，也许就是连续发生的奇迹。'
                                : userInfo.signature,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  if (GlobalConfig.isLogin)
                    Navigator.pushNamed(context, UIRoute.user_home);
                  else
                    Navigator.pushNamed(context, UIRoute.login_page);
                },
              ),
            ),
          ),
        ],
      ),
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
              Navigator.of(context).pop();
              Navigator.pushNamed(context, UIRoute.focus_time);
            },
          ),
          ListTile(
            title: Text('我的任务'),
            leading: CircleAvatar(
              child: Icon(Icons.list),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, UIRoute.task);
            },
          ),
          ListTile(
            title: Text('呼叫Life'),
            leading: CircleAvatar(
              child: Icon(Icons.chat),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, UIRoute.chat);
            },
          ),
          ListTile(
            title: Text('汇智圈子'),
            leading: CircleAvatar(child: Icon(Icons.cloud_circle)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, UIRoute.circle);
            },
          ),
          ListTile(
            title: Text('Starter'),
            leading: CircleAvatar(child: Icon(Icons.star)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, UIRoute.starter);
            },
          ),
          Divider(),
//          ListTile(
//            title: Text('new home'),
//            onTap: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (BuildContext context) {
//                    return NewHomePage();
//                  }));
//            },
//          ),
          ListTile(
            title: Text('商城'),
            leading: CircleAvatar(child: Icon(Icons.local_mall)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Myshop();
              }));
            },
          ),
          ListTile(
            title: Text('商品详情'),
            leading: CircleAvatar(child: Icon(Icons.shop)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ShopDetails();
              }));
            },
          ),
          ListTile(
            title: Text('检查更新'),
            leading: CircleAvatar(
              child: Icon(Icons.update),
            ),
            onTap: () {
              Toast.show(context, '您已经使用最新版本！');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('设置'),
            leading: CircleAvatar(
              child: Icon(Icons.settings),
            ),
            onTap: () {
              Toast.show(context, '开发中，请等待～');
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
