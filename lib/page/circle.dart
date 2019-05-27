import 'package:flutter/material.dart';
import 'package:smart_life_lw/config.dart';
import 'package:smart_life_lw/network/circle_post.dart';
import 'package:smart_life_lw/page/circle_content.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:smart_life_lw/routes.dart';
import 'package:smart_life_lw/widget/avatar.dart';

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
  void initState() {
    _refresh();
    setState(() {});
    print('更新页面');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    _refresh();
                  })
            ],
            title: GestureDetector(
              child: Row(
                children: <Widget>[
                  Text('${GlobalConfig.selectedCircleName}的圈子',
                      style: TextStyle(color: Colors.black87)),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, UIRoute.choose_peoples);
              },
            ),
            backgroundColor: Theme.of(context).accentColor,
            expandedHeight: 200.0,
            flexibleSpace: _buildFlexibleSpaceBar(context),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              circlePosts.map((p) {
                return _buildItem(p);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlexibleSpaceBar(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: <Widget>[
          Image.asset(
            'images/food06.jpeg',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Container(
            padding: EdgeInsets.only(top: 190, left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(GroovinMaterialIcons.message_bulleted),
                Text('帖子数：${circlePosts.length}')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
    );
  }

  Widget _buildItem(CirclePost post) {
    return Card(
      child: ListTile(
        leading: CppAvatar(
          imageUrl: 'http://lorempixel.com/40/40?id=${post.id}',
        ),
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
