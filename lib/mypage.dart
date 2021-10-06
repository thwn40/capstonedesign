import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Point.dart';

class Mypage extends StatefulWidget {
  final User user;

  Mypage(this.user);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  final formkey = GlobalKey<FormState>();

  String phone = '';
  String price = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '프로필',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
              child: Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(widget.user.photoURL),
                      radius: 30,
                    ),
                    Text(
                      widget.user.email,
                      style: TextStyle(color: Colors.black, fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ),
            Form(
                key: this.formkey,
                child: Column(
                  children: [
                    renderTextFormField(
                        label: "차량번호",
                        onSaved: (val) {
                          setState(() {
                            this.price = val;
                          });
                        },
                        validator: (val) {
                          return null;
                        }),
                    renderTextFormField(
                        label: "핸드폰번호",
                        onSaved: (val) {
                          setState(() {
                            this.phone = val;
                          });
                        },
                        validator: (val) {
                          if (val.length < 1) {
                            return '핸드폰번호는 필수사항입니다.';
                          }

                          return null;
                        }),
                    renderSubmitButton(),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  renderSubmitButton() {
    return RaisedButton(
      color: Colors.blue,
      onPressed: () {
        if (this.formkey.currentState.validate()) {
          this.formkey.currentState.save();
          FirebaseFirestore.instance.collection('forms').doc().set({
            'phonen': '$phone',
            'price': '$price',
            'id': widget.user
            // 'ID': user.email.text
          }).then((onValue) {
            Navigator.pop(context);
          });

          Get.snackbar(
            '저장성공',
            '폼이 저장되었습니다!',
            backgroundColor: Colors.white,
          );
        }
      },
      child: Text(
        '저장하기!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  renderTextFormField({
    @required String label,
    @required FormFieldSetter onSaved,
    @required FormFieldValidator validator,
  }) {
    assert(label != null);
    assert(onSaved != null);
    assert(validator != null);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          TextFormField(
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: AutovalidateMode.always,
          ),
          Container(height: 16.0),
        ],
      ),
    );
  }
  // Widget  _buildBody(){
  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance.collection('forms').snapshots(),

  //     builder: BuildContext context, Async)
}
