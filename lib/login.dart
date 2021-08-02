import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';


//로그인부분
class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '주차여기어때',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.all(50.0),
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                _handleSignIn();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

//로그인 끝



//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   TextEditingController Controller = TextEditingController();
//   TextEditingController Controller2 = TextEditingController();

//   void _pushPage(BuildContext context, Widget page) {
//     Navigator.of(context) /*!*/ .push(
//       MaterialPageRoute<void>(builder: (_) => page),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: Builder(
//           builder: (context) {
//             return GestureDetector(
//               //제스처를 감지한다
//               onTap: () {
//                 FocusScope.of(context).unfocus(); // 하얀화면 누르면 키보드가 내려감
//               },
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: <Widget>[
//                     Form(
//                       child: Theme(
//                           data: ThemeData(
//                               inputDecorationTheme: InputDecorationTheme(
//                                   labelStyle: TextStyle(
//                                       color: Colors.cyan, fontSize: 15.0))),
//                           child: Container(
//                               padding: EdgeInsets.all(30.0),
//                               child: Column(
//                                 children: <Widget>[
//                                   Center(
//                                     child: Image(
//                                         image: AssetImage('image/logo.png')),
//                                   ),
//                                   TextField(
//                                     controller: Controller,
//                                     decoration: InputDecoration(
//                                         labelText: 'Enter "ID"'),
//                                     keyboardType: TextInputType.emailAddress,
//                                   ),
//                                   TextField(
//                                     controller: Controller2,
//                                     decoration: InputDecoration(
//                                         labelText: 'Enter "PassWord"'),
//                                     keyboardType: TextInputType.text,
//                                     obscureText: true,
//                                   ),
//                                   SizedBox(height: 40),
//                                   RaisedButton(
//                                       child: SignInButtonBuilder(
//                                     text: '로그인',
//                                     onPressed: () =>
//                                         _pushPage(context, SignInPage()),
//                                     // push에 전달되는 두 번째 매개변수는 Route<T> 클래스.
//                                   )

//                                       // 화살표 문법 적용
//                                       // Navigator.push(context,
//                                       // MaterialPageRoute<void>(builder: (BuildContext context) => Second())
//                                       // );

//                                       // 위와 같은 코드. of 메소드 호출이 불편하다.
//                                       // Navigator.of(context).push(
//                                       // MaterialPageRoute<void>(builder: (BuildContext context) => Second())
//                                       // );
//                                       ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Expanded(
//                                         child: FlatButton(
//                                             onPressed: () {},
//                                             child: Text('ID/PW 찾기')),
//                                       ),
//                                       Text('|'),
//                                       Expanded(
//                                         child: FlatButton(
//                                             onPressed: () {
//                                               Navigator.push(context,
//                                                   MaterialPageRoute<void>(
//                                                       builder: (BuildContext
//                                                           context) {
//                                                 return RegisterPage();
//                                               }));
//                                             },
//                                             child: Text('회원가입')),
//                                       ),
//                                       Text('|'),
//                                       // Expanded(
//                                       //   child: FlatButton(
//                                       //       onPressed: () {
//                                       //         Navigator.push(context,
//                                       //             MaterialPageRoute(builder:
//                                       //                 (BuildContext context) {
//                                       //           return Second();
//                                       //         }));
//                                       //       },
//                                       //       child: Text('비로그인 둘러보기')),
//                                       // ),
//                                     ],
//                                   ),
//                                   Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         SignInButton(
//                                           Buttons.Google,
//                                           onPressed: () {
//                                             _handleSignIn();
//                                           },
//                                         )
//                                       ])
//                                   // SignInButton(
//                                   //   Buttons.Google,
//                                   //   onPressed: signInWithGoogle,
//                                   // MaterialButton(
//                                   //   shape: CircleBorder(
//                                   //       side: BorderSide(
//                                   //           width: 1,
//                                   //           color: Colors.red,
//                                   //           style: BorderStyle.solid)),
//                                   //   onPressed: signInWithGoogle,
//                                   // )
//                                 ],
//                               ))),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ));
//   }

// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   // Create a new credential
//   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );