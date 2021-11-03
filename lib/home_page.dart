import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/flapcontrol.dart';
import 'package:myapp/guide/Guide.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/notice/Notice.dart';
import 'package:myapp/mypage/Point.dart';
import 'package:myapp/parkingmanagement/Parking.dart';
import 'package:myapp/parkingmanagement/register.dart';
import 'package:intl/intl.dart';

import 'mypage/mypagecreate.dart';
import 'package:place_picker/place_picker.dart';

var latitudein, longitudein, locationin, user;
String value1 = "30분";
int value2 = 0;
int value3 = 0;
int price1 = 0;
String roadname = "";
String a = "";
String uid1 = "";
int pointpay = 0;


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
    super.initState();
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    void _openDrawer() {
      _drawerKey.currentState.openDrawer();
    }

    FirebaseFirestore.instance.collection('user').doc();

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
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(widget.user.photoURL),
                radius: 30.0,
              ),
              accountName: Text(widget.user.email),
              accountEmail: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where('uid', isEqualTo: widget.user.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.data == null) {return CircularProgressIndicator();}
                    return Text(
                        ("포인트: ${NumberFormat('###,###,###,###').format(snapshot.data.docs[0]['point'])}원")
                            .toString()
                            .replaceAll("\\n", "\n"),
                        style: TextStyle(
                          fontSize: 13,
                        ));
                  }),
              otherAccountsPictures: [
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  color: Colors.black,
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    _googleSignIn.signOut();
                  },
                ),
              ],
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  )),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(
                    '내정보',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Mypage(widget.user)),
                        );
                      },
                      child: Text("추가",
                          style: TextStyle(
                            fontSize: 13,
                          ))),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return Point(widget.user);
                    }));
                  }),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                  leading: Icon(Icons.local_parking),
                  title: Text(
                    '공유주차장 관리',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return Parking(widget.user);
                    }));
                  }),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                  leading: Icon(Icons.notifications_none),
                  title: Text(
                    '공지사항',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return Notice(widget.user);
                    }));
                  }),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                  leading: Icon(Icons.headset_mic),
                  title: Text(
                    '서비스 이용안내',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return Guide();
                    }));
                  }),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    '설정',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return FlapControl();
                    }));
                  }),
            ),
          ],
        ),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          MyHomePage(widget.user),
          buildFloatingSearchBar(context),
        ],
      ),
    );
  }
}

//구글맵 시작
class MyHomePage extends StatefulWidget {
  final User user;

  MyHomePage(this.user);
  @override
  _MyHomePageState createState() => _MyHomePageState();

  static void getMarkerData2() {}
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
                            Text('주차요금 : ' + specify['price'] + "원 \n",
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

  Widget isreservation(specify) {
    if (specify['isreservation'] == true) {
      return Text("예약중인 주차장입니다",
          softWrap: true,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
    } else {}
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
          price1 = specify['price'];
          roadname = specify['roadname'];
          uid1 = specify['uid1'];
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(specify['photourl'],
                                  width: 230, height: 180, fit: BoxFit.fill),
                            ),
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
                            Text('주차요금 : ' + specify['price'].toString() + "원 \n",
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
                              '결제 후 이용하기',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    '주차장 이름 : ' +
                                                        specify['roadname'],
                                                    softWrap: true,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    )),
                                                StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("users")
                                                        .where('uid',
                                                            isEqualTo:
                                                                widget.user.uid)
                                                        .snapshots(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            snapshot) {
                                                      int point = snapshot.data
                                                          .docs[0]['point'];
                                                      return Column(
                                                        children: [
                                                          Text(
                                                              ("포인트: ${NumberFormat('###,###,###,###').format(snapshot.data.docs[0]['point'])}원")
                                                                  .toString()
                                                                  .replaceAll(
                                                                      "\\n",
                                                                      "\n"),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                              )),
                                                          Dropdown(widget.user),
                                                          FlatButton(
                                                              disabledColor:
                                                                  Colors.black,
                                                              child: Text(
                                                                '구매하기',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              color:
                                                                  Colors.blue,
                                                              onPressed: () {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .doc(widget
                                                                        .user
                                                                        .uid)
                                                                    .update({
                                                                  'point': point -
                                                                      (((price1 / 2)
                                                                              .toInt()) *
                                                                          value3),

                                                                  // 'ID': user.email.text
                                                                }).then((onValue) {});
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .doc(uid1)
                                                                    .update({
                                                                  'point': FieldValue.increment(
                                                                      (((price1 / 2)
                                                                              .toInt()) *
                                                                          value3)),

                                                                  // 'ID': user.email.text
                                                                }).then((onValue) {});
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'history')
                                                                    .doc()
                                                                    .set({
                                                                  'name' : specify['name'],
                                                                  'pay': FieldValue.increment(
                                                                      (((price1 / 2)
                                                                              .toInt()) *
                                                                          value3)),
                                                                  'outuid' :  widget.user.uid,
                                                                  'inuid' :  uid1,
                                                                   'outuidpoint' : point -
                                                                      (((price1 / 2)
                                                                              .toInt()) *
                                                                          value3),
                                                                  'inuidpoint' :  point +
                                                                      (((price1 / 2)
                                                                              .toInt()) *
                                                                          value3),
                                                                  'time': DateTime.now(),

                                                                  // 'ID': user.email.text
                                                                }).then((onValue) {});
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        false,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            '팝업 메시지'),
                                                                        content:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              ListBody(
                                                                            children: <Widget>[
                                                                              Text('예약이 완료되었습니다.')
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        actions: <
                                                                            Widget>[
                                                                          FlatButton(
                                                                              child: Text('확인'),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                                Navigator.of(context).pop();
                                                                              })
                                                                        ],
                                                                      );
                                                                    });
                                                              }),
                                                        ],
                                                      );
                                                    }),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
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
            myLocationButtonEnabled: true,
            compassEnabled: true,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            onTap: (latLng) {
              double latitudein = latLng.latitude;
              double longitudein = latLng.longitude;
              locationin = [latitudein, longitudein];

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  backgroundColor: Colors.blue,
                  duration: const Duration(milliseconds: 700),
                  content: TextButton(
                    child:
                        Text('이곳에 공유주차장 등록하기', style: TextStyle(fontSize: 21)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(widget.user),
                          ));
                      return locationin;
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class Dropdown extends StatefulWidget {
  int value2 = 0;

  final User user;
  Dropdown(this.user);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    value3 = value1tovalue2(value1);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("사용시간 : "),
            DropdownButton<String>(
              value: value1,
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (value) => setState(() => value1 = value),
              items: <String>[
                '30분',
                '1시간',
                '1시간 30분',
                '2시간',
                '2시간 30분',
                '3시간',
                '3시간 30분',
                '4시간',
                '4시간 30분',
                '5시간',
                '5시간 30분',
                '6시간',
                '6시간 30분',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15),
                      )),
                );
              }).toList(),
            ),
          ],
        ),
        Text("결제금액 : " +
            ((price1 / 2).toInt() * value1tovalue2(value1)).toString() +
            "원"),
      ],
    );
  }

  value1tovalue2(value1) {
    if (value1 == '30분')
      return value2 = 1;
    else if (value1 == '1시간')
      return value2 = 2;
    else if (value1 == '1시간 30분')
      return value2 = 3;
    else if (value1 == '2시간')
      return value2 = 4;
    else if (value1 == '2시간 30분')
      return value2 = 5;
    else if (value1 == '3시간')
      return value2 = 6;
    else if (value1 == '3시간 30분')
      return value2 = 7;
    else if (value1 == '4시간')
      return value2 = 8;
    else if (value1 == '4시간 30분')
      return value2 = 9;
    else if (value1 == '5시간')
      return value2 = 10;
    else if (value1 == '5시간 30분')
      return value2 = 11;
    else if (value1 == '6시간')
      return value2 = 12;
    else if (value1 == '6시간 30분') return value2 = 13;
  }
}
