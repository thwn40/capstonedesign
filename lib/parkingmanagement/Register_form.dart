import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/home_page.dart';

// ignore: camel_case_types
class Register_form extends StatefulWidget {
  final User user;
  Register_form(this.user);

  @override
  Register_formState createState() => Register_formState();
}

// ignore: camel_case_types
class Register_formState extends State<Register_form> {
  final _phonetextEditingController = TextEditingController();

  final _timetextEditingController = TextEditingController();

  final _pricetextEditingController = TextEditingController();

  final _roadnametextEditingController = TextEditingController();
  final _nametextEditingController = TextEditingController();

  // ignore: unused_field
  final RegExp _regExp = RegExp(r'[\uac00-\ud7af]', unicode: true);

  DatabaseReference reference;

  File _image;

  @override
  // ignore: must_call_super
  void dispose() {
    _phonetextEditingController.dispose();
    _timetextEditingController.dispose();
    _pricetextEditingController.dispose();
    _roadnametextEditingController.dispose();
    _nametextEditingController.dispose();
    _phonetextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '공유주차장 등록',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('주차장이름',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              TextField(
                decoration: InputDecoration(hintText: 'ex)주차장이름을 입력하세요'),
                controller: _nametextEditingController,
              ),
               Text('핸드폰번호를 입력하세요',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              TextField(
                decoration: InputDecoration(hintText: 'ex)-없이 입력'),
                controller: _phonetextEditingController,
              ),
              Text('주차장 대여 가능 시간',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              TextField(
                decoration: InputDecoration(hintText: '   ex)20:00~24:00'),
                controller: _timetextEditingController,
              ),
              Text('시간당 이용요금',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              TextField(
                decoration: InputDecoration(hintText: '   ex)800원'),
                controller: _pricetextEditingController,
              ),
              Text('주소',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              TextField(
                decoration: InputDecoration(hintText: '   ex)서울시 노원구'),
                controller: _roadnametextEditingController,
              ),
              _image == null
                  ? Text('주차장 사진',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ))
                  : Image.file(_image),
              ElevatedButton(onPressed: _getImage, child: Text('사진첨부')),
              Container(
                child: (OutlinedButton(
                  onPressed: () {
                    final firebaseStorageRef = FirebaseStorage.instance
                        .ref()
                        .child('sharedata')
                        .child('${DateTime.now().millisecondsSinceEpoch}.png');

                    final task = firebaseStorageRef.putFile(
                      _image,
                    );

                    task.then((value) {
                      var downloadUrl = value.ref.getDownloadURL();

                      downloadUrl.then((uri) {
                        // ignore: unused_local_variable
                        var doc = FirebaseFirestore.instance
                            .collection('sharedata')
                            .doc(_nametextEditingController.text)
                            .set({
                          'name': _nametextEditingController.text,
                          'roadname': _roadnametextEditingController.text,
                          'phone': _phonetextEditingController.text,
                          'price': int.parse(_pricetextEditingController.text),
                          'time': _timetextEditingController.text,
                          'photourl': uri.toString(),
                          'email': widget.user.email,
                          'uid1': widget.user.uid,
                          'isreservation' : false,
                          'currentuseruid' : "",
                          'location': GeoPoint(locationin[0], locationin[1])
                        });
                      });
                      // 'ID': user.email.text
                    }).then((onValue) {
                      sleep(const Duration(milliseconds: 500));
                      Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                        return Second(widget.user);
                      }));
                    });
                    //Respond to button press
                  },
                  child: Text("등록하기"),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
if (image != null) {
setState(() {
      _image = File(image.path);
    });
}
    
  }
}
