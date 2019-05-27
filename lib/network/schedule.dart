import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';
import 'package:smart_life_lw/utils/http.dart';

class Task {
  String id;
  bool completed;
  String event;
  int weight;
  int interuptCount;

  Task({this.id, this.completed, this.event, this.weight}) {
    id = Uuid().v4();
    interuptCount = 0;
  }

  Task.formJson(String json) {
    Map map = jsonDecode(json);
    Task.fromMap(map);
  }

  Task.fromMap(Map map) {
    this.id = map.containsKey('id') ? map['id'] : Uuid().v4;
    this.completed = map['completed'];
    this.event = map['event'];
    this.weight = map['weight'];
    this.interuptCount = map['interuptCount'];
  }

  @override
  String toString() {
    return '[Task:$id]complete: $completed, event: $event, weight: $weight';
  }

  Map toMap() {
    return {
      // 'id': id,
//      'completed': completed,
      'completed': 'false',
      'event': event,
      'weight': weight,
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
  bool hasChild;
  List<Plan> children;

  Plan({this.id, this.startTime, this.endTime, this.event, this.hasChild}) {
    id = Uuid().v4();
    children = <Plan>[];
  }

  Plan.fromJson(String json) {
    Map map = jsonDecode(json);
    Plan.fromMap(map);
  }

  Plan.fromMap(Map map) {
    this.id = map.containsKey('id') ? map['id'] : Uuid().v4();
    this.startTime = map['startTime'];
    this.endTime = map['endTime'];
    this.event = map['event'];
  }

  @override
  String toString() {
    return '[Plan:$id]event: $event, startTime: $startTime, endTime: $endTime';
  }

  Map toMap() {
    return {
      // 'id': id,
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

  /// 获取每日计划
  static Future<List<Plan>> getTodaySchedule(int sessionId) async {
    var url =
        'http://47.106.203.63:9091/timeadmin/getTodaySchedule?sessionId=$sessionId';
    var plans = <Plan>[];
    var responseStr = await get(url);
    var responseMap = jsonDecode(responseStr);
    if (responseMap['code'] == 200) {
      var data = responseMap['data'];
      if (data != null) {
        for (Map item in data) {
          var plan = Plan.fromMap(item);
          if (item.containsKey('list')) {
            plan.hasChild = true;
//            for (Map task in item['list']) {
//               plan.children.add(Task.fromMap(task));
//            }
          }
          plans.add(plan);
        }
      }
    }
    return plans;
  }

  /// 中断当前事件
  static Future<String> interruptEvent(int sessionId) async {
    var url =
        'http://47.106.203.63:9091/timeadmin/interruptEvent?sessionId=$sessionId';
    var responseStr = await get(url);
    return jsonDecode(responseStr)['info'];
  }

  /// 自我评分接口
  static Future<Map<String, String>> selfEvaluation(
      int sessionId, int score) async {
    var url =
        'http://47.106.203.63:9091/timeadmin/selfEvaluation?sessionId=$sessionId&score=$score';
    var responseStr = await get(url);
    var responseMap = jsonDecode(responseStr);
    var returnMap = <String, String>{};
    if (responseMap['code'] == 200) {
      returnMap['msg'] = responseMap['data']['returnMsg'];
      returnMap['button'] = responseMap['data']['button'];
    } else {
      returnMap['msg'] = responseMap['info'];
      returnMap['button'] = '发生错误！';
    }
    return returnMap;
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
}
