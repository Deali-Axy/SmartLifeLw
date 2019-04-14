import 'package:flutter/material.dart';
import 'package:smart_life_lw/config.dart';
import 'package:smart_life_lw/network/circle_post.dart';
import 'package:smart_life_lw/page/circle_content.dart';

/// todo 定义新的post类
/// todo 使用map方法把posts列表导出
/// todo 接上后台的接口
class SmartCircle extends StatefulWidget {
  @override
  _SmartCircleState createState() => _SmartCircleState();
}

class _SmartCircleState extends State<SmartCircle> {
  BuildContext _context;

  var circlePosts = List<CirclePost>();

  _SmartCircleState() {
    _refresh();
  }

  _refresh() async {
    circlePosts = await CirclePostUtils.getPosts(GlobalConfig.selectedCircle);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    _refresh();
                  })
            ],
            title: Text('${GlobalConfig.selectedCircleName}的圈子',
                style: TextStyle(color: Colors.black87)),
            backgroundColor: Theme.of(context).accentColor,
            expandedHeight: 220.0,
            flexibleSpace: FlexibleSpaceBar(
//              background: Image.network(
//                  'http://lorempixel.com/320/213/sports?time=${DateTime.now().toString()}',
//                  fit: BoxFit.cover),
              background: Image.asset('images/food06.jpeg', fit: BoxFit.cover),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              circlePosts.map((post) {
                return _buildItem(post);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(CirclePost post) {
    return Card(
      child: ListTile(
        leading: Image(
            image: NetworkImage('http://lorempixel.com/45/45?id=${post.id}')),
        title: Text(post.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(post.biography),
            Text(post.time, style: TextStyle(fontSize: 10)),
          ],
        ),
        onTap: () async {
          var comments = await CirclePostUtils.getComments(post.id);

          Navigator.push(
            _context,
            MaterialPageRoute(
                builder: (context) =>
                    SmartCircleContent(post: post, comments: comments)),
          );
        },
      ),
    );
  }
}
