import 'dart:convert';
import 'package:smart_life_lw/utils/http.dart';
import 'common.dart';

class UserInfo {
  int id;
  String username = '';
  int phone = 0;
  String password = '';
  String portrait = 'http://lorempixel.com/100/100/';
  String signature = '';
  int gender = 0;
  int birthday = 0;
  String email = '';
  Map type = {};
  int isverify = 1;
  String province = '广东';
  String city = '广州';

  UserInfo(
      {this.id,
      this.username,
      this.phone,
      this.password,
      this.portrait,
      this.signature,
      this.gender,
      this.birthday,
      this.email,
      this.type,
      this.isverify,
      this.province,
      this.city});

  UserInfo.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        phone = map['phone'],
        portrait = map['portrait'],
        signature = map['signature'],
        gender = map['gender'],
        birthday = map['birthday'],
        email = map['email'],
        type = map['type'],
        isverify = map['isverify'],
        province = map['province'],
        city = map['city'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'phone': phone,
        'portrait': portrait,
        'signature': signature,
        'gender': gender,
        'birthday': birthday,
        'email': email,
        'type': type,
        'isverify': isverify,
        'province': province,
        'city': city,
      };
}

abstract class UserUtils {
  static Future<Response> getUserInfo(int userid) async {
    var url =
        'http://47.106.203.63:9091/useradmin/getUserInfoById?userId=$userid';
    var responseStr = await get(url);
    var jsonMap = jsonDecode(responseStr);

    var data = jsonMap['data'];

    return Response(
      code: jsonMap['code'],
      info: jsonMap['info'],
      data: UserInfo.fromMap(data),
    );

    try {} catch (exp) {
      print(exp);
      return Response(code: -1, info: exp.toString());
    }
  }
}
