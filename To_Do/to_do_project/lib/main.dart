// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_project/screens/homepage.dart';
import 'package:to_do_project/helpers/task.dart';
import 'package:to_do_project/helpers/weather.dart';
import 'package:to_do_project/helpers/location.dart';
import 'package:to_do_project/notification_service.dart';
import 'package:cron/cron.dart';


void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  var cron = new Cron();
  cron.schedule(new Schedule.parse('0 */1 * * *'), () async {
    var activeTaskExist = await ActiveTaskExist();
    if(activeTaskExist) {
      var city = await getCityName();
      var temperature = await fetchWeather(city);
      NotificationService().showNotifications(temperature);
    }
  });



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        unselectedWidgetColor: Color(0xff686868),
      ),
      home: const Homepage(),
    );
  }
}
