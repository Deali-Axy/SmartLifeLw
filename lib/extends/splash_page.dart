import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Color borderColor = Colors.white;

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
            padding: EdgeInsets.fromLTRB(0.0, 50, 10, 0.0),
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
              color: borderColor,
              disabledBorderColor: borderColor,
              highlightedBorderColor: borderColor,
              disabledTextColor: borderColor,
              highlightColor: borderColor,
              splashColor: borderColor,
              textColor: borderColor,
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
    Navigator.pop(context);
  }
}
