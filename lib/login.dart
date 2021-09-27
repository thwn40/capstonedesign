import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Builder(
          builder: (context) {
            return GestureDetector(
              //제스처를 감지한다
              onTap: () {
                FocusScope.of(context).unfocus(); // 하얀화면 누르면 키보드가 내려감
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Form(
                      child: Theme(
                          data: ThemeData(
                              inputDecorationTheme: InputDecorationTheme(
                                  labelStyle: TextStyle(
                                      color: Colors.cyan, fontSize: 15.0))),
                          child: Container(
                              padding: EdgeInsets.all(30.0),
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Image(
                                        image: AssetImage('image/logo.png')),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        labelText: 'Enter "ID"'),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        labelText: 'Enter "PassWord"'),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 40),
                                  RaisedButton(
                                    child: Text('로그인',
                                        style: TextStyle(fontSize: 21)),
                                    color: Colors.cyan,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(16)),
                                    ),
                                    onPressed: () {},
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: FlatButton(
                                            onPressed: () {},
                                            child: Text('ID/PW 찾기')),
                                      ),
                                      Text('|'),
                                      Expanded(
                                        child: FlatButton(
                                            onPressed: () {},
                                            child: Text('회원가입')),
                                      ),
                                      Text('|'),
                                      Expanded(
                                        child: FlatButton(
                                            onPressed: () {},
                                            child: Text('비로그인 둘러보기')),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SignInButton(
                                        Buttons.Google,
                                        onPressed: () {
                                          _handleSignIn();
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ))),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
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
