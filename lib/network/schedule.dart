import 'package:uuid/uuid.dart';

class Task {
  String id;
  bool completed;
  String feEvent;
  int feWeight;

  Task({this.id, this.completed, this.feEvent, this.feWeight}) {
    id = Uuid().v4();
  }

  @override
  String toString() {
    return '[Task:$id]complete: $completed, event: $feEvent, weight: $feWeight';
  }
}

class Plan {
  String id = Uuid().v4();
  String startTime;
  String endTime;
  String event;

  Plan({this.id, this.startTime, this.endTime, this.event}) {
    id = Uuid().v4();
  }

  @override
  String toString() {
    return '[Plan:$id]event: $event, startTime: $startTime, endTime: $endTime';
  }
}
