

import 'package:flutter/material.dart';



class CreateJuchaselect2 extends StatefulWidget {
  @override
  _CreateJuchaselect2State createState() => _CreateJuchaselect2State();
}

class _CreateJuchaselect2State extends State<CreateJuchaselect2> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('고객센터')),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              controller: controller1,
              decoration: InputDecoration(
                filled: true,
                hintText: "주차장 이름을 입력하세요.",
              ),
              minLines: 1,
              maxLines: 1,
              maxLength: 8,
              onChanged: (String value) {
                //inputValue = value;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              controller: controller1,
              decoration: InputDecoration(
                filled: true,
                hintText: "주차장 이름을 입력하세요.",
              ),
              minLines: 1,
              maxLines: 1,
              maxLength: 8,
              onChanged: (String value) {
                //inputValue = value;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              controller: controller1,
              decoration: InputDecoration(
                filled: true,
                hintText: "주소를 입력하세요",
              ),
              minLines: 1,
              maxLines: 1,
              maxLength: 8,
              onChanged: (String value) {
                //inputValue = value;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              controller: controller1,
              decoration: InputDecoration(
                filled: true,
                hintText: "주차면수를 입력하세요",
              ),
              minLines: 1,
              maxLines: 1,
              maxLength: 8,
              onChanged: (String value) {
                //inputValue = value;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              controller: controller1,
              decoration: InputDecoration(
                filled: true,
                hintText: "주차장 사진을 등록하세요",
              ),
              minLines: 1,
              maxLines: 1,
              maxLength: 8,
              onChanged: (String value) {
                //inputValue = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
//주차장 이름 주소 주차면수 요금 사진 등록