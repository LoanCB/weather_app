import 'package:flutter/material.dart';
import 'package:weather/pages/forecast_weather_city.dart';

import 'current_weather_city.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  late bool _error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
                hintText: 'Entrez une ville',
                errorText: _error ? "Veillez renseigner une ville" : null,
                errorBorder: _error
                    ? const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.red))
                    : null,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {
                      _textController.clear();
                    },
                    icon: const Icon(Icons.clear))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    String city = _textController.text;
                    city.isEmpty ? _error = true : _error = false;
                    if (_error == false) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrentWeatherCity(
                                    city: city,
                                  )));
                    }
                  });
                },
                color: Colors.blueAccent,
                child: const Text(
                  'météo en directe',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    String city = _textController.text;
                    city.isEmpty ? _error = true : _error = false;
                    if (_error == false) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForecastWeatherCity(
                                    city: city,
                                  )));
                    }
                  });
                },
                color: Colors.blueAccent,
                child: const Text(
                  'météo de la journée',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
