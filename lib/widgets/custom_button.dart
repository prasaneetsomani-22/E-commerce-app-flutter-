

import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {

  final String text;
  final Function onPressed;
  final bool outlined;
  final bool isloading;
  CustomButton({this.text,this.onPressed,this.outlined,this.isloading});

  @override
  Widget build(BuildContext context) {

    bool _outlined = outlined??false;
    bool _isloading = isloading??false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlined ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,

          ),
          borderRadius: BorderRadius.circular(12.0)
        ),
        margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 8.0),
        child: Stack(
          children: [
            Visibility(
              visible: _isloading?false:true,
              child: Center(
                child: Text(text,style: TextStyle(
                    color: _outlined?Colors.black:Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600
                ),),
              ),
            ),
            Visibility(
              visible: _isloading?true:false,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
