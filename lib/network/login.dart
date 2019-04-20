import 'dart:convert';
import 'package:smart_life_lw/utils/http.dart';

class LoginInfo {
  String phone;
  String password;

  Map toMap() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}

class LoginUtils {
  static Future<bool> login(LoginInfo loginInfo) async {
    var url = '';

    var responseStr = await post(url, loginInfo.toMap());
    var jsonMap = jsonDecode(responseStr);

    print(responseStr);

    return true;
  }
}
