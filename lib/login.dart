import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/main.dart';

//로그인부분
class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class _LogInState extends State<LogIn> {
  TextEditingController Controller = TextEditingController();
  TextEditingController Controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('주차어때'),
          centerTitle: true,
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
                                      color: Colors.teal, fontSize: 15.0))),
                          child: Container(
                              padding: EdgeInsets.all(30.0),
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Image(
                                        image: AssetImage('image/logo.png')),
                                  ),
                                  TextField(
                                    controller: Controller,
                                    decoration: InputDecoration(
                                        labelText: 'Enter "ID"'),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  TextField(
                                    controller: Controller2,
                                    decoration: InputDecoration(
                                        labelText: 'Enter "PassWord"'),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 40),
                                  RaisedButton(
                                    child: Text('로그인',
                                        style: TextStyle(fontSize: 21)),
                                    color: Colors.blue,
                                    onPressed: () {
                                      if (Controller.text == 'dice' &&
                                          Controller2.text == '1234') {
                                        // push에 전달되는 두 번째 매개변수는 Route<T> 클래스.
                                        Navigator.push(context,
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return Second();
                                        }));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                            '로그인정보를 확인하세요',
                                            textAlign: TextAlign.center,
                                          ),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.blue,
                                        ));
                                      }

                                      // 화살표 문법 적용
                                      // Navigator.push(context,
                                      // MaterialPageRoute<void>(builder: (BuildContext context) => Second())
                                      // );

                                      // 위와 같은 코드. of 메소드 호출이 불편하다.
                                      // Navigator.of(context).push(
                                      // MaterialPageRoute<void>(builder: (BuildContext context) => Second())
                                      // );
                                    },
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
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                return Second();
                                              }));
                                            },
                                            child: Text('비로그인 둘러보기')),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SignInButton(
                                        Buttons.Google,
                                        onPressed: signInWithGoogle,
                                      )
                                    ],
                                  )
                                  // SignInButton(
                                  //   Buttons.Google,
                                  //   onPressed: signInWithGoogle,
                                  // MaterialButton(
                                  //   shape: CircleBorder(
                                  //       side: BorderSide(
                                  //           width: 1,
                                  //           color: Colors.red,
                                  //           style: BorderStyle.solid)),
                                  //   onPressed: signInWithGoogle,
                                  // )
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
}

//로그인 끝
