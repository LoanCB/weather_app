import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/services/weather_api.dart';
import 'package:weather/widgets/day_weather.dart';

class ForecastWeatherCity extends StatefulWidget {
  const ForecastWeatherCity({Key? key, required this.city}) : super(key: key);
  final String city;

  @override
  State<ForecastWeatherCity> createState() => _ForecastWeatherCityState();
}

class _ForecastWeatherCityState extends State<ForecastWeatherCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      floatingActionButton: FloatingActionButton(
        child: const FaIcon(Icons.search),
        onPressed: () => setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
        }),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: FutureBuilder(
          future: getForecastWeatherFromApi(widget.city),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('error : ${snapshot.error} \n\n ${snapshot.stackTrace}', textAlign: TextAlign.center,),
              );
            } else {
              return DayWeather(
                weather: snapshot.data,
              );
            }
          },
        ));
  }
}
