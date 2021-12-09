import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather {
  String? temperature;

  Weather({
    this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['current_weather']['temperature'].toString(),
    );
  }
}



Future<String> fetchWeather(String latitude, String longitude) async {
  //https://api.open-meteo.com/v1/forecast?latitude=40.87&longitude=29.25&current_weather=true
  final response = await http
      .get(Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true'));

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
