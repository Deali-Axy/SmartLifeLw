import 'dart:convert';
import 'package:smart_life_lw/utils/http.dart';
import 'common.dart';

class LoginInfo {
  String phone;
  String password;

  LoginInfo({this.phone, this.password});

  Map toMap() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}

class LoginUtils {
  static Future<Response> login(LoginInfo loginInfo) async {
    var url =
        'http://47.106.203.63:9091/useradmin/login?phone=${loginInfo.phone}&password=${loginInfo.password}';

    var responseStr = await get(url);
    var jsonMap = jsonDecode(responseStr);
    print(responseStr);

    try {
      return Response(
        code: jsonMap['code'],
        info: jsonMap['info'],
        data: jsonMap['data'],
      );
    } catch (exp) {
      return Response(code: -1, info: exp);
    }
  }
}
