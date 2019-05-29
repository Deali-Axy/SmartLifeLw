import 'package:flutter/material.dart';
import 'dart:convert';

class Message {
  static const HUIZHI = '小智';
  static const TEXT = 'text';
  static const IMAGE = 'image';
  static const ERROR = 'error';
  static const URL = 'url';

  String type = '';
  String content = '';
  String from = '';
  String to = '';
  String extra = '';

  Message({
    @required this.type,
    @required this.content,
    @required this.from,
    @required this.to,
    this.extra,
  });

  @override
  String toString() {
    return jsonEncode({
      'type': type,
      'content': content,
      'from': from,
      'to': to,
      'extra': extra
    });
  }
}
