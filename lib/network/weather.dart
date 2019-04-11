import 'package:smart_life_lw/utils/http.dart';
import 'dart:convert';

class WeatherInfo {
  String summary;
  String iconName;
  double _temperature;

  double get temperature => _temperature;

  set temperature(double temperature) {
    // 华氏度转换摄氏度
    _temperature = (temperature - 32) / 1.8;
  }

  WeatherInfo({String summary, String iconName, double temperature}) {
    this.summary = summary;
    this.iconName = iconName;
    this.temperature = temperature;
  }
}

class WeatherUtils {
  static getWeather() async {
    var url =
        'https://api.darksky.net/forecast/ea412bef956a78e5a3bf533b0001f69a/21.151687,110.30104871961805';
    String responseStr = await get(url);
    Map jsonMap = jsonDecode(responseStr);
    return WeatherInfo(
        summary: jsonMap['currently']['summary'],
        iconName: jsonMap['currently']['icon'],
        temperature: jsonMap['currently']['temperature']);
  }
}
