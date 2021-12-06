import 'package:flutter/material.dart';
import 'package:to_do_project/models/task.dart';


class TaskCard extends StatefulWidget {
  late Task? task;
  TaskCard({
    Key? key,
    this.task
  }) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 28.0, right: 24.0, left: 24.0, bottom: 12.0),
        margin: EdgeInsets.only(
          bottom: 25,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff2e2e2e),//Görev Listesi homepagedeki renkler
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Text(
              widget.task?.title ?? "(İsimsiz Başlık)",
              style: const TextStyle(
                  color: Color(0xff686868),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              child: Text(
                widget.task?.description ?? (""),
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16.0,
                  color: Color(0xFF616161),
                  height: 1.5,
                ),
              ),
            ),
            Container(
              child: Align (
                alignment: Alignment.centerRight,
                child: Switch(
                  value: true,
                  onChanged: (value) {
                    setState(() {
                    });
                  },
                  activeTrackColor: Color(0xff554cff),
                  activeColor: Colors.amber,
                  activeThumbImage: AssetImage("assets/images/cloudy_aktif.png"),
                  inactiveThumbImage:
                  AssetImage("assets/images/cloudy_inaktif.png"),
                ),
              )
            ),
          ],
        ),
      );
  }
}
