import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Notice extends StatefulWidget {
    final User user;

  Notice(this.user);
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공지사항')),
      body: Center(
        child: TextButton(
          child: Text("카카오맵 열기"),
      onPressed: () async{
        try{
        await launch("kakaomap://open?page=routeSearch");
      }
      catch(e) {
        Fluttertoast.showToast(msg: "카카오맵이 설치되어있어야 합니다.",toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
        await launch("kakaomap://");}
      },
      ),
      ),
    );
  }
}