import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      body: Text('포인트기능 추가'),
      
    );
  }
}


