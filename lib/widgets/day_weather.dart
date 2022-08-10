import 'package:flutter/material.dart';

import '../models/forecast_weather.dart';

class DayWeather extends StatelessWidget {
  const DayWeather({Key? key, required this.weather}) : super(key: key);
  final ForecastWeather weather;

  @override
  Widget build(BuildContext context) {
    return Text(weather.forecast.forecastday.first.day.avghumidity.toString());
  }
}
