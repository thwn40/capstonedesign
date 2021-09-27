import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;

  const CustomTextFormField({this.hint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(height: 200),
        Padding(
          padding: const EdgeInsets.symmetric(vertical :5),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "$hint",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        )
      ],
    ));
  }
}


