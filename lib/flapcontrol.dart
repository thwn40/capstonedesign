import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DBref = FirebaseDatabase.instance.reference();
  int ledStatus = 0;
  bool isLoading = false;

  getLEDStatus() async {
    await DBref.child('LED_STATUS').once().then((DataSnapshot snapshot) {
      ledStatus = snapshot.value;
      print(ledStatus);
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    isLoading = true;
    getLEDStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IOT App',
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : RaisedButton(
                child: Text(
                  ledStatus == 0 ? 'On' : 'Off',
                ),
                onPressed: () {
                  buttonPressed();
                },
              ),
      ),
    );
  }

  void buttonPressed() {
    ledStatus == 0
        ? DBref.child('LED_STATUS').set(1)
        : DBref.child('LED_STATUS').set(0);
    if (ledStatus == 0) {
      setState(() {
        ledStatus = 1;
      });
    } else {
      setState(() {
        ledStatus = 0;
      });
    }
  }
}