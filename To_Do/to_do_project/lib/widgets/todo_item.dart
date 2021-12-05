import 'package:flutter/material.dart';
import 'package:to_do_project/models/todo.dart' as models;
import 'package:to_do_project/helpers/todo.dart';

// Homepage task

class Todo extends StatefulWidget {
  late models.Todo? todo;
  final Function() refreshParentState;

  Todo({
    Key? key,
    this.todo,
    required this.refreshParentState,
  }) : super(key: key);
  @override
  _TodoState createState() => _TodoState();
}

// Sub task of a task
class _TodoState extends State<Todo> {

  @override
  Widget build(BuildContext context) {
    var todoId = widget.todo!.id!;
    const List<String> choices = <String>[
      'Edit',
      'Delete',
    ];

    void choiceAction(String choice){
      String action = choice.split(":")[0];
      int? todoId = int.tryParse(choice.split(":")[1]);

      if(action == 'Edit'){
        print('Edit:$todoId');
      }else {
        DeleteTodo(todoId!);
        widget.refreshParentState();
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 0.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.green,
              value: widget.todo?.isDone != 0 ? true : false,
              onChanged: (value) {
                setState(() {
                  widget.todo?.isDone = value! ? 1 : 0;
                  UpdateTodo(widget.todo!);
                  print(widget.todo?.isDone);
                });
              },
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.todo?.title ?? "(isimsiz görev)",
                style: TextStyle(
                  color: Color(0xff5D4037),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ),
          /*Expanded(
            child: IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Increase volume by 10',
              onPressed: () {
                print('uwu');
              },
            ),
          ),*/
          Expanded(
            child: PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context){
                return choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: "$choice:$todoId",
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ),
        ],
      ),
    );
  }
}
