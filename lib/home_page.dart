import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/Guide.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/Notice.dart';
import 'package:myapp/Point.dart';
import 'package:myapp/parking.dart';
import 'package:myapp/services/geolocator_service.dart';
import 'Pay.dart';

class Second extends StatefulWidget {
  final locationService = geoLocatorService();
  final User user;

  Second(this.user);
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  void initState() {
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
      onQueryChanged: (query) {},
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
                            child: Column(
                              children: [
                                Text(
                                  widget.user.email,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                Text(
                                  "포인트 10000원",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
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
  GoogleMapController controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<MarkerId, Marker> markers2 = <MarkerId, Marker>{};

  @override
  void initState() {
    getMarkerData();
    getMarkerData2();
    super.initState();
  }

  getMarkerData() {
    FirebaseFirestore.instance
        .collection('parkingdata')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        initMarker(doc.data(), doc.id);
      });
    });
  }

  getMarkerData2() {
    FirebaseFirestore.instance
        .collection('sharedata')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        initMarker2(doc.data(), doc.id);
      });
    });
  }

  bool bToggle = true;
  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position:
            LatLng(specify['location'].latitude, specify['location'].longitude),
        infoWindow: InfoWindow(title: specify['name']),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            (bToggle) ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueRed),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
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
                        // Image.asset('image/parkingimage.jpg'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '이름 : ' + specify['name'] + "\n",
                              softWrap: true,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text('도로명주소 : ' + specify['roadname'] + "\n",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            Text('주차면수 : ' + specify['spot'] + "\n",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            Text('주차요금 : ' + specify['price'] + "\n",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            Text('결제방식 : ' + specify['pay'] + "\n",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            Text('전화번호 : ' + specify['phone'] + "\n",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),

                        FlatButton(
                          child: Text(
                            '닫기',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
    setState(() {
      markers[markerId] = marker;
    });
  }

  void initMarker2(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId2 = MarkerId(markerIdVal);
    final Marker marker2 = Marker(
        markerId: markerId2,
        position:
            LatLng(specify['location'].latitude, specify['location'].longitude),
        infoWindow: InfoWindow(title: specify['roadname']),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
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
                        // Image.asset('image/parkingimage.jpg'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset('image/parkingimage.jpg')
                            Image.network(specify['photourl']),

                            Text('도로명주소 : ' + specify['roadname'] + "\n",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            Text('운영시간 : ' + specify['time'] + "\n",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            Text('주차요금 : ' + specify['price'] + "\n",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            Text('전화번호 : ' + specify['phone'] + "\n",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),

                        FlatButton(
                            child: Text(
                              '이용하기',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                return Pay();
                              }));
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
    setState(() {
      markers[markerId2] = marker2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          markers: Set<Marker>.of(markers.values),
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(34.77588022750423, 127.7013315559743), zoom: 17),
          onMapCreated: (GoogleMapController controller) {
            controller = controller;
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