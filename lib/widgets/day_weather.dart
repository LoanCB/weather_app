import 'package:flutter/material.dart';

import '../models/forecast_weather.dart';

class DayWeather extends StatelessWidget {
  const DayWeather({Key? key, required this.weather}) : super(key: key);
  final ForecastWeather weather;

  @override
  Widget build(BuildContext context) {
  final hours = weather.forecast.forecastday.first.hour;
  for (var hour in hours) {
    print(hour.tempC);
  }

    // return ListView.builder(
    //   itemCount: hours.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text(hours[index].tempC.toString()),
    //       leading: const CircleAvatar(backgroundColor: Colors.blue,),
    //     );
    //   },
    // );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var hour in hours) {
          Text(hour.tempC.toString()),
        }
      ],
    );
  }
}
