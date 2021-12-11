// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_project/screens/homepage.dart';
import 'package:to_do_project/helpers/task.dart';
import 'package:to_do_project/helpers/weather.dart';
import 'package:to_do_project/helpers/location.dart';
import 'package:to_do_project/notification_service.dart';
import 'package:cron/cron.dart';
import 'package:workmanager/workmanager.dart';

const notificationTaskKey = "notificationTask";

void callbackDispatcher() {
  try { //add code execution
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case notificationTaskKey:
            var activeTaskExist = await ActiveTaskExist();
            if(activeTaskExist) {
              var coordinates = await getCoordinates();
              var temperature = await fetchWeather(coordinates[0], coordinates[1]);
              NotificationService().showNotifications('$temperature °C');
            }
          break;
      }
      // Return whether the job ran successful or not.
      return Future.value(true);
    });
  } catch(err) {
    print('hata $err');
  }
}

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();


  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  Workmanager().registerPeriodicTask("22", notificationTaskKey, frequency: Duration(hours: 3)); //Android only (see below)


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
