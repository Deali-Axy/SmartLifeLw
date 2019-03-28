import 'utils/http.dart';
import 'models.dart';
import 'dart:convert';

const _URL = 'http://cloud.deali.cn/lw2.php';

class LittleWhite {
  static Future<Message> sendText(String content) async {
    Map jsonMap = {
      'type': 'text',
      'content': content,
    };

    String result = await post(_URL, jsonMap);
    Map resultMap = jsonDecode(result);

    if (resultMap.containsKey('type'))
      return Message(
          type: resultMap['type'],
          content: resultMap['content'],
          from: Message.HUIZHI,
          to: '汇智用户',
          extra: resultMap.containsKey('extra') ? resultMap['extra'] : '');
    else
      return Message(type: 'none', content: null, from: null, to: null);
  }
}
