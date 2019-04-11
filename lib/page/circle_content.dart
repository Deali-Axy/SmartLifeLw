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
              leading: Image.network('http://lorempixel.com/200/200/'),
              title: Text('名称'),
              subtitle: Text('2019-04-10 17:18'),
            ),
            Card(),
          ],
        ),
      ),
    );
  }
}
