import 'dart:convert';
import 'package:smart_life_lw/utils/http.dart';

class SignUpInfo {
  String username;
  String phone;
  String password;
  int sex;

  Map toMap() {
    return {
      'username': username,
      'phone': phone,
      'password': password,
      'sex': sex
    };
  }
}

abstract class SignUpUtils {
  static Future<bool> signUp(SignUpInfo info) async {
    var url = 'http://47.106.203.63:9091/useradmin/register';
    var responseStr = await post(url, info.toMap());
    print(responseStr);


    return true;
  }
}
