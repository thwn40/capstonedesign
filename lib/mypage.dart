import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Point.dart';

class Mypage extends StatefulWidget {
  final User user;

  Mypage(this.user);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '프로필',
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
        children: <Widget>[
          SizedBox(
            height: 50,
            child: Container(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(widget.user.photoURL),
                    radius: 30,
                  ),
                  Text(
                    widget.user.email,
                    style: TextStyle(color: Colors.black, fontSize: 10.0),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Text(
                  "차량번호",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Text(
                  "핸드폰번호",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
