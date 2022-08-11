import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/weather_api.dart';
import '../widgets/weather_details.dart';
import 'home_page.dart';

class CurrentWeatherCity extends StatefulWidget {
  const CurrentWeatherCity({Key? key, required this.city}) : super(key: key);
  final String city;

  @override
  State<CurrentWeatherCity> createState() => _CurrentWeatherCityState();
}

class _CurrentWeatherCityState extends State<CurrentWeatherCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const FaIcon(Icons.search),
          onPressed: () => setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
          }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
      child: FutureBuilder(
        future: getCurrentWeatherFromApi(widget.city),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('error : ${snapshot.error}'),
            );
          } else {
            return WeatherDetails(
              weather: snapshot.data,
            );
          }
        },
      ),
    ));
  }
}
