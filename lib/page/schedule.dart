import 'package:flutter/material.dart';
import 'package:smart_life_lw/config.dart';
import 'package:smart_life_lw/network/schedule.dart';
import 'package:smart_life_lw/utils/toast.dart';
import 'package:smart_life_lw/widget/dialog/task_edit.dart';
import 'package:smart_life_lw/widget/dialog/plan_edit.dart';
import 'package:smart_life_lw/widgets.dart';

class SchedulePage extends StatefulWidget {
  final List<Tab> tabs = <Tab>[
    Tab(text: '计划表'),
    Tab(text: '专注事情'),
  ];

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  var _taskList = {};
  var _planList = {};

  List<Task> get tasks {
    var list = <Task>[];
    for (var item in _taskList.values) {
      list.add(item);
    }
    return list;
  }

  set tasks(List<Task> values) {
    _taskList.clear();
    for (var item in values) {
      print(item);
      _taskList[item.id] = item;
    }
  }

  List<Plan> get plans {
    var list = <Plan>[];
    for (var item in _planList.values) {
      list.add(item);
    }
    return list;
  }

  set plans(List<Plan> values) {
    _planList.clear();
    for (var item in values) {
      print(item);
      _planList[item.id] = item;
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: widget.tabs.length, vsync: this);
    var tasks = <Task>[
      Task(completed: true, event: '整理读书笔记', weight: 3),
      Task(completed: true, event: '学英语', weight: 2),
      Task(completed: false, event: '艺术鉴赏', weight: 4),
      Task(completed: false, event: '专业学习', weight: 1),
    ];
    var plans = <Plan>[
      Plan(startTime: '7:30', endTime: '8:00', event: '起床、吃早餐'),
      Plan(startTime: '8:30', endTime: '9:30', event: '专注时间'),
      Plan(startTime: '11:30', endTime: '12:30', event: '午饭午休'),
      Plan(startTime: '17:30', endTime: '22:30', event: '专注时间'),
      Plan(startTime: '22:30', endTime: '23:30', event: '上课'),
    ];
    this.tasks = tasks;
    this.plans = plans;
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tabBar = TabBar(
      controller: _tabController,
      isScrollable: true,
      labelStyle: TextStyle(fontSize: 16),
      tabs: widget.tabs.map((tab) => tab).toList(),
    );

    var tabBarView = TabBarView(
      controller: _tabController,
      children: widget.tabs.map((tab) => _buildTabView(context, tab)).toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('我的计划'),
        actions: <Widget>[_buildRefreshButton(context)],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 38,
            child: tabBar,
          ),
          Expanded(child: tabBarView),
        ],
      ),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () async {
        switch (_tabController.index) {
          case 0: // 计划表
            Toast.show(context, '正在同步计划表~');
            break;
          case 1: // 专注事情
            Toast.show(context, '正在同步专注事情~');
            break;
        }
        var response = await ScheduleUtils.updateDailySchedule(
          GlobalConfig.userId,
          _taskList.values.toList(),
          _planList.values.toList(),
        );
        var planList =
            await ScheduleUtils.getTodaySchedule(GlobalConfig.userId);
        if (planList.isNotEmpty) setState(() => this.plans = planList);
        Toast.show(context, response.info);
      },
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        switch (_tabController.index) {
          case 0:
            var result =
                await PlanEditDialog.show(context, PlanEditDialogAction.add);
            if (result != null) {
              print('recieve plan: ${result.action.toString()}');
              if (result.action == PlanEditDialogAction.add)
                setState(() {
                  _planList[result.plan.id] = result.plan;
                });
            }
            break;
          case 1:
            if (_taskList.length < 4) {
              var result =
                  await TaskEditDialog.show(context, TaskEditDialogAction.add);
              if (result != null) if (result.action == TaskEditDialogAction.add)
                setState(() {
                  _taskList[result.task.id] = result.task;
                });
            } else
              Toast.show(context, '最多只能添加4个专注事情！');
            break;
        }
      },
    );
  }

  Widget _buildTabView(BuildContext context, Tab tab) {
    switch (tab.text) {
      case '计划表':
        return ListView(children: <Widget>[_buildPlanForm(context)]);
      case '专注事情':
        return ListView(children: <Widget>[_buildTask(context)]);
      default:
        return Center();
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
                  for (var plan in _getSortedPlanList())
                    _buildPlanItem(context, plan),
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

  Widget _buildPlanItem(BuildContext context, Plan plan) {
    var row = Row(
//      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          plan.startTime,
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 112, 111, 111),
          ),
        ),
        SimpleDivider(height: 0, width: 6),
        Expanded(
          child: GestureDetector(
            child: Text(
              plan.event,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 112, 111, 111),
              ),
            ),
            onTap: () async {
              var result = await PlanEditDialog.show(
                context,
                PlanEditDialogAction.update,
                plan: plan,
              );
              if (result.action == PlanEditDialogAction.delete)
                setState(() {
                  _planList.remove(result.plan.id);
                });
              if (result.action == PlanEditDialogAction.update)
                setState(() {
                  _planList[result.plan.id] = result.plan;
                });
            },
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
                _taskList[task.id].completed = value;
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
            onTap: () async {
              var result = await TaskEditDialog.show(
                  context, TaskEditDialogAction.update,
                  task: task);
              switch (result.action) {
                case TaskEditDialogAction.add:
                  _taskList[result.task.id] = result.task;
                  break;
                case TaskEditDialogAction.update:
                  _taskList[result.task.id] = result.task;
                  break;
                case TaskEditDialogAction.delete:
                  setState(() {
                    _taskList.remove(result.task.id);
                  });
                  break;
              }
              setState(() {});
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

  /// 获取排序后的计划表
  List<Plan> _getSortedPlanList() {
    var tempList = List<Plan>();
    // 拷贝 _planList 里的所有对象
    for (var plan in _planList.values) {
      tempList.add(plan);
    }
//    tempList.sort((p1, p2) => p1.id - p2.id);
    return tempList;
  }
}
