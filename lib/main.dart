import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:myapp/settings.dart';
import 'package:myapp/register.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:myapp/login.dart';
import 'package:myapp/search.dart';
import 'package:myapp/guide.dart';
import 'package:myapp/notice.dart';
import 'package:myapp/Point.dart';
import 'package:myapp/parking.dart';
import 'package:myapp/settings.dart';
import 'package:myapp/signin_page.dart';
import 'root_page.dart';

import 'custome_center.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
<<<<<<< HEAD
  runApp(MaterialApp(title: '네비게이션', home: LogIn()));
=======
  // Uncomment this to use the auth emulator for testing
  // await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  runApp(MyApp());
>>>>>>> a7072e79cb7e5b190bbaf9a706f099eb26ed5d5c
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      //drawer 시작

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          // backgroundImage: NetworkImage(
                          //     'http://www.bbk.ac.uk/mce/wp-content/uploads/2015/03/8327142885_9b447935ff.jpg'),
                          radius: 40.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.2, 0.0),
                        child: TextButton(
                            onPressed: () {
                              final User user = _auth.currentUser;

                              while (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              '${user.email}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            )),
                      ),
                    ],
                  ),
                ),
                height: 150),
            ListTile(
                title: Text(
                  '포인트',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Point();
                  }));
                }),
            ListTile(
                title: Text(
                  '공유주차장 관리',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Parking();
                  }));
                }),
            ListTile(
                title: Text(
                  '공지사항',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Notice();
                  }));
                }),
            ListTile(
                title: Text(
                  '서비스 이용안내',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Guide();
                  }));
                }),
            ListTile(
                title: Text(
                  '고객센터',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return CustomerCenter();
                  }));
                }),
            ListTile(
                title: Text(
                  '설정',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Settings();
                  }));
                }),
          ],
        ),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          MyHomePage(),
          buildFloatingSearchBar(context),
        ],
=======
    print('MyApp created');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.black,
>>>>>>> a7072e79cb7e5b190bbaf9a706f099eb26ed5d5c
      ),
      home: RootPage(),
    );
  }
}

// 메인페이지부분 시작
