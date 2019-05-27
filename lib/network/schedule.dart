import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:smart_life_lw/utils/http.dart';

class Task {
  String id;
  bool completed;
  String feEvent;
  int feWeight;
  int interuptCount;

  Task({this.id, this.completed, this.feEvent, this.feWeight}) {
    id = Uuid().v4();
    interuptCount = 0;
  }

  @override
  String toString() {
    return '[Task:$id]complete: $completed, event: $feEvent, weight: $feWeight';
  }

  Map toMap() {
    return {
      // 'id': id,
      'completed': completed,
      'feEvent': feEvent,
      'feWeight': feWeight,
      'interuptCount': interuptCount,
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
      // 'id': id,
      'dseStartTime': startTime,
      'dseEndTime': endTime,
      'dseEvent': event
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
  /// 获取当前计划
  static Future<Response> getCurrentEvent(int sessionId) async {
    var url =
        'http://47.106.203.63:9091/timeadmin/getCurrentEvent?sessionId=$sessionId';
    var responseStr = await get(url);
    Map jsonMap = jsonDecode(responseStr);

    Response response;
    try {
      response = Response(
          code: jsonMap['code'], info: jsonMap['info'], data: jsonMap['data']);
    } catch (exp) {
      response = Response(code: -1, info: '请求失败！');
    }
    return response;
  }

  /// 更新每日计划
  static Future<Response> updateDailySchedule(
      int sessionId, List tasks, List plans) async {
    var url = 'http://47.106.203.63:9091/timeadmin/updateDailySchedule';
    var requestMap = {
      'sessionId': sessionId,
      'focusEventFormList': tasks.map((task) => task.toMap()).toList(),
      'scheduleEventList': plans.map((plan) => plan.toMap()).toList(),
    };
    var requestStr = jsonEncode(requestMap);
    var responseStr = await post(url, requestMap);
    print(responseStr);
    var responseMap = jsonDecode(responseStr);

    Response response;
    try {
      response = Response(
          code: responseMap['code'],
          info: responseMap['info'],
          data: requestMap['data']);
    } catch (exp) {
      response = Response(code: -1, info: '请求失败！');
    }

    return response;
  }

  /// 自我评分接口
  static Future<String> selfEvaluation(int sessionId, int score) async {
    var url =
        'http://47.106.203.63:9091/timeadmin/selfEvaluation?sessionId=$sessionId&score=$score';
    var responseStr = await get(url);
    var responseMap = jsonDecode(responseStr);
    if (responseMap['code'] == 200)
      return responseMap['data']['returnMsg'];
    else
      return responseMap['info'];
  }
}
