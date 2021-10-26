import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.purple,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: HomePage());
//   }
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DBref = FirebaseDatabase.instance.reference();
  int flapStatus = 0;
  bool isLoading = false;

  getFlapStatus() async {
    await DBref.child('flap').once().then((DataSnapshot snapshot) {
      flapStatus = snapshot.value;
      print(flapStatus);
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    isLoading = true;
    getFlapStatus();
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
                  flapStatus == 0 ? 'On' : 'Off',
                ),
                onPressed: () {
                  buttonPressed();
                },
              ),
      ),
    );
  }

  void buttonPressed() {
    flapStatus == 0
        ? DBref.child('Flap_STATUS').set(1)
        : DBref.child('Flap_STATUS').set(0);
    if (flapStatus == 0) {
      setState(() {
        flapStatus = 1;
      });
    } else {
      setState(() {
        flapStatus = 0;
      });
    }
  }
}