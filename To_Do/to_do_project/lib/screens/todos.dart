import 'package:flutter/material.dart';
import 'package:to_do_project/models/todo.dart' as models;
import 'package:to_do_project/screens/homepage.dart';
import 'package:to_do_project/widgets.dart';
import 'package:to_do_project/models/task.dart';
import 'package:to_do_project/helpers.dart';

class Todopage extends StatefulWidget {
  late Task? task;

  Todopage({Key? key, Task? this.task}) : super(key: key);

  @override
  _TodopageState createState() => _TodopageState();
}

class _TodopageState extends State<Todopage> {

  late Future<List<models.Todo>> futureTodo;

  @override
  void initState() {
    super.initState();
    futureTodo = GetTodos(widget.task!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 6.0,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: BackButton(
                            color: Colors.red,
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) {
                              print("Başlık:$value");
                            },
                            decoration: InputDecoration(
                              hintText: widget.task?.title,
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff607D8B),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 12.0,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: widget.task?.description,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<models.Todo>>(
                        future: futureTodo,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<models.Todo> todos = snapshot.data!;
                            return ListView.builder(
                              itemCount: todos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Todo(todo: todos[index]);
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
              Positioned(
                left: 10.0,
                bottom: 10.0,
                child: FloatingActionButton(
                  heroTag: 'delTaskBtn',
                  backgroundColor: Color(0xffff0303),
                  child: const Icon(
                    Icons.delete_forever,
                    size: 25.0,
                    color: Color(0xffFFECB3),
                  ),
                  onPressed: () {
                    DeleteTask(widget.task!.id!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: FloatingActionButton(
                  heroTag: 'addTodoBtn',
                  backgroundColor: Color(0xff19C8F6),
                  child: const Icon(
                    Icons.add,
                    size: 25.0,
                    color: Color(0xffFFECB3),
                  ),
                  onPressed: () {
                    CreateTodo(widget.task!.id!);
                    setState(() {
                      futureTodo = GetTodos(widget.task!.id!);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
