import 'package:flutter/material.dart';

class ChoosePeoples extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChoosePeoplesState();
}

class _ChoosePeoplesState extends State<ChoosePeoples> {
  BuildContext _context;
  int _groupValue = 0;

  void _radioChange(value) {
    setState(() => _groupValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择群体～'),
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
            RadioListTile(
              value: 0,
              groupValue: _groupValue,
              onChanged: _radioChange,
              title: Text('学生'),
              subtitle: Text('提升一分，干掉千人'),
              secondary: Icon(Icons.book),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.redAccent,
            ),
            RadioListTile(
              value: 1,
              groupValue: _groupValue,
              onChanged: _radioChange,
              title: Text('青年上班族'),
              subtitle: Text('奋斗在工作岗位的少年们吐槽工作琐事'),
              secondary: Icon(Icons.business),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.redAccent,
            ),
            RadioListTile(
              value: 2,
              groupValue: _groupValue,
              onChanged: _radioChange,
              title: Text('恋爱girl'),
              subtitle: Text('倾诉恋爱中的点点滴滴'),
              secondary: Icon(Icons.favorite),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.redAccent,
            ),
            RadioListTile(
              value: 3,
              groupValue: _groupValue,
              onChanged: _radioChange,
              title: Text('迷茫boy'),
              subtitle: Text('当前生活没有了方向感，渴望点名未来的方向的明灯'),
              secondary: Icon(Icons.cloud),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.redAccent,
            ),
            RadioListTile(
              value: 4,
              groupValue: _groupValue,
              onChanged: _radioChange,
              title: Text('创业青年'),
              subtitle: Text('为远方田野努力奋斗的青年'),
              secondary: Icon(Icons.trending_up),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.redAccent,
            ),
            RadioListTile(
              value: 5,
              groupValue: _groupValue,
              onChanged: _radioChange,
              title: Text('摄影er'),
              subtitle: Text('爱好摄影的人们分享自己的作品'),
              secondary: Icon(Icons.camera),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.redAccent,
            ),
            RadioListTile(
              value: 6,
              groupValue: _groupValue,
              onChanged: _radioChange,
              title: Text('看球学生'),
              subtitle: Text('交流上学途中如何权衡球赛和学习'),
              secondary: Icon(Icons.spa),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.redAccent,
            ),
            RadioListTile(
              value: 7,
              groupValue: _groupValue,
              onChanged: _radioChange,
              title: Text('电子发烧友'),
              subtitle: Text('爱好鼓捣电子设备的人们'),
              secondary: Icon(Icons.games),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.redAccent,
            ),
            RadioListTile(
              value: 8,
              groupValue: _groupValue,
              onChanged: _radioChange,
              title: Text('互联网程序员'),
              subtitle: Text('从事程序开发、程序维护的专业人员的吐槽圈子'),
              secondary: Icon(Icons.code),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.redAccent,
            ),
          ],
        );
      }),
    );
  }
}
