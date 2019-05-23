import 'package:flutter/material.dart';
import 'package:smart_life_lw/widgets.dart';
import 'package:smart_life_lw/config.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Resource.title)),
      body: _buildMyPlan(context),
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
                  _buildTaskItem(context, true, '整理读书笔记 ', 3),
                  _buildTaskItem(context, true, '学英语', 2),
                  _buildTaskItem(context, false, '专业学习', 1),
                  _buildTaskItem(context, false, '艺术鉴赏', 4),
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

  Widget _buildTaskItem(
      BuildContext context, bool finish, String content, int star) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
          height: 35,
          child: Checkbox(
            value: finish,
            onChanged: (value) {},
            activeColor: Color.fromARGB(255, 74, 144, 226),
          ),
        ),
        SimpleDivider(height: 0, width: 5),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 112, 111, 111),
            ),
          ),
        ),
        for (var i = 0; i < star; i++)
          Icon(Icons.star, color: Color.fromARGB(255, 245, 166, 35)),
        for (var i = 0; i < 4 - star; i++)
          Icon(Icons.star_border, color: Color.fromARGB(140, 245, 166, 35)),
      ],
    );
  }
}

abstract class _Dialogs{

}
