import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:myapp/home_page.dart';

class Pay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CheckBoxInListView(title: '2공학관 주차장'),
    );
  }
}

class CheckBoxInListView extends StatefulWidget {
  CheckBoxInListView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CheckBoxInListViewState createState() => _CheckBoxInListViewState();
}

class _CheckBoxInListViewState extends State<CheckBoxInListView> {
  //bool _isChecked = false;

  List<String> _texts = [
    "1타임 09:00 ~ 09:50",
    "2타임 10:00 ~ 10:50",
    "3타임 11:00 ~ 11:50",
    "4타임 12:00 ~ 12:50",
    "5타임 13:00 ~ 13:50",
    "6타임 14:00 ~ 14:50",
    "7타임 15:00 ~ 15:50",
    "8타임 16:00 ~ 16:50",
    "9타임 17:00 ~ 17:50",
    "10타임 18:00 ~ 18:50",
    "11타임 19:00 ~ 19:50",
    "12타임 20:00 ~ 20:50"
  ];

  List<bool> _isChecked;

  @override
  void initState() {
    MyHomePage.getMarkerData2();
    super.initState();
    _isChecked = List<bool>.filled(_texts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('test'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _texts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: CheckboxListTile(
                      title: Text(_texts[index]),
                      value: _isChecked[index],
                      onChanged: (val) {
                        setState(
                          () {
                            _isChecked[index] = val;
                            print(index);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text('결제하기'),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: BottomSheetExample(),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }

}

class BottomSheetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  '주차시간 :',
                  

                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            FlatButton(
                child: Text(
                  '구매하기',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
