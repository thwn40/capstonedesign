// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:myapp/settings.dart';
import 'package:myapp/guide.dart';
import 'package:myapp/notice.dart';
import 'package:myapp/Point.dart';
import 'package:myapp/parking.dart';
import 'custome_center.dart';

class Second extends StatefulWidget {
  final User user;

  Second(this.user);
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  void initState() {
    // _auth.userChanges().listen((event) => setState(() => user = event));
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //drawer 시작

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage('widget.user.photoURL'),
                          radius: 40.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.2, 0.0),
                        child: TextButton(
                            onPressed: () {
                              //final User user = _auth.currentUser;

                              while (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              widget.user.email,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            )),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.exit_to_app),
                            color: Colors.black,
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              _googleSignIn.signOut();
                            },
                          ))
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
                    return Point(widget.user);
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
                  '설정',
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
          ],
        ),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          MyHomePage(),
          buildFloatingSearchBar(context),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<GoogleMapController> _controller = Completer();

  static final gwanghwamun = CameraPosition(
    target: LatLng(34.776408495461844, 127.70128473003452),
    zoom: 17,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: gwanghwamun,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          compassEnabled: true,
          zoomGesturesEnabled: true,
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
        ),
      ),
    );
  }
}

Widget buildFloatingSearchBar(BuildContext context) {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  void _openDrawer() {
    _drawerKey.currentState.openDrawer();
  }

  return FloatingSearchBar(
    automaticallyImplyBackButton: false,
    hint: 'Search...',
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: isPortrait ? 0.0 : -1.0,
    openAxisAlignment: 0.0,
    width: isPortrait ? 600 : 500,
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) {
      // Call your model, bloc, controller here.
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    key: _drawerKey,
    transition: CircularFloatingSearchBarTransition(),

    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Colors.accents.map((color) {
              return Container(height: 112, color: color);
            }).toList(),
          ),
        ),
      );
    },
  );
}
