import 'package:e_commerce/constants.dart';
import 'package:e_commerce/streams/register.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void _Loginuser() async{

    setState(() {
      _loginloading=true;
    });

    String _loginfeedback = await _loginaccount();
    if (_loginfeedback!=null){
      _alertdailogbuilder(_loginfeedback);

      setState(() {
        _loginloading=false;
      });
    }



  }

  Future<String> _loginaccount() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _loginemail, password: loginpassword);
      return null;
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }


  bool _loginloading = false;
  String _loginemail = "";
  String loginpassword = "";

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
                  child: Text('Welcome User \n Login to your account',textAlign: TextAlign.center,style: Constants.boldheading,)),
              Column(
                children: [
                  CustomInput(hinttext: 'Email',onChanged: (value){
                    _loginemail = value;
                  },onSubmitted: (value){
                    _passwordfocusnode.requestFocus();
                  },focusNode: _passwordfocusnode,textinputaction: TextInputAction.next,),
                  CustomInput(hinttext: 'Password',onChanged: (value){
                    loginpassword = value;
                  },onSubmitted: (value){
                    _Loginuser();
                  },isPasswordfield: true,),
                  CustomButton(text: 'Login',onPressed: (){
                    _Loginuser();
                  },outlined: false,isloading: _loginloading,)
                ],
              ),
              CustomButton(text: 'Create New Account',onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => RegisterPage()
                    ));
              },outlined: true,),
            ],
          ),
        ),
      )

    );
  }
}
