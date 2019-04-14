import 'package:flutter/material.dart';
import 'package:smart_life_lw/network/weather.dart';

class WeatherCard extends StatefulWidget {
  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {

  WeatherInfo _weatherInfo =
  WeatherInfo(summary: '等待刷新', iconName: 'clear-night', temperature: 80);

  _WeatherCardState(){
    _getWeather();
  }

  _getWeather() async {
    _weatherInfo = await WeatherUtils.getWeather();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: ListTile(
          leading: Image.asset(
            'images/weather/${_weatherInfo.iconName}.png',
            fit: BoxFit.fitHeight,
            height: 50,
          ),
          title: Text('湛江天气：${_weatherInfo.temperature.roundToDouble()} ℃'),
          subtitle: Text(_weatherInfo.summary),
          trailing: IconButton(
              icon: Icon(Icons.refresh), onPressed: () => _getWeather()),
        ),
      ),
    );
  }
}
