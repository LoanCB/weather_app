import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

import '../models/forecast_weather.dart';

class DayWeather extends StatelessWidget {
  const DayWeather({Key? key, required this.weather}) : super(key: key);
  final ForecastWeather weather;

  @override
  Widget build(BuildContext context) {
    final hours = weather.forecast.forecastday.first.hour;

    return ListView.builder(
      itemCount: hours.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TempPanel(
                hours: hours,
                index: index,
              ),
              Image(
                image: NetworkImage('http:${hours[index].condition.icon}'),
              ),
              _WindPanel(
                hours: hours,
                index: index,
              ),
              _HumidityPanel(
                hours: hours,
                index: index,
              ),
              _FeelsLike(
                hours: hours,
                index: index,
              )
            ],
          ),
        );
      },
    );
  }
}

///**************************************************************************///
///                                  PANELS                                  ///
///**************************************************************************///

class _TempPanel extends StatelessWidget {
  const _TempPanel({Key? key, required this.hours, required this.index})
      : super(key: key);
  final List<Hour> hours;
  final int index;

  @override
  Widget build(BuildContext context) {
    _getBackgroundColor(double temp) {
      if (temp < 15) {
        return Colors.green;
      } else if (temp < 20) {
        return Colors.yellow;
      } else if (temp < 25) {
        return Colors.orangeAccent;
      } else if (temp < 30) {
        return Colors.orange;
      } else if (temp < 35) {
        return Colors.redAccent;
      } else if (temp < 40) {
        return Colors.red;
      }
    }

    return Column(
      children: [
        Text(
          hours[index].time.split(' ').last,
          style: const TextStyle(color: Colors.white),
        ),
        DecoratedBox(
            decoration:
                BoxDecoration(color: _getBackgroundColor(hours[index].tempC)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${hours[index].tempC}°'),
            )),
      ],
    );
  }
}

class _WindPanel extends StatelessWidget {
  const _WindPanel({Key? key, required this.hours, required this.index})
      : super(key: key);
  final List<Hour> hours;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform.rotate(
            angle: math.pi * hours[index].windDegree / 180,
            child: const FaIcon(
              FontAwesomeIcons.arrowUp,
              color: Colors.white,
              size: 17,
            )),
        Text(
          '${hours[index].windKph} km/h',
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}

class _HumidityPanel extends StatelessWidget {
  const _HumidityPanel({Key? key, required this.hours, required this.index})
      : super(key: key);
  final List<Hour> hours;
  final int index;

  @override
  Widget build(BuildContext context) {
    _getPrecip(double precip) {
      if (precip == 0) {
        return const Text(
          '-',
          style: TextStyle(color: Colors.white),
        );
      } else {
        return Text('$precip mm', style: const TextStyle(color: Colors.white));
      }
    }

    return Column(
      children: [
        Row(
          children: [
            const FaIcon(
              FontAwesomeIcons.droplet,
              color: Colors.white,
              size: 15,
            ),
            Text(
              ' ${hours[index].humidity} %',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        _getPrecip(hours[index].precipMm),
      ],
    );
  }
}

class _FeelsLike extends StatelessWidget {
  const _FeelsLike({Key? key, required this.hours, required this.index})
      : super(key: key);
  final List<Hour> hours;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FaIcon(
          FontAwesomeIcons.hand,
          color: Colors.white,
          size: 15,
        ),
        Text(
          '${hours[index].feelslikeC}°',
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
