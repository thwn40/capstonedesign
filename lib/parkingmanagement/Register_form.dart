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
import 'package:myapp/main.dart';
import 'package:myapp/search.dart';
import 'dart:io';


class Register_form extends StatefulWidget {
  final User user;
  Register_form(this.user);

  @override
  _Register_formState createState() => _Register_formState();
}

class _Register_formState extends State<Register_form> {
  final _phonetextEditingController = TextEditingController();

  final _timetextEditingController = TextEditingController();

  final _pricetextEditingController = TextEditingController();

  final _roadnametextEditingController = TextEditingController();

  final RegExp _regExp = RegExp(r'[\uac00-\ud7af]', unicode: true);

  DatabaseReference reference;

  File _image;

  @override
  void dispose() {
    _phonetextEditingController.dispose();
    _timetextEditingController.dispose();
    _pricetextEditingController.dispose();
    _roadnametextEditingController.dispose();
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
              Text('휴대폰 번호',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              TextField(
                decoration: InputDecoration(hintText: '   -를 생략해주세요'),
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
                        var doc = FirebaseFirestore.instance
                            .collection('sharedata')
                            .doc()
                            .set({
                          'roadname': _roadnametextEditingController.text,
                          'phone': _phonetextEditingController.text,
                          'price': _pricetextEditingController.text,
                          'time': _timetextEditingController.text,
                          'photourl': uri.toString(),
                          'email': widget.user.email,
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
