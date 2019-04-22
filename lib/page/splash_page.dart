import 'package:flutter/material.dart';
import 'dart:async';
import 'package:smart_life_lw/routes.dart';
import 'package:smart_life_lw/config.dart';
import 'package:smart_life_lw/page/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Color _borderColor = Colors.white;
  String _version;

  _SplashState() {
    _getVersion();
  }

  _getVersion() async {
    _version = (await GlobalConfig.packageInfo).version;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "images/launch.png",
            fit: BoxFit.fill,
          ),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.fromLTRB(0, 50, 10, 0),
            child: OutlineButton(
              child: Text(
                "跳过",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              // StadiumBorder椭圆的形状
              shape: StadiumBorder(side: BorderSide(color: Colors.white)),
              onPressed: () {
                go2HomePage();
              },
              color: _borderColor,
              disabledBorderColor: _borderColor,
              highlightedBorderColor: _borderColor,
              disabledTextColor: _borderColor,
              highlightColor: _borderColor,
              splashColor: _borderColor,
              textColor: _borderColor,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '汇智Life',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                Text(
                  '版本：$_version',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    countDown();
    super.initState();
  }

  // 倒计时
  void countDown() {
    var _duration = new Duration(seconds: 3);
    Future.delayed(_duration, go2HomePage);
  }

  void go2HomePage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
      return AppHome();
    }));
  }
}
