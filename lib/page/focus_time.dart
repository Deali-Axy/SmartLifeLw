import 'package:flutter/material.dart';
import 'package:smart_life_lw/config.dart';

class FocusTime extends StatefulWidget {
  @override
  _FocusTimeState createState() => _FocusTimeState();
}

class _FocusTimeState extends State<FocusTime> {
  int _radioGroup = 0;
  bool _weekDayRepeat = true;
  bool _everyDayRepeat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('专注时间'),
        actions: <Widget>[
          Switch(
              value: GlobalConfig.focusMode,
              onChanged: (value) {
                setState(() {
                  GlobalConfig.focusMode = value;
                });
              })
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: GlobalConfig.focusMode
                    ? Text('已经进入专注时间')
                    : Text('还没有进入专注时间'),
              ),
            ),
            Image.asset(
              'images/focus_mode.jpg',
              fit: BoxFit.fitHeight,
              height: 300,
            ),
            Divider(height: 1.0),
            Text('设置自动进入专注时间'),
            Divider(height: 1.0),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          '开始时间：${GlobalConfig.startTime.hour}:${GlobalConfig.startTime.minute}'),
                      Divider(height: 1, indent: 10),
                      RaisedButton(
                        child: Text('设置开始时间'),
                        onPressed: () {
                          Future<TimeOfDay> selectedTime = showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          GlobalConfig.startTime = selectedTime as TimeOfDay;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          '结束时间：${GlobalConfig.endTime.hour}:${GlobalConfig.endTime.minute}'),
                      Divider(height: 1, indent: 10),
                      RaisedButton(
                        child: Text('设置结束时间'),
                        onPressed: () {
                          Future<TimeOfDay> selectedTime = showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          GlobalConfig.endTime = selectedTime as TimeOfDay;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Divider(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('工作日重复'),
                      Switch(
                          value: _weekDayRepeat,
                          onChanged: (value) {
                            setState(() {
                              _weekDayRepeat = value;
                              _everyDayRepeat = !_everyDayRepeat;
                            });
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('每天重复'),
                      Switch(
                          value: _everyDayRepeat,
                          onChanged: (value) {
                            setState(() {
                              _everyDayRepeat = value;
                              _weekDayRepeat = !_weekDayRepeat;
                            });
                          })
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
