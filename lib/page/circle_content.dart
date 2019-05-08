import 'package:flutter/material.dart';
import 'package:smart_life_lw/network/circle_post.dart';
import 'package:smart_life_lw/widget/avatar.dart';

class SmartCircleContent extends StatefulWidget {
  final CirclePost post;
  final List<CirclePostComment> comments;

  SmartCircleContent({Key key, @required this.post, @required this.comments})
      : super(key: key);

  @override
  _SmartCircleContentState createState() =>
      _SmartCircleContentState(post: post, comments: comments);
}

class _SmartCircleContentState extends State<SmartCircleContent> {
  CirclePost _post;
  List<CirclePostComment> _comments = List();

  List<Widget> _widgets = List();

  _SmartCircleContentState({@required post, @required comments}) {
    _post = post;
    _comments = comments;
    _widgets = [
      ListTile(
        leading:
            CppAvatar(imageUrl: 'http://lorempixel.com/40/40?id=${_post.id}'),
        title: Text(_post.nickname),
        subtitle: Text(_post.time),
      ),
      ListTile(
        title: Text(_post.title),
        subtitle: Text(_post.biography),
      ),
      Divider(height: 10),
    ];

    for (var i = 0; i < _comments.length; i++) {
      var item = _comments[i];
      _widgets.add(_SimpleComment(
        username: item.nickname,
        time: item.time,
        content: item.biography,
        index: i + 1,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('帖子详情'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: null)
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: _widgets,
        ),
      ),
    );
  }
}

class _SimpleComment extends StatelessWidget {
  final String username;
  final String time;
  final String content;
  final int index;

  _SimpleComment({this.username, this.time, this.content, this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading:
              CppAvatar(imageUrl: 'http://lorempixel.com/40/40?id=$username'),
          title: Text(username),
          subtitle: Text(time),
          trailing: Text('$index楼'),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(content),
        ),
        Divider(height: 10),
      ],
    );
  }
}
