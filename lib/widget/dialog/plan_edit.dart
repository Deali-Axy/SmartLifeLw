import 'package:flutter/material.dart';
import 'package:smart_life_lw/network/schedule.dart';
import 'package:smart_life_lw/widgets.dart';

enum PlanEditDialogAction { add, update, delete }

class PlanEditDialogResult {
  PlanEditDialogAction action;
  Plan plan;

  PlanEditDialogResult(this.action, this.plan);
}

class PlanEditDialog extends StatefulWidget {
  final Plan plan;
  final PlanEditDialogAction action;

  PlanEditDialog({this.action, this.plan});

  @override
  _PlanEditDialogState createState() =>
      _PlanEditDialogState(action, plan: plan);

  static Future<PlanEditDialogResult> show(
      BuildContext context, PlanEditDialogAction action,
      {Plan plan}) async {
    return showDialog<PlanEditDialogResult>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PlanEditDialog(action: action, plan: plan);
      },
    );
  }
}

class _PlanEditDialogState extends State<PlanEditDialog> {
  Plan _plan;
  PlanEditDialogAction _action;
  TextEditingController _editingController;
  PlanEditDialogResult _dialogResult;

  _PlanEditDialogState(PlanEditDialogAction action, {Plan plan}) {
    _action = action;
    if (action == PlanEditDialogAction.update && plan != null) {
      _plan = plan;
      _editingController = TextEditingController(text: _plan.event);
    }
    if (action == PlanEditDialogAction.add) {
      _plan = Plan(startTime: '', event: '', endTime: '');
    }

    _editingController = TextEditingController(text: _plan.event);
    _dialogResult = PlanEditDialogResult(_action, _plan);
  }

  @override
  Widget build(BuildContext context) {
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;

    RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)));

    double flatButtonWidth = 60;
    double flatButtonHeight = 25;
    var container = Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Text('计划表'),
          TextFormField(
            controller: _editingController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: '请输入计划',
              prefixIcon: Icon(Icons.event),
            ),
            onSaved: (value) => _plan.event = value,
          ),
          SimpleDivider(height: 20),
          Row(
            children: <Widget>[
              Text('开始时间'),
              SimpleDivider(height: 0, width: 10),
              Expanded(
                child: _plan.startTime.length == 0
                    ? Text('尚未设置', style: TextStyle(color: Colors.red))
                    : Text(_plan.startTime),
              ),
              SizedBox(
                width: flatButtonWidth,
                height: flatButtonHeight,
                child: FlatButton(
                  child: Text('选择'),
                  onPressed: () async {
                    var selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      _plan.startTime = '${selectedTime.hour}:';
                      if (selectedTime.minute < 10)
                        _plan.startTime += '0${selectedTime.minute}';
                      else
                        _plan.startTime += selectedTime.minute.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          Divider(height: 20),
          Row(
            children: <Widget>[
              Text('结束时间'),
              SimpleDivider(height: 0, width: 10),
              Expanded(
                child: _plan.endTime.length == 0
                    ? Text('尚未设置', style: TextStyle(color: Colors.red))
                    : Text(_plan.endTime),
              ),
              SizedBox(
                width: flatButtonWidth,
                height: flatButtonHeight,
                child: FlatButton(
                  child: Text('选择'),
                  onPressed: () async {
                    var selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      _plan.endTime = '${selectedTime.hour}:';
                      if (selectedTime.minute < 10)
                        _plan.endTime += '0${selectedTime.minute}';
                      else
                        _plan.endTime += selectedTime.minute.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          Divider(height: 20),
          Row(
            children: <Widget>[
              Expanded(child: Text('')),
              if (_action == PlanEditDialogAction.update)
                SizedBox(
                  width: flatButtonWidth,
                  height: flatButtonHeight,
                  child: FlatButton(
                    onPressed: () {
                      _dialogResult = PlanEditDialogResult(
                          PlanEditDialogAction.delete, _plan);
                      Navigator.of(context).pop(_dialogResult);
                    },
                    child: Text('删除', style: TextStyle(color: Colors.red)),
                  ),
                ),
              SizedBox(
                width: flatButtonWidth,
                height: flatButtonHeight,
                child: FlatButton(
                  onPressed: () {
                    _plan.event = _editingController.text;
                    Navigator.of(context).pop(_dialogResult);
                  },
                  child: Text('确认'),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: 300,
            height: 220,
            child: Material(
              elevation: 24.0,
              color: Theme.of(context).dialogBackgroundColor,
              type: MaterialType.card,
              //在这里修改成我们想要显示的widget就行了，外部的属性跟其他Dialog保持一致
              child: container,
              shape: _defaultDialogShape,
            ),
          ),
        ),
      ),
    );
  }
}
