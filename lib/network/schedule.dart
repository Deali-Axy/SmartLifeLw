class Task {
  bool completed;
  String feEvent;
  int feWeight;

  Task({this.completed, this.feEvent, this.feWeight});
}

class Plan {
  String startTime;
  String endTime;
  String event;

  Plan({this.startTime, this.endTime, this.event});
}