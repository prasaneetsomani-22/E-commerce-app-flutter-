import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CustomInput extends StatelessWidget {

  final String hinttext;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textinputaction;
  final bool isPasswordfield;
  CustomInput({this.hinttext,this.onChanged,this.onSubmitted,this.focusNode,this.textinputaction,this.isPasswordfield});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 8.0),
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2)
      ),
      child: TextField(
        obscureText: isPasswordfield??false,
        textInputAction: textinputaction,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hinttext,
          contentPadding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0)
        ),
        style: Constants.inputtextstyle,
      ),
    );
  }
}
