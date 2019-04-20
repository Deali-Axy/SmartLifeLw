import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:smart_life_lw/routes.dart';
import 'package:smart_life_lw/widgets.dart';
import 'package:smart_life_lw/network/circle_post.dart';
import 'package:smart_life_lw/config.dart';
import 'package:smart_life_lw/page/circle_content.dart';

enum UserMenuEnum {
  search_post,
  choose_labels,
  edit_profile,
  share_user,
  block_user
}

List userMenuList = [
  {
    'value': UserMenuEnum.search_post,
    'text': '搜索帖子',
  },
  {
    'value': UserMenuEnum.choose_labels,
    'text': '选择标签',
  },
  {
    'value': UserMenuEnum.edit_profile,
    'text': '编辑资料',
  },
  {
    'value': UserMenuEnum.share_user,
    'text': '分享用户',
  },
  {
    'value': UserMenuEnum.block_user,
    'text': '屏蔽用户',
  },
];

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  var _tabs = <Tab>[
    Tab(text: '关于'),
    Tab(text: '标签'),
    Tab(text: '圈子'),
    Tab(text: '相册'),
  ];

  var _circlePosts = List<CirclePost>();
  var _pictures = List<String>();
  var _selectionMenu;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _refreshCirclePosts();
    _refreshPictures();
    super.initState();
  }

  Future<void> _refreshCirclePosts() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('圈子列表下拉刷新');
    });
    _circlePosts = await CirclePostUtils.getPosts(GlobalConfig.selectedCircle);
    setState(() {});
  }

  Future<void> _refreshPictures() async {
    await Future.delayed(Duration(seconds: 3), () {
      print('相册下拉刷新');
    });
    _pictures.clear();
    for (int i = 0; i < 12; i++) {
      _pictures.add('http://lorempixel.com/200/200/?id=$i');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              _buildPopupMenuButton(),
            ],
            backgroundColor: Colors.white,
            expandedHeight: 240,
            flexibleSpace: _buildFlexibleSpaceBar(),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: _tabs,
              indicatorColor: Colors.pinkAccent,
              labelColor: Colors.purpleAccent,
              unselectedLabelColor: Colors.black,
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
                controller: _tabController,
                children: _tabs.map((tab) {
                  return _buildTabView(tab.text);
                }).toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupMenuButton() {
    return PopupMenuButton<UserMenuEnum>(
      icon: Icon(GroovinMaterialIcons.menu, color: Colors.white),
      onSelected: (UserMenuEnum result) {
        setState(() {
          _selectionMenu = result;
        });
        switch (result) {
          case UserMenuEnum.search_post:
            // TODO: Handle this case.
            break;
          case UserMenuEnum.choose_labels:
            Navigator.pushNamed(context, UIRoute.choose_labels);
            break;
          case UserMenuEnum.edit_profile:
            Navigator.pushNamed(context, UIRoute.edit_profile);
            break;
          case UserMenuEnum.share_user:
            // TODO: Handle this case.
            break;
          case UserMenuEnum.block_user:
            // TODO: Handle this case.
            break;
        }
      },
      itemBuilder: (BuildContext context) => userMenuList
          .map((menuDict) => PopupMenuItem<UserMenuEnum>(
                value: menuDict['value'],
                child: Text(menuDict['text']),
              ))
          .toList(),
    );
  }

  Widget _buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      background: Stack(
        children: <Widget>[
          Image.asset(
            'images/food02.jpeg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: 180,
          ),
          Container(
            padding: EdgeInsets.only(top: 140, left: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage:
                      NetworkImage('http://lorempixel.com/100/100/'),
                  radius: 35.0,
                ),
                SimpleDivider(height: 0, width: 10),
                Text('用户名', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabView(String key) {
    switch (key) {
      case '关于':
        return Align(
          alignment: Alignment.topLeft,
          child: ListView(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            children: <Widget>[
              Text('签名', style: TextStyle(color: Colors.grey[600])),
              SimpleDivider(height: 5),
              Text('温柔正确的人总是难以生存，因为这世界既不温柔，也不正确'),
              SimpleDivider(height: 20),
              Text('所在地', style: TextStyle(color: Colors.grey[600])),
              SimpleDivider(height: 5),
              Text('广东 广州'),
              SimpleDivider(height: 20),
              Text('性别', style: TextStyle(color: Colors.grey[600])),
              SimpleDivider(height: 5),
              Text('男'),
              SimpleDivider(height: 20),
              Text('注册时间', style: TextStyle(color: Colors.grey[600])),
              SimpleDivider(height: 5),
              Text('2019-04-17'),
              SimpleDivider(height: 20),
              Text('手机号码', style: TextStyle(color: Colors.grey[600])),
              SimpleDivider(height: 5),
              Text('13432886642'),
            ],
          ),
        );
      case '标签':
        return ListView(
          children: <Widget>[
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: Text('AB'),
              ),
              label: Text('Aaron Burr'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: Text('AB'),
              ),
              label: Text('Aaron Burr'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: Text('AB'),
              ),
              label: Text('Aaron Burr'),
            ),
          ],
        );
      case '圈子':
        return RefreshIndicator(
            child: ListView(
              padding: EdgeInsets.all(5),
              children: _circlePosts.map((post) {
                return Card(
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.biography),
                    onTap: () async {
                      var comments = await CirclePostUtils.getComments(post.id);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => SmartCircleContent(
                                  post: post, comments: comments)));
                    },
                  ),
                );
              }).toList(),
            ),
            onRefresh: _refreshCirclePosts);
      case '相册':
        return RefreshIndicator(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(5.0),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              crossAxisCount: 3,
              children: _pictures.map((picUrl) {
                return Image.network(picUrl);
              }).toList(),
            ),
            onRefresh: _refreshPictures);
      default:
        return Center(child: Text(key));
    }
  }
}
