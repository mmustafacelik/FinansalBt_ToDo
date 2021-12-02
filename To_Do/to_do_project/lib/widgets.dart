import 'package:flutter/material.dart';
import 'package:to_do_project/screens/taskpage.dart';
import 'package:flutter_switch/flutter_switch.dart';

class TaskCardWidget extends StatelessWidget {
  final String? title;
  final String? description;
  const TaskCardWidget({this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Taskpage(),
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
                title ?? "(İsimsiz Başlık)",
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
                  description ?? ("Yapılacak iş eklenmedi."),
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
  Todo(
      {Key? key,
      this.text,
      this.isDone,
      this.checkvalue = false,
      this.isSwitched = false})
      : super(key: key);
  final String? text;
  final bool? isDone;
  bool isSwitched = false;
  bool checkvalue = false;
  @override
  _TodoState createState() => _TodoState();
}

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
            value: widget.checkvalue,
            onChanged: (value) {
              setState(() {
                widget.checkvalue = value!;
                print(widget.checkvalue);
              });
            },
          ),
          Text(
            widget.text ?? "(isimsiz görev)",
            style: TextStyle(
              color: Color(0xff5D4037),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: Switch(
              value: widget.isSwitched,
              onChanged: (value) {
                setState(() {
                  widget.isSwitched = value;
                  print(widget.isSwitched);
                });
              },
              activeTrackColor: Color(0xff03a9f4),
              activeColor: Colors.blue,
              activeThumbImage: AssetImage("assets/images/cloudy_aktif.png"),
              inactiveThumbImage:
                  AssetImage("assets/images/cloudy_inaktif.png"),
            ),
          ),
        ],
      ),
    );
  }
}
