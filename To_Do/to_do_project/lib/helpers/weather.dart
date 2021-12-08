import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather {
  String? temperature;
  String? description;

  Weather({
    this.temperature,
    this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['temperature'],
      description: json['description']
    );
  }
}

Future<String> fetchWeather(String cityName) async {
  final response = await http
      .get(Uri.parse('https://goweather.herokuapp.com/weather/$cityName'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var weather = await Weather.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    return weather.temperature!;
    //return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
