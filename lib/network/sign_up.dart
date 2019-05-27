import 'dart:convert';
import 'package:smart_life_lw/utils/http.dart';
import 'common.dart';

class SignUpInfo {
  String username;
  String phone;
  String password;
  int gender;

  SignUpInfo({this.username, this.phone, this.password, this.gender});

  Map toMap() {
    return {
      'username': username,
      'phone': phone,
      'password': password,
      'sex': gender
    };
  }
}

abstract class SignUpUtils {
  static Future<Response> signUp(SignUpInfo info) async {
    var url = 'http://47.106.203.63:9091/useradmin/register';
    var responseStr = await post(url, info.toMap());
    print('注册请求结果：$responseStr');
    var jsonMap = jsonDecode(responseStr);
    try {
      return Response(
          code: jsonMap['code'], info: jsonMap['info'], data: jsonMap['data']);
    } catch (exp) {
      print(exp);
      return Response(code: -1, info: exp);
    }
  }
}
