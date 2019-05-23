import 'package:flutter/material.dart';
import 'package:smart_life_lw/widget/weather_card.dart';
import 'package:smart_life_lw/widget/news_card.dart';
import 'package:smart_life_lw/widget/hitokoto_card.dart';
import 'package:smart_life_lw/utils/toast.dart';

class StarterPage extends StatefulWidget {
  @override
  _StarterPageState createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    // 滚动到底部
    _scrollController?.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    var container = Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          WeatherCard(),
          NewsCard(
            title: '自己想做的事情就要坚持下去',
            summary: '不要在意别人的眼光，别人的意见只是让你参考的，自己心里想的才是最重要的，别给自己的人生留遗憾!',
            picUrl:
                'https://yangchengsen.oss-cn-shenzhen.aliyuncs.com/Picture4.png',
          ),
          HitokotoCard(),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('汇智Starter')),
      body: container,
    );
  }
}
