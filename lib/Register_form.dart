import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/main.dart';
import 'package:myapp/parking.dart';

class RForm {
  String phonenumber;
  String birth;
  String address;
  String carnumber;

  RForm(this.phonenumber, this.birth, this.address, this.carnumber);
  RForm.fromSnapshot(DataSnapshot snapshot)
      : phonenumber = snapshot.value['phonenumber'],
        birth = snapshot.value['birth'],
        address = snapshot.value['address'],
        carnumber = snapshot.value['address'];

  toJson() {
    return {
      'phonenumber': phonenumber,
      'birth': birth,
      'address': address,
      'carnumber': carnumber,
    };
  }
}

class Register_form extends StatelessWidget {
  final _phonetextEditingController = TextEditingController();
  final _birthtextEditingController = TextEditingController();
  final _carnumbertextEditingController = TextEditingController();
  final _addresstextEditingController = TextEditingController();

  FirebaseDatabase _database;
  DatabaseReference reference;
  String _databaseURL =
      'https://balmy-virtue-314416-default-rtdb.firebaseio.com/';

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
      resizeToAvoidBottomInset: false,
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
            Text('생년월일',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                )),
            TextField(
              decoration: InputDecoration(hintText: '   ex)19970728'),
              controller: _birthtextEditingController,
            ),
            Text('차량번호',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                )),
            TextField(
              decoration: InputDecoration(hintText: '   12다3456 (지역명 있으면 포함)'),
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
            Container(
              child: (OutlinedButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection('forms').doc().set({
                    'address': _addresstextEditingController.text,
                    'phonenumber': _phonetextEditingController.text,
                    'carnumber': _carnumbertextEditingController.text,
                    'birth': _birthtextEditingController.text,
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
    );
  }
}
