import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:smart_life_lw/utils/http.dart';

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

  Map toMap() {
    return {
      'id': id,
      'completed': completed,
      'feEvent': feEvent,
      'feWeight': feWeight
    };
  }

  String toJson() {
    return jsonEncode(toMap());
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

  Map toMap() {
    return {
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'event': event
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class Response {
  int code;
  String info;
  dynamic data;

  Response({this.code, this.info, this.data});
}

abstract class ScheduleUtils {
  static Future<Response> getCurrentEvent(int sessionId) async {
    var url =
        'http://47.106.203.63:9091/timeadmin/getCurrentEvent?sessionId=$sessionId';
    var responseStr = await get(url);
    Map jsonMap = jsonDecode(responseStr);
    var response = Response(
        code: jsonMap['code'], info: jsonMap['info'], data: jsonMap['data']);

    return response;
  }

  static Future<Response> updateDailySchedule(int sessionId)async{
    
  }
}
