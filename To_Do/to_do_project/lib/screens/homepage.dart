import 'package:flutter/material.dart';
import 'package:to_do_project/widgets/task_card.dart';
import 'package:to_do_project/helpers/task.dart';
import 'package:to_do_project/models/task.dart';
import 'package:to_do_project/screens/todos.dart';
import 'package:to_do_project/notification_service.dart';

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
    futureTask = getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff554cff),
        child: const Icon(
          Icons.add,
          size: 40.0,
          color: Colors.white,
        ),
        onPressed: () {
          CreateTask();
          setState(() {
            futureTask = getTasks();
          });
          NotificationService().showNotifications();
        },
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          color: const Color(0xff121212), //ARKAPLANI SARI YAPAN KOD
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
                      image: AssetImage('assets/images/test.png'),
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
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Todopage(task: tasks[index]),
                                    ),
                                  ).then((value) => setState(() {}));
                                },
                                child: TaskCard(
                                  task: tasks[index],
                                )
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
