import 'package:flutter/material.dart';
import 'package:myapp/main.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Column(children: <Widget>[
        Text(
        '공유할 주차공간의 유형을 선택해주세요',
        style: TextStyle(fontSize: 18, height: 1),
      ),
        IconButton(
          icon: Image.asset('image/share.jpg'),
          iconSize: 50,
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset('image/share.jpg'),
          iconSize: 50,
          onPressed: () {},
        ),


    ]
    )
    );
  }
}
