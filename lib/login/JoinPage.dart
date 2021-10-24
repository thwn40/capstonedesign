import 'package:flutter/material.dart';
import 'package:myapp/components/custom_text_form_field.dart';

import '../components/custom_elevated_button.dart';

class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            child: Text("회원강비 페이지",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),)
          ),
          SizedBox(height: 200),
          _joinForm(),
      

        ],
      ),
    ));
  }

  Widget _joinForm() {
    return Form(
          child: Column(children: [
                CustomTextFormField(hint: "ID를 입력하세요"),
        CustomTextFormField(hint: "비밀번호를 입력하세요"),
        CustomTextFormField(hint: "차번호를 입력하세요"),
        CustomElevatedButton(text: "회원가입"),
          ],)
        );
  }
}

