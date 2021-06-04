import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/register.dart';

class Parking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('공유주차장 관리')),
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          RaisedButton(
              child: Text('주차장 등록하기'),
              textColor: Colors.black,
              color: Colors.white10,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Register();
                }));
              }
              //
              //
              //
              )
        ])));
  }
}
