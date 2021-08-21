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

import 'root_page.dart';

import 'custome_center.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Uncomment this to use the auth emulator for testing
  // await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('MyApp created');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      home: RootPage(),
    );
  }
}

// 메인페이지부분 시작
