import 'package:flutter/material.dart';
import 'package:to_do_project/models/task.dart';

class TaskCardWidget extends StatelessWidget {
  late Task? task;

  TaskCardWidget({Key? key, this.task}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      Container(
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
              textAlign: TextAlign.center,
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
      );
  }
}
