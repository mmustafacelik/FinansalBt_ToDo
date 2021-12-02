import 'package:flutter/material.dart';
import 'package:to_do_project/widgets.dart';
import 'package:to_do_project/database.dart';
import 'package:to_do_project/helpers.dart';
import 'package:to_do_project/models/task.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  late Future<List<Task>> futureTask;

  @override
  void initState() {
    super.initState();
    futureTask = DatabaseHelper().tasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff19C8F6),
        child: const Icon(
          Icons.add,
          size: 40.0,
          color: Colors.white,
        ),
        onPressed: () {
          CreateTask();
          setState(() {
            futureTask = DatabaseHelper().tasks();
          });
        },
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          color: const Color(0xFF80cbc4), //ARKAPLANI SARI YAPAN KOD
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 32.0,
                      left: 150.0,
                      top: 10.0,
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/logo_3.png'),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Task>>(
                      future: futureTask,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Task> tasks = snapshot.data!;
                          return ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TaskCardWidget(
                                  title: tasks[index].title,
                                  description: "Merhabalar buraya ana başlık altında yapmanız gerekenleri yazabilirsiniz"
                              );
                            },
                          );
                        }
                        else if(snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      }
                    ),
                    /*child: ListView(
                      children: [
                        TaskCardWidget(
                          title: "Birinci",
                          description:
                              "Merhabalar buraya ana başlık altında yapmanız gerekenleri yazabilirsiniz",
                        ),
                      ],
                    ),*/
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
