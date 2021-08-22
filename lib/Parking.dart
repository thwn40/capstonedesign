import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:myapp/register.dart';

class Parking extends StatefulWidget {
  final User user;
  Parking(this.user);

  @override
  _ParkingState createState() => _ParkingState();
}

class _ParkingState extends State<Parking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '내 공유주차장',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("주차장을 등록하고싶으시면 아래의 버튼을 눌러주세요.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                  child: Text('주차장 등록하기',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      )),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return Register(widget.user);
                    }));
                  }),
            ])));
  }
}
