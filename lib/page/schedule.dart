import 'package:flutter/material.dart';
import 'package:smart_life_lw/network/schedule.dart';
import 'package:smart_life_lw/widget/dialog/task_edit.dart';
import 'package:smart_life_lw/widgets.dart';

class SchedulePage extends StatefulWidget {
  final List<Tab> tabs = <Tab>[
    Tab(text: '计划表'),
    Tab(text: '专注事情'),
  ];

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var _taskList = {
    '整理读书笔记': Task(completed: true, feEvent: '整理读书笔记', feWeight: 3),
    '学英语': Task(completed: true, feEvent: '学英语', feWeight: 2),
    '艺术鉴赏': Task(completed: false, feEvent: '艺术鉴赏', feWeight: 4),
    '专业学习': Task(completed: false, feEvent: '专业学习', feWeight: 1),
  };

  @override
  Widget build(BuildContext context) {
    var s = Scaffold(
      appBar: AppBar(title: Text('我的计划')),
    );

    return DefaultTabController(
      length: widget.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('我的计划'),
          bottom: TabBar(tabs: widget.tabs),
        ),
        body: TabBarView(
          children:
              widget.tabs.map((tab) => _buildTabView(context, tab)).toList(),
        ),
      ),
    );
  }

  Widget _buildTabView(BuildContext context, Tab tab) {
    switch (tab.text) {
      case '计划表':
        return ListView(children: <Widget>[_buildPlanForm(context)]);
      case '专注事情':
        return ListView(children: <Widget>[_buildTask(context)]);
    }
  }

  Widget _buildPlanForm(BuildContext context) {
    var card = Card(
      margin: EdgeInsets.fromLTRB(4, 10, 4, 8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0))), //设置圆角
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12, top: 6),
            child: Text(
              '在这里编辑您今天的计划',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 173, 174, 173),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(22, 5, 16, 20),
            child: Center(
              child: Column(
                children: <Widget>[
                  _buildPlanItem(context, '7:30', '起床、吃早餐'),
                  _buildPlanItem(context, '8:30', '专注时间'),
                  _buildPlanItem(context, '11:30', '午饭午休'),
                  _buildPlanItem(context, '14:30', '专注时间'),
                  _buildPlanItem(context, '17:30', '上课'),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return card;
  }

  Widget _buildTask(BuildContext context) {
    var card = Card(
      margin: EdgeInsets.fromLTRB(4, 10, 4, 8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0))), //设置圆角
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12, top: 6),
            child: Text(
              '您每天可以设置四件专注事情',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 173, 174, 173),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(22, 5, 16, 20),
            child: Center(
              child: Column(
                children: <Widget>[
                  for (var task in _taskList.values)
                    _buildTaskItem(context, task),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return card;
  }

  Widget _buildPlanItem(BuildContext context, String time, String content) {
    var row = Row(
//      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          time,
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 112, 111, 111),
          ),
        ),
        SimpleDivider(height: 0, width: 6),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 112, 111, 111),
          ),
        ),
      ],
    );

    return SizedBox(height: 35, child: row);
  }

  Widget _buildTaskItem(BuildContext context, Task task) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
          height: 35,
          child: Checkbox(
            value: task.completed,
            onChanged: (value) {
              setState(() {
                _taskList[task.feEvent].completed = value;
              });
            },
            activeColor: Color.fromARGB(255, 74, 144, 226),
          ),
        ),
        SimpleDivider(height: 0, width: 5),
        Expanded(
          child: GestureDetector(
            child: Text(
              task.feEvent,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 112, 111, 111),
              ),
            ),
            onTap: () {
              TaskEditDialog.show(context, task: task);
            },
          ),
        ),
        for (var i = 0; i < task.feWeight; i++)
          Icon(Icons.star, color: Color.fromARGB(255, 245, 166, 35)),
        for (var i = 0; i < 4 - task.feWeight; i++)
          Icon(Icons.star_border, color: Color.fromARGB(140, 245, 166, 35)),
      ],
    );
  }
}
