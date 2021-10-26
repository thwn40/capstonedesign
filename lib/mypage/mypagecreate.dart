
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mypage extends StatefulWidget {
  final User user;

  Mypage(this.user);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  final formkey = GlobalKey<FormState>();

  String phone = '';
  String carnumber = '';

  @override
  Widget build(BuildContext context) {
    

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(resizeToAvoidBottomInset: false,
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
            form(),
          ],
        ),
      ),
    );
  }

  form() {
    return Form(
        key: this.formkey,
        child: Column(
          children: [
            renderTextFormField(
                label: "차량번호",
              
                onSaved: (val) {
                  setState(() {
                    this.carnumber = val;
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
        ));
  }

  renderSubmitButton() {
    return RaisedButton(
      color: Colors.blue,
      onPressed: () {
        if (this.formkey.currentState.validate()) {
          this.formkey.currentState.save();
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user.uid)
              .update({
            'phone': '$phone',
            'carnumber': '$carnumber',
            'uid': widget.user.uid
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
}

// class Mypage2 extends StatefulWidget {
//   @override
//   _MypageState createState() => _MypageState();
// }

// class _Mypage2State extends State<Mypage> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             '프로필',
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.black,
//             ),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 50,
//               child: Container(
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Colors.white,
//                       backgroundImage: NetworkImage(widget.user.photoURL),
//                       radius: 30,
//                     ),
//                     Text(
//                       widget.user.email,
//                       style: TextStyle(color: Colors.black, fontSize: 10.0),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RootPage2 extends StatefulWidget {
//   @override
//   _RootPage2State createState() => _RootPage2State();
// }

// class _RootPage2State extends State<RootPage2> {
  

//   @override
//   Widget build(BuildContext context) {
//     print('root_page created');
//     return _handleCurrentScreen();
//   }

//   Widget _handleCurrentScreen() {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: widget.user.uid).snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return LoadingPage();
//         } else {
//           if (snapshot.hasData) {
//             return Second(snapshot.data);
//           }
//           return LogIn();
//         }
//       },
//     );
//   }
// }
