import 'dart:convert';
import 'package:smart_life_lw/utils/http.dart';
import 'common.dart';

class UserInfo {
  int id;
  String username;
  String phone;
  String password;
  String portrait;
  String signature;
  int gender;
  int birthday;
  String email;
  Map type;
  int isverify;
  String province;
  String city;

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
        portrait = map['protrait'],
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

    try {
      var data = jsonMap['data'];

      return Response(
        code: jsonMap['code'],
        info: jsonMap['info'],
        data: UserInfo.fromMap(data),
      );
    } catch (exp) {
      return Response(code: -1, info: exp);
    }
  }
}
