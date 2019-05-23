import 'package:flutter/material.dart';
import 'package:smart_life_lw/network/schedule.dart';

class TaskEditDialog extends StatefulWidget {
  final Task task;

  TaskEditDialog({this.task});

  @override
  _TaskEditDialogState createState() => _TaskEditDialogState(task);

  static Future<void> show(BuildContext context, {Task task}) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return TaskEditDialog(task: task);
      },
    );
  }
}

class _TaskEditDialogState extends State<TaskEditDialog> {
  double _weight = 1;
  Task _task;
  TextEditingController _editingController;

  _TaskEditDialogState(Task task) {
    if (task != null) {
      _task = task;
//      _editingController.value = TextEditingValue(text: _task.feEvent);
      _weight = _task.feWeight.toDouble();
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
            initialValue: _task?.feEvent,
            maxLines: null,
            decoration: InputDecoration(
              hintText: '请输入专注事情',
              prefixIcon: Icon(Icons.event),
            ),
          ),
          Divider(height: 20),
          Row(
            children: <Widget>[
              Expanded(child: Text('重要程度')),
              for (var i = 1; i <= _weight.round(); i++)
                Icon(Icons.star, color: Color.fromARGB(255, 245, 166, 35)),
              for (var i = 1; i <= 4 - _weight.round(); i++)
                Icon(Icons.star_border,
                    color: Color.fromARGB(255, 245, 166, 35)),
            ],
          ),
          Slider(
            value: _weight,
            min: 1,
            max: 4,
            divisions: 3,
            label: _weight.round().toString(),
            onChanged: (value) {
              setState(() {
                _weight = value;
              });
            },
          ),
          Row(
            children: <Widget>[
              Expanded(child: Text('')),
              SizedBox(
                width: flatButtonWidth,
                height: flatButtonHeight,
                child: FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('取消', style: TextStyle(color: Colors.red)),
                ),
              ),
              SizedBox(
                width: flatButtonWidth,
                height: flatButtonHeight,
                child: FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
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
