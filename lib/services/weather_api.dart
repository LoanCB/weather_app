import 'package:http/http.dart' as http;

import '../models/current_weather.dart';
import '../models/forecast_weather.dart';
import '../utils/secret_key.dart';

Future<Weather> getCurrentWeatherFromApi(String city) async {
  var url = Uri.http(
    'api.weatherapi.com',
    '/v1/current.json',
    {'key': getSecretKey(), 'q': city, 'lang': 'fr'}
  );

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var json = response.body;
    return currentWeatherFromJson(json);
  } else {
    return Future.error(response.statusCode);
  }

}

Future<ForecastWeather> getForecastWeatherFromApi(String city) async {
  var url = Uri.http(
    'api.weatherapi.com',
    '/v1/forecast.json',
    {'key': getSecretKey(), 'q': city, 'lang': 'fr'}
  );

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var json = response.body;
    return forecastWeatherFromJson(json);
  } else {
    return Future.error(response.statusCode);
  }
}
