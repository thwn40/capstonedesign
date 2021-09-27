import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// class RForm {
//   String phonenumber;
//   String birth;
//   String address;
//   String carnumber;

//   RForm(this.phonenumber, this.birth, this.address, this.carnumber);
//   RForm.fromSnapshot(DataSnapshot snapshot)
//       : phonenumber = snapshot.value['phonenumber'],
//         birth = snapshot.value['birth'],
//         address = snapshot.value['address'],
//         carnumber = snapshot.value['address'];

//   toJson() {
//     return {
//       'phonenumber': phonenumber,
//       'birth': birth,
//       'address': address,
//       'carnumber': carnumber,
//     };
//   }
// }

class Register_form extends StatefulWidget {
  final User user;
  Register_form(this.user);
  @override
  _Register_formState createState() => _Register_formState();
}

class _Register_formState extends State<Register_form> {
  final _phonetextEditingController = TextEditingController();

  final _birthtextEditingController = TextEditingController();

  final _carnumbertextEditingController = TextEditingController();

  final _addresstextEditingController = TextEditingController();

  final RegExp _regExp = RegExp(r'[\uac00-\ud7af]', unicode: true);

  DatabaseReference reference;

  File _image;

  @override
  void dispose() {
    _phonetextEditingController.dispose();
    _birthtextEditingController.dispose();
    _carnumbertextEditingController.dispose();
    _addresstextEditingController.dispose();
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
                controller: _birthtextEditingController,
              ),
              Text('시간당 이용요금',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              TextField(
                decoration: InputDecoration(hintText: '   ex)800원'),
                controller: _carnumbertextEditingController,
              ),
              Text('주소',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              TextField(
                decoration: InputDecoration(hintText: '   ex)서울시 노원구'),
                controller: _addresstextEditingController,
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
                        .child('post')
                        .child('${DateTime.now().millisecondsSinceEpoch}.png');

                    final task = firebaseStorageRef.putFile(
                      _image,
                    );

                    task.then((value) {
                      var downloadUrl = value.ref.getDownloadURL();

                      downloadUrl.then((uri) {
                        var doc = FirebaseFirestore.instance
                            .collection('post')
                            .doc()
                            .set({
                          'address': _addresstextEditingController.text,
                          'phonenumber': _phonetextEditingController.text,
                          'carnumber': _carnumbertextEditingController.text,
                          'birth': _birthtextEditingController.text,
                          'photourl': uri.toString(),
                          'email': widget.user.email,
                        });
                      });
                      // 'ID': user.email.text
                    }).then((onValue) {
                      Navigator.pop(context);
                    });
                    ;
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
}
