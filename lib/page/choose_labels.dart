import 'package:flutter/material.dart';

class ChooseLabels extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _Page();
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<_Page> {
  BuildContext _context;
  var _checkboxValue = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择标签～'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.pop(_context);
              })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        _context = context;
        return ListView(
          children: <Widget>[
            CheckboxListTile(
              value: _checkboxValue[0],
              onChanged: (value) => setState(() => _checkboxValue[0] = value),
              title: new Text('互联网'),
              subtitle: Text('连接全世界几十亿个设备，形成逻辑上的单一巨大国际网络'),
              secondary: Icon(Icons.settings_ethernet),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.red,
            ),
            CheckboxListTile(
              value: _checkboxValue[1],
              onChanged: (value) => setState(() => _checkboxValue[1] = value),
              title: new Text('NBA'),
              subtitle: Text('美国职业篮球联赛，世界顶级的篮球联赛，拥有詹姆斯，科比等顶级球星'),
              secondary: Icon(Icons.spa),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.red,
            ),
            CheckboxListTile(
              value: _checkboxValue[2],
              onChanged: (value) => setState(() => _checkboxValue[2] = value),
              title: new Text('英超'),
              subtitle: Text('英格兰足球超级联赛，C罗等顶级球星曾在这效力'),
              secondary: Icon(Icons.fastfood),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.red,
            ),
            CheckboxListTile(
              value: _checkboxValue[3],
              onChanged: (value) => setState(() => _checkboxValue[3] = value),
              title: new Text('小米'),
              subtitle: Text('一家专注于高端智能手机、互联网电视以及智能家居生态链建设的创新型科技企业'),
              secondary: Icon(Icons.phone_android),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.red,
            ),
            CheckboxListTile(
              value: _checkboxValue[4],
              onChanged: (value) => setState(() => _checkboxValue[4] = value),
              title: new Text('创业'),
              subtitle: Text('一种实现自我价值的劳动、行为、商业方式'),
              secondary: Icon(Icons.business),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.red,
            ),
            CheckboxListTile(
              value: _checkboxValue[5],
              onChanged: (value) => setState(() => _checkboxValue[5] = value),
              title: new Text('高考'),
              subtitle: Text('学生通往大学的一门重要考试'),
              secondary: Icon(Icons.work),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.red,
            ),
            CheckboxListTile(
              value: _checkboxValue[6],
              onChanged: (value) => setState(() => _checkboxValue[6] = value),
              title: new Text('PHP'),
              subtitle: Text('世界上最好的编程语言～'),
              secondary: Icon(Icons.code),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.red,
            ),
            CheckboxListTile(
              value: _checkboxValue[7],
              onChanged: (value) => setState(() => _checkboxValue[7] = value),
              title: new Text('萨克斯'),
              subtitle: Text('一种低音乐器'),
              secondary: Icon(Icons.music_video),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.red,
            ),
          ],
        );
      }),
    );
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      print('选择标签下拉刷新');
    });
  }
}
