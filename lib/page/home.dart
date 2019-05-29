import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_life_lw/config.dart';
import 'package:smart_life_lw/routes.dart';
import 'package:smart_life_lw/utils/toast.dart';
import 'package:smart_life_lw/widgets.dart';
import 'package:smart_life_lw/network/schedule.dart';

class AppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _AppPage();
}

class _AppPage extends StatefulWidget {
  _AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<_AppPage> {
  BuildContext _context;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  Plan currentPlan;
  Task currentTask;
  var evaluateMsg = '赶紧刷新查看你的专注程度吧！';

  @override
  void initState() {
    var userid = GlobalConfig.userId;
    if (GlobalConfig.isLogin)
      print('已登录');
    else {
      print('未登录！');
      Future.delayed(Duration(seconds: 1), () {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('请登录后使用本App！'),
          action: SnackBarAction(
            label: '登录',
            onPressed: () {
              Navigator.pushNamed(_context, UIRoute.login_page);
            },
          ),
        ));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('汇智Life ${GlobalConfig.focusMode ? '(专注时间)' : ''}'),
        actions: <Widget>[_buildRefreshButton(context)],
      ),
      drawer: HomeDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildSchedule(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, UIRoute.schedule);
                },
                child: Text('我的计划', style: TextStyle(color: Colors.white)),
              ),
              SimpleDivider(height: 0, width: 10),
              _buildEvaluateButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEvaluateButton(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        var score = await _Dialogs.showEvaluate(context);
        Toast.show(context, '你选择了$score分');
        if (score != null) {
          var map =
              await ScheduleUtils.selfEvaluation(GlobalConfig.userId, score);
          _Dialogs.showResult(context, map['msg'], map['button']);
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(map['msg'])));
        }
      },
      child: Text('自我评价', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () async {
        Response response =
            await ScheduleUtils.getCurrentEvent(GlobalConfig.userId);
        if (response.code == 200) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('获取到新的任务！')));
          print(response.data);
          currentPlan = Plan.fromMap(response.data);
        } else if (response.code == -1) {
          currentPlan = null;
          currentTask = null;
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('当日计划全部完成！')));
        } else
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('刷新当前计划事项失败！')));
        setState(() {});
      },
    );
  }

  Widget _buildSchedule(BuildContext context) {
    var card = Card(
      margin: EdgeInsets.fromLTRB(4, 10, 4, 10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0))), //设置圆角
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12, top: 6),
            child: Text(
              '当前行程',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 173, 174, 173),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 64),
              child: Column(
                children: <Widget>[
                  Text(
                    currentPlan == null ? '当日计划已全部完成' : currentPlan.event,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                  SimpleDivider(height: 8),
                  Text(
                    currentPlan == null
                        ? '休息一下'
                        : '${currentPlan.startTime}-${currentPlan.endTime}',
                    style: TextStyle(
                      fontSize: 26,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                  SimpleDivider(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '你的专注程度比以前进步了',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 112, 111, 111),
                        ),
                      ),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                  SimpleDivider(height: 14),
                ],
              ),
            ),
          ),
          _buildInterruptControl(context),
        ],
      ),
    );

    return card;
  }

  Widget _buildInterruptControl(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              color: Color.fromARGB(255, 242, 223, 223),
              child: Column(
                children: <Widget>[
                  Text(
                    '中断行程',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 112, 111, 111),
                    ),
                  ),
                  Icon(
                    Icons.fingerprint,
                    size: 60,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      onLongPress: () {
        print('取消行程');
        _Dialogs.showCancel(context, _scaffoldKey);
      },
    );
  }
}

abstract class _Dialogs {
  static Future<void> showCancel(
      BuildContext context, GlobalKey<ScaffoldState> key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('是否确定'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('是否确定中断行程？'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                '确定中断',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                var result =
                    await ScheduleUtils.interruptEvent(GlobalConfig.userId);
                key.currentState.showSnackBar(SnackBar(content: Text(result)));
              },
            ),
            FlatButton(
              child: Text('再想想', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<int> showEvaluate(BuildContext context) {
    return showDialog<int>(
      context: context,
      builder: (context) {
        return new SimpleDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("本次专注时间结束", style: TextStyle(fontSize: 12)),
              Text("你对自己的表现感觉如何？", style: TextStyle(fontSize: 12)),
            ],
          ),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("不太好", style: TextStyle(fontSize: 12)),
              onPressed: () {
                Navigator.of(context).pop(1);
              },
            ),
            SimpleDialogOption(
              child: new Text("还可以", style: TextStyle(fontSize: 12)),
              onPressed: () {
                Navigator.of(context).pop(2);
              },
            ),
            SimpleDialogOption(
              child: new Text("很好", style: TextStyle(fontSize: 12)),
              onPressed: () {
                Navigator.of(context).pop(3);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showResult(
      BuildContext context, String msg, String button) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
//          title: Text('是否确定'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
//                Text('根据昨日你的专注时长打断次数和自我反馈，你的专注评分比以往平均水平有了进步！'),
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child:
                  Text(button, style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void iosDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return new CupertinoAlertDialog(
          title: new Text("title"),
          content: new Text("内容内容内容内容内容内容内容内容内容内容内容"),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop("点击了确定");
              },
              child: new Text("确认"),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop("点击了取消");
              },
              child: new Text("取消"),
            ),
          ],
        );
      },
    );
  }
}
