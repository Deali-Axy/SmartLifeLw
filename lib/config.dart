import 'package:flutter/material.dart';

const TITLE = '汇智Life';

class GlobalConfig {
  static bool focusMode = true;
  static TimeOfDay startTime = TimeOfDay.now();
  static TimeOfDay endTime = TimeOfDay.now();
  static int selectedCircle = 1; // 当前选择的圈子
  static String selectedCircleName = '学生'; // 当前圈子名称
}
