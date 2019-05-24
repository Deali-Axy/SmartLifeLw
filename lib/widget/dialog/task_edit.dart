import 'package:flutter/material.dart';
import 'package:smart_life_lw/network/schedule.dart';
import 'package:smart_life_lw/widgets.dart';

enum TaskEditDialogAction { add, update, delete }

class TaskEditDialogResult {
  TaskEditDialogAction action;
  Task task;

  TaskEditDialogResult(this.action, this.task);
}

class TaskEditDialog extends StatefulWidget {
  final Task task;

  TaskEditDialog({this.task});

  @override
  _TaskEditDialogState createState() => _TaskEditDialogState(task);

  static Future<TaskEditDialogResult> show(BuildContext context,
      {Task task}) async {
    return showDialog<TaskEditDialogResult>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return TaskEditDialog(task: task);
      },
    );
  }
}

class _TaskEditDialogState extends State<TaskEditDialog> {
//  double _weight = 1;
  Task _task;
  TextEditingController _editingController = TextEditingController(text: '');
  TaskEditDialogResult _dialogResult =
      TaskEditDialogResult(TaskEditDialogAction.add, Task());

  _TaskEditDialogState(Task task) {
    if (task != null) {
      _task = task;
      _editingController = TextEditingController(text: _task.feEvent);
//      _editingController.value = TextEditingValue(text: _task.feEvent);
//      _weight = _task.feWeight.toDouble();
    }
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
          Text('专注事情'),
          TextFormField(
            controller: _editingController,
//            initialValue: _task?.feEvent,   // 设置了controller就不需要这个初始值了，在controller里设置初始值就好
            maxLines: null,
            decoration: InputDecoration(
              hintText: '请输入专注事情',
              prefixIcon: Icon(Icons.event),
            ),
            onSaved: (value) => _task.feEvent = value,
          ),
          Divider(height: 20),
          Row(
            children: <Widget>[
              Expanded(child: Text('重要程度')),
              for (var i = 1; i <= _task.feWeight; i++)
                Icon(Icons.star, color: Color.fromARGB(255, 245, 166, 35)),
              for (var i = 1; i <= 4 - _task.feWeight; i++)
                Icon(Icons.star_border,
                    color: Color.fromARGB(255, 245, 166, 35)),
            ],
          ),
          SimpleDivider(height: 10),
          Text(
            '滑动下方Slider设置该事件的重要程度',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Slider(
            value: _task.feWeight.toDouble(),
            min: 1,
            max: 4,
            divisions: 3,
            label: _task.feWeight.toString(),
            onChanged: (value) {
              setState(() {
                _task.feWeight = value.round();
              });
            },
          ),
          Row(
            children: <Widget>[
              Expanded(child: Text('')),
              if (_task != null)
                SizedBox(
                  width: flatButtonWidth,
                  height: flatButtonHeight,
                  child: FlatButton(
                    onPressed: () {
                      var result = TaskEditDialogResult(
                          TaskEditDialogAction.delete, _task);
                      Navigator.of(context).pop(result);
                    },
                    child: Text('删除', style: TextStyle(color: Colors.red)),
                  ),
                ),
              SizedBox(
                width: flatButtonWidth,
                height: flatButtonHeight,
                child: FlatButton(
                  onPressed: () {
                    _task.feEvent = _editingController.text;
                    Navigator.of(context).pop(_task);
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
            height: 240,
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
