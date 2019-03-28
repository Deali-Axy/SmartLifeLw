import 'package:smart_life_lw/little_white.dart';
import 'dart:convert';
import 'package:smart_life_lw/models.dart';

main() async {
  Map jsonMap = {
    'type': 'text',
    'content': 'hello',
  };

  String jsonStr = jsonEncode(jsonMap);
  print(jsonStr);

  Message result = await LittleWhite.sendText('你好');
  print(result);
}
