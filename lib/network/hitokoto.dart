import 'dart:convert';
import 'package:smart_life_lw/utils/http.dart';

class Hitokoto {
  int id;
  String hitokoto;
  String type;
  String from_where;
  String creator;
  String created_at;

  Hitokoto(
      {this.id,
      this.hitokoto,
      this.type,
      this.from_where,
      this.creator,
      this.created_at});
}

class HitokotoUtils {
  static getHitokoto() async {
    var url = 'http://dc.deali.cn/api/hitokoto/get';
    var responseStr = await get(url);
    Map jsonMap = jsonDecode(responseStr);
    if (jsonMap['status'] == 'ok') {
      print('获取一言成功！');
      Map data = jsonMap['data'][0];
      return Hitokoto(
          id: data['id'],
          hitokoto: data['hitokoto'],
          type: data['type'],
          from_where: data['from_where'],
          creator: data['creator'],
          created_at: data['created_at']);
    } else {
      print('获取一言失败！');
      return null;
    }
  }
}
