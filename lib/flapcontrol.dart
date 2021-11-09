import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:myapp/mypage/uselist.dart';

import 'package:webview_flutter/webview_flutter.dart';

class FlapControl extends StatefulWidget {
  final User user;
  FlapControl(this.user);

  @override
  _FlapControlState createState() => _FlapControlState();
}

class _FlapControlState extends State<FlapControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('플랩 컨트롤 페이지')),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("sharedata")
                .where('name', isEqualTo: parkingname)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data.docs[0]['ip']==null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else{
                return WebView(
                initialUrl: snapshot.data.docs[0]['ip'],
                javascriptMode: JavascriptMode.unrestricted,
              );
              }
             
            }),
      ),
    );
  }
}
