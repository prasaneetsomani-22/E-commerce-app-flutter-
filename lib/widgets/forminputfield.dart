import 'package:flutter/material.dart';
class FormInputField extends StatelessWidget {
  final String hinttext;
  final Function onChanged;
  FormInputField({this.hinttext,this.onChanged});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        validator: (value){
          if(value.isEmpty){
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(fontSize: 18.0),
            contentPadding: EdgeInsets.all(10)
        ),
      ),
    );
  }
}
