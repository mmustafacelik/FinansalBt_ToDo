import 'package:flutter/material.dart';
import 'package:to_do_project/models/todo.dart' as models;
import 'package:to_do_project/screens/homepage.dart';
import 'package:to_do_project/widgets/todo_item.dart';
import 'package:to_do_project/models/task.dart';
import 'package:to_do_project/helpers/todo.dart';
import 'package:to_do_project/helpers/task.dart';

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

  refresh() {
    setState(() {
      futureTodo = GetTodos(widget.task!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
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
                                true
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            maxLength: 50,
                            onSubmitted: (value) {
                              widget.task!.title = value;
                              UpdateTask(widget.task!);
                            },
                            decoration: InputDecoration(
                              hintText: widget.task?.title,
                              border: InputBorder.none,
                              counterText: '',
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
                      maxLength: 150,
                      onSubmitted: (value) {
                        widget.task!.description = value;
                        UpdateTask(widget.task!);
                      },
                      decoration: InputDecoration(
                        hintText: widget.task?.description,
                        border: InputBorder.none,
                        counterText: '',
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
                                return Todo(todo: todos[index], refreshParentState: refresh,);
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
              Visibility(
                visible: !isKeyboardOpen,
                child: Positioned(
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
              ),
              Visibility(
                visible: !isKeyboardOpen,
                child: Positioned(
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
              ))
            ],
          ),
        ),
      ),
    );
  }
}
