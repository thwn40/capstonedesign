import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:myapp/mypage.dart';

class Point extends StatefulWidget {
  final User user;

  Point(this.user);

  @override
  _PointState createState() => _PointState();
}

class _PointState extends State<Point> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '내정보',
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
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(children: [
                TextButton(
                    child: Text(
                      "   내 정보",
                      style: TextStyle(
                        // color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                        return Mypage(widget.user);
                      }));

                      // Icon(Icons.arrow_forward_ios),
                    }),
              ]),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 50,
              child: Container(
                child: Row(
                  children: [
                    Text(
                      "     포인트",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 50,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "     이용내역",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        ));
  }
}
