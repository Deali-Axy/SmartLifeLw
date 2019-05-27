import 'package:flutter/material.dart';
import 'package:smart_life_lw/network/schedule.dart';
import 'package:smart_life_lw/widget/dialog/task_edit.dart';
import 'package:smart_life_lw/widgets.dart';
import 'package:smart_life_lw/config.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var _taskList = {
    '整理读书笔记': Task(completed: true, event: '整理读书笔记', weight: 3),
    '学英语': Task(completed: true, event: '学英语', weight: 2),
    '艺术鉴赏': Task(completed: false, event: '艺术鉴赏', weight: 4),
    '专业学习': Task(completed: false, event: '专业学习', weight: 1),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Resource.title)),
      body: ListView(
        children: <Widget>[_buildMyPlan(context)],
      ),
      floatingActionButton: _buildFloatButton(context),
    );
  }

  Widget _buildFloatButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.edit),
      onPressed: () {
        TaskEditDialog.show(context, TaskEditDialogAction.add);
      },
    );
  }

  Widget _buildMyPlan(BuildContext context) {
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
              '我的计划',
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
                  Text(
                    '专注事情',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                  for (var task in _taskList.values)
                    _buildTaskItem(context, task),
                  Text(
                    '计划表',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
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
                _taskList[task.event].completed = value;
              });
            },
            activeColor: Color.fromARGB(255, 74, 144, 226),
          ),
        ),
        SimpleDivider(height: 0, width: 5),
        Expanded(
          child: GestureDetector(
            child: Text(
              task.event,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 112, 111, 111),
              ),
            ),
            onTap: () {
              TaskEditDialog.show(
                context,
                TaskEditDialogAction.update,
                task: task,
              );
            },
          ),
        ),
        for (var i = 0; i < task.weight; i++)
          Icon(Icons.star, color: Color.fromARGB(255, 245, 166, 35)),
        for (var i = 0; i < 4 - task.weight; i++)
          Icon(Icons.star_border, color: Color.fromARGB(140, 245, 166, 35)),
      ],
    );
  }
}
