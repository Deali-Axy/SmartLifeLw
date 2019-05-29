import 'package:flutter/material.dart';
import 'package:smart_life_lw/config.dart';
import 'package:smart_life_lw/routes.dart';

class ChoosePeoples extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChoosePeoplesState();
}

class _ChoosePeoplesState extends State<ChoosePeoples> {
  BuildContext _context;
  int _groupValue = 0;
  List circleInfo = [
    {'name': '学生', 'summary': '提升一分，干掉千人'},
    {'name': '青年上班族', 'summary': '奋斗在工作岗位的少年们吐槽工作琐事'},
    {'name': '创业青年', 'summary': '为远方田野努力奋斗的青年'},
    {'name': '恋爱girl', 'summary': '倾诉恋爱中的点点滴滴'},
    {'name': '摄影er', 'summary': '爱好摄影的人们分享自己的作品'},
    {'name': '电子发烧友', 'summary': '爱好鼓捣电子设备的人们'},
//    {'name': '看球学生', 'summary': '交流上学途中如何权衡球赛和学习'},
//    {'name': '互联网程序员', 'summary': '从事程序开发、程序维护的专业人员的吐槽圈子'},
  ];

  _ChoosePeoplesState() {
    _groupValue = GlobalConfig.selectedCircle - 1;
  }

  void _radioChange(value) {
    setState(() => _groupValue = value);
    GlobalConfig.selectedCircle = value + 1;
    GlobalConfig.selectedCircleName = circleInfo[value]['name'];
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
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView(
            children: circleInfo.map((dict) {
              return RadioListTile(
                value: circleInfo.indexOf(dict),
                groupValue: _groupValue,
                onChanged: _radioChange,
                title: Text(dict['name']),
                subtitle: Text(dict['summary']),
                secondary: Icon(Icons.account_circle),
                controlAffinity: ListTileControlAffinity.trailing,
                activeColor: Colors.redAccent,
              );
            }).toList(),
          ),
        );
      }),
    );
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      print('选择群体下拉刷新');
    });
  }
}
