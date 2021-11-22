import 'package:flutter/material.dart';
import 'package:to_do_project/screens/homepage.dart';
import 'package:to_do_project/widgets.dart';

class Taskpage extends StatefulWidget {
  Taskpage({Key? key}) : super(key: key);

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
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
                            decoration: const InputDecoration(
                              hintText: "Görev başlığı girebilirsiniz...",
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
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText:
                            "Görevle ilgili küçük notları buraya yazabilirsiniz.",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Todo(
                        yazi: "1.yazi",
                      ),
                      Todo(
                        yazi: "2.yazi",
                      ),
                      Todo(
                        yazi: "3.yazi ",
                      ),
                      Todo(),
                      Todo(),
                      Todo(),
                    ],
                  ))
                ],
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: FloatingActionButton(
                  backgroundColor: Color(0xff19C8F6),
                  child: const Icon(
                    Icons.delete_forever,
                    size: 25.0,
                    color: Color(0xffFFECB3),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ),
                    );
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
