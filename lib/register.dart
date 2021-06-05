import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/parking.dart';

class Register extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '내 공유주차장 고르기',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            backgroundColor: Colors.cyan,
            elevation: 0,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "거주자우선",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "일반주차",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Tab(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                      child: Image.asset("image/juchaselect1.png"),
                      height: 350),
                  TextButton(
                    child: Text(
                      "거주자우선주차고르기",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ],
              )),
              Tab(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                    child: Image.asset(
                      "image/juchaselect2.png",
                    ),
                    height: 350,
                  ),
                  TextButton(
                    child: Text(
                      "원룸/빌라형 고르기",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
