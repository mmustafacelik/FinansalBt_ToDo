import 'package:flutter/material.dart';
import 'package:to_do_project/screens/todos.dart';
import 'package:to_do_project/models/todo.dart' as models;
import 'package:to_do_project/models/task.dart';
import 'package:flutter_switch/flutter_switch.dart';

// Homepage task
class TaskCardWidget extends StatelessWidget {
  late Task? task;

  TaskCardWidget({Key? key, this.task}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Todopage(task: task),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
          margin: EdgeInsets.only(
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffE1BEE7),//Görev Listesi homepagedeki renkler
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Text(
                task?.title ?? "(İsimsiz Başlık)",
                style: const TextStyle(
                    color: Color(0xff212121),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  task?.description ?? (""),
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16.0,
                    color: Color(0xFF616161),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        )
      );
  }
}

class Todo extends StatefulWidget {
  late models.Todo? todo;

  Todo({
    Key? key,
    this.todo
  }) : super(key: key);
  @override
  _TodoState createState() => _TodoState();
}

// Sub task of a task
class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 0.0,
      ),
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.green,
            value: widget.todo?.isDone != 0 ? true : false,
            onChanged: (value) {
              setState(() {
                widget.todo?.isDone = value! ? 1 : 0;
                print(widget.todo?.isDone);
              });
            },
          ),
          Text(
            widget.todo?.title ?? "(isimsiz görev)",
            style: TextStyle(
              color: Color(0xff5D4037),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
