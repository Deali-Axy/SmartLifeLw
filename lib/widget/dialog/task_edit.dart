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
  final TaskEditDialogAction action;

  TaskEditDialog({this.action, this.task});

  @override
  _TaskEditDialogState createState() =>
      _TaskEditDialogState(action, task: task);

  static Future<TaskEditDialogResult> show(
      BuildContext context, TaskEditDialogAction action,
      {Task task}) async {
    return showDialog<TaskEditDialogResult>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return TaskEditDialog(action: action, task: task);
      },
    );
  }
}

class _TaskEditDialogState extends State<TaskEditDialog> {
  Task _task;
  TaskEditDialogAction _action;
  TextEditingController _editingController;
  TaskEditDialogResult _dialogResult;

  _TaskEditDialogState(TaskEditDialogAction action, {Task task}) {
    _action = action;
    if (action == TaskEditDialogAction.update && task != null) {
      _task = task;
      _editingController = TextEditingController(text: _task.event);
    }
    if (action == TaskEditDialogAction.add) {
      _task = Task(completed: false, event: '', weight: 1);
    }

    _editingController = TextEditingController(text: _task.event);
    _dialogResult = TaskEditDialogResult(_action, _task);
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
            maxLines: null,
            decoration: InputDecoration(
              hintText: '请输入专注事情',
              prefixIcon: Icon(Icons.event),
            ),
            onSaved: (value) => _task.event = value,
          ),
          Divider(height: 20),
          Row(
            children: <Widget>[
              Expanded(child: Text('重要程度')),
              for (var i = 1; i <= _task.weight; i++)
                Icon(Icons.star, color: Color.fromARGB(255, 245, 166, 35)),
              for (var i = 1; i <= 4 - _task.weight; i++)
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
            value: _task.weight.toDouble(),
            min: 1,
            max: 4,
            divisions: 3,
            activeColor: Colors.blue,
            inactiveColor: Colors.blue[100],
            label: _task.weight.toString(),
            onChanged: (value) {
              setState(() {
                _task.weight = value.round();
              });
            },
          ),
          SimpleDivider(height: 10),
          Row(
            children: <Widget>[
              Expanded(child: Text('')),
              if (_action == TaskEditDialogAction.update)
                SizedBox(
                  width: flatButtonWidth,
                  height: flatButtonHeight,
                  child: FlatButton(
                    onPressed: () {
                      _dialogResult=TaskEditDialogResult(TaskEditDialogAction.delete, _task);
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
                    _task.event = _editingController.text;
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
