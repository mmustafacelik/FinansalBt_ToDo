import 'package:flutter/material.dart';
import 'package:to_do_project/screens/taskpage.dart';
import 'package:to_do_project/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Taskpage(),
            ),
          );
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
                    child: ListView(
                      children: [
                        TaskCardWidget(
                          title: "Birinci",
                          description:
                              "Merhabalar buraya ana başlık altında yapmanız gerekenleri yazabilirsiniz",
                        ),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                      ],
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
