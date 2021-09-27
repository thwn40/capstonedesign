import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/Guide.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/Notice.dart';
import 'package:myapp/Point.dart';
import 'package:myapp/parking.dart';
import 'package:myapp/Pay.dart';

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

  Widget buildFloatingSearchBar(BuildContext context) {
    final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
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
                                  color: Colors.white, fontSize: 12.0),
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
                  '내정보',
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
                    return Parking(widget.user);
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

//구글맵 시작
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<GoogleMapController> _controller = Completer();

  static final chonam = CameraPosition(
    target: LatLng(34.776408495461844, 127.70128473003452),
    zoom: 17,
  );
  List<Marker> _markers = [];
  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
        markerId: MarkerId("1"),
        draggable: true,
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: BottomSheetExample(),
              ),
            ),
          );
        },
        position: LatLng(34.776408495461844, 127.70128473003452)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          mapType: MapType.normal,
          markers: Set.from(_markers),
          initialCameraPosition: chonam,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationButtonEnabled: false,
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
//구글맵 끝

class BottomSheetExample extends StatefulWidget {
  @override
  _BottomSheetExampleState createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('post')
        .where("address", isEqualTo: "address")
        .get()
        .then((QuerySnapshot ds) {
      ds.docs.forEach((doc) => print(doc["address"]));
    });

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Text(
              '2공학관 주차장',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Image.asset('image/parkingimage.jpg'),
            Row(
              children: [
                Text(
                  "공지사항"

                  ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            FlatButton(
              child: Text(
                '이용하기',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Pay();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
