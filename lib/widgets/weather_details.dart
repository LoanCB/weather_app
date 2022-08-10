import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/pages/home_page.dart';
import 'dart:math' as math;

import '../models/current_weather.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({Key? key, required this.weather}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DefaultPanel(
          weather: weather,
        ),
        _DetailPanel(
          weather: weather,
        ),
      ],
    );
  }
}

///**************************************************************************///
///                                  PANELS                                  ///
///**************************************************************************///

class _DefaultPanel extends StatelessWidget {
  const _DefaultPanel({Key? key, required this.weather}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    var time = weather.current.lastUpdated.toString().split(' ').last;

    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 250),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueAccent, Colors.lightBlueAccent])),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    weather.location.name,
                    style: const TextStyle(fontSize: 30),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Lon:${weather.location.lon} | '),
                  Text('Lat:${weather.location.lat}'),
                ],
              ),
              Row(
                children: [
                  Image.network(
                    'http:${weather.current.condition.icon}',
                    scale: 0.5,
                  ),
                  Column(
                    children: [
                      Text('${weather.current.tempC}°',
                          style: const TextStyle(fontSize: 40)),
                      Text(time, style: const TextStyle(fontSize: 30)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailPanel extends StatelessWidget {
  const _DetailPanel({Key? key, required this.weather}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            _InfoCard(
              icon: Icons.beenhere_rounded,
              text: '${weather.current.feelslikeC} °C',
              helpText: 'Ressenti',
            ),
            _InfoCard(
              icon: Icons.air,
              text: '${weather.current.windKph} km/h',
              helpText: 'Force du vent',
            ),
            _RotateInfoCard(
              icon: Icons.arrow_upward_rounded,
              text: weather.current.windDir,
              degree: weather.current.windDegree.toDouble(),
              helpText: 'direction du vent',
            ),
            _FaIconCard(
              icon: FontAwesomeIcons.cloudRain,
              text: '${weather.current.precipMm} mm',
              helpText: 'précipitation',
            ),
            _FaIconCard(
              icon: FontAwesomeIcons.droplet,
              text: '${weather.current.humidity} %',
              helpText: 'humidité',
            ),
            _FaIconCard(
              icon: FontAwesomeIcons.cloud,
              text: '${weather.current.cloud} %',
              helpText: 'nuages',
            ),
            _FaIconCard(
              icon: FontAwesomeIcons.prescriptionBottle,
              text: '${weather.current.pressureMb} mb',
              helpText: 'pression',
            ),
            _FaIconCard(
              icon: FontAwesomeIcons.cloudsmith,
              text: '${weather.current.uv}',
              helpText: 'UV',
            ),
          ],
        ),
      ),
    );
  }
}


///**************************************************************************///
///                                  WIDGETS                                 ///
///**************************************************************************///

class _InfoCard extends StatelessWidget {
  const _InfoCard(
      {Key? key,
      required this.icon,
      required this.text,
      required this.helpText})
      : super(key: key);
  final IconData icon;
  final String text;
  final String helpText;

  @override
  Widget build(BuildContext context) {
    return _CustomCard(
      icon: icon,
      text: text,
      helpText: helpText,
    );
  }
}

class _RotateInfoCard extends StatelessWidget {
  const _RotateInfoCard(
      {Key? key,
      required this.icon,
      required this.text,
      required this.degree,
      required this.helpText})
      : super(key: key);
  final IconData icon;
  final String text;
  final String helpText;
  final double degree;

  @override
  Widget build(BuildContext context) {
    return _CustomCard(
      icon: icon,
      text: text,
      degree: degree,
      helpText: helpText,
    );
  }
}

class _FaIconCard extends StatelessWidget {
  const _FaIconCard(
      {Key? key,
      required this.icon,
      required this.text,
      required this.helpText})
      : super(key: key);
  final IconData icon;
  final String text;
  final String helpText;

  @override
  Widget build(BuildContext context) {
    return _CustomCard(
      icon: icon,
      text: text,
      fa: true,
      helpText: helpText,
    );
  }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard(
      {Key? key,
      required this.icon,
      required this.text,
      this.degree,
      this.fa,
      required this.helpText})
      : super(key: key);
  final IconData icon;
  final String text;
  final String helpText;
  final double? degree;
  final bool? fa;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueAccent, Colors.lightBlueAccent])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fa != null
              ? FaIcon(
                  icon,
                  color: Colors.white,
                )
              : degree != null
                  ? Transform.rotate(
                      angle: math.pi * degree! / 180,
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ))
                  : Icon(
                      icon,
                      color: Colors.white,
                    ),
          Text(text),
          Flexible(
              child: Text(
            helpText,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
