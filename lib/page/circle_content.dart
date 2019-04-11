import 'package:flutter/material.dart';

class SmartCircleContent extends StatefulWidget {
  @override
  _SmartCircleContentState createState() => _SmartCircleContentState();
}

class _SmartCircleContentState extends State<SmartCircleContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('内容标题'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: null)
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Image.network('http://lorempixel.com/40/40/'),
              title: Text('用户名称'),
              subtitle: Text('2019-04-10 17:18'),
            ),
            ListTile(
              title: Text('内容标题。。。。'),
              subtitle: Text('内容内容'),
            ),
            Divider(
              height: 10,
            ),
            _SimpleComment(username: '用户名',time: '2019-04-10 17:00',content: '评论内容',)
          ],
        ),
      ),
    );
  }
}

class _SimpleComment extends StatelessWidget {
  String username;
  String time;
  String content;

  _SimpleComment({this.username, this.time, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: Image.network('http://lorempixel.com/40/40/'),
          title: Text(username),
          subtitle: Text(time),
          trailing: Text('1楼'),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(content),
        ),
      ],
    );
  }
}
