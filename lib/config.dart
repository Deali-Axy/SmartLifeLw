import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';
import 'package:smart_life_lw/network/user.dart';

const TITLE = '汇智Life';

abstract class Resource {
  static const String title = '汇智Life';
}

abstract class GlobalConfig {
  static SharedPreferences sharedPreferences;

  static bool focusMode = false;
  static TimeOfDay startTime = TimeOfDay.now();
  static TimeOfDay endTime = TimeOfDay.now();
  static int selectedCircle = 1; // 当前选择的圈子
  static String selectedCircleName = '学生'; // 当前圈子名称

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<PackageInfo> get packageInfo async {
    return await PackageInfo.fromPlatform();
  }

  static set userId(int value) => sharedPreferences.setInt('userid', value);

  static int get userId => sharedPreferences.getInt('userid');

  static set userInfo(UserInfo value) {
    sharedPreferences.setString('userinfo', jsonEncode(value.toMap()));
  }

  static UserInfo get userInfo {
    if (sharedPreferences.getString('userinfo') != null)
      return UserInfo.fromMap(
          json.decode(sharedPreferences.getString('userinfo')));
    else
      return UserInfo(
        id: 0,
        username: '未登录',
        signature: '点击这里登录汇智Life',
        portrait: 'http://lorempixel.com/100/100/',
      );
  }

  static bool get isLogin => sharedPreferences.getInt('userid') != null;
}
