import 'package:e_commerce/constants.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  void _registeruser() async{

    setState(() {
      _registrationloading=true;
    });

    String _registerfeedback = await _createaccount();
    if (_registerfeedback!=null){
      _alertdailogbuilder(_registerfeedback);

      setState(() {
        _registrationloading=false;
      });
    }
    else{
      Navigator.pop(context);
    }

  }

  Future<String> _createaccount() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _registeremail, password: password);
      return null;
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      print('hello');
      return e.toString();
    }
    }


  bool _registrationloading = false;
  String _registeremail = "";
  String password = "";

  FocusNode _passwordfocusnode;

  @override
  void initState(){
    _passwordfocusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose(){
    _passwordfocusnode.dispose();
    super.dispose();
  }

  Future<void> _alertdailogbuilder(String error) async {
    return showDialog(context: context,
    barrierDismissible: false,
    builder: (context){
      return AlertDialog(

        title: Text('Error'),
        content: Container(
          child: Text(error),
        ),
        actions: [
          FlatButton(
            child: Text('close'),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Container(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Text('Welcome User \n Create New Account',textAlign: TextAlign.center,style: Constants.boldheading,)),
                Column(
                  children: [
                    CustomInput(hinttext: 'Email',onChanged: (value){
                      _registeremail = value;
                    },
                    onSubmitted: (value){
                      _passwordfocusnode.requestFocus();
                    },textinputaction: TextInputAction.next,),
                    CustomInput(hinttext: 'Password',onChanged: (value){
                      password = value;
                    },focusNode: _passwordfocusnode,isPasswordfield: true,),
                    CustomButton(text: 'SignUp',onPressed: (){

                      _registeruser();
                    },outlined: false,isloading: _registrationloading,)
                  ],
                ),
                CustomButton(text: 'Back to Login',onPressed: (){
                    Navigator.pop(context);
                },outlined: true,),
              ],
            ),
          ),
        )

    );
  }
}
