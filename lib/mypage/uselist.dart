import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/flapcontrol.dart';
String parkingname = "";

// ignore: camel_case_types
class userlist extends StatefulWidget {
  final User user;
  userlist(this.user);

  @override
  _userlistState createState() => _userlistState();
}

// ignore: camel_case_types
class _userlistState extends State<userlist> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '이용내역',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            backgroundColor: Colors.cyan,
            elevation: 0,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "포인트 내역",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "예약목록",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Tab(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(
                        'history',
                      )
                      .where("outuid", isEqualTo: widget.user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.docs[index];
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          "        ${ds['name']}              "),
                                      Text(DateFormat('M-d HH:mm')
                                          .format(ds['time'].toDate())),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          "           결제한 금액: ${ds['pay'].toString()}원"),
                                      Text(
                                          "           남은 포인트: ${ds['outuidpoint'].toString()}원"),
                                    ],
                                  ),
                                ],
                              ),
                              Text("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                            ],
                          );
                        },
                      );
                  },
                ),
              ),
              Tab(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(
                        'history',
                      )
                      .where("outuid", isEqualTo: widget.user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.docs[index];
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          "        ${ds['name']}              "),
                                      Text("${DateFormat('MM-d HH:mm').format(ds['time'].toDate())}" +
                                          "~" +
                                          "${DateFormat('HH:mm').format(ds['time'].toDate().add(Duration(minutes: ((ds['pay'] / ds['price1']).toInt()) * 30)))}"),
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        parkingname = ds['name'];
                                        Navigator.push(context,
                                            MaterialPageRoute<void>(builder:
                                                (BuildContext context) {
                                          return FlapControl(widget.user);
                                        }));
                                      },
                                      child: Text("제어"))
                                ],
                              ),
                              Text("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                            ],
                          );
                        },
                      );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
