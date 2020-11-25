import 'package:e_commerce/services/firebase_services.dart';
import 'package:e_commerce/streams/shipaddress.dart';
import 'package:e_commerce/widgets/custom_actionbar.dart';
import 'package:e_commerce/widgets/custom_input.dart';
import 'package:e_commerce/widgets/forminputfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class AddAddress extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  FirebaseServices _firebaseServices = FirebaseServices();
  String name;
  String mobile_no;
  String houseno;
  String roadname;
  String landmark;
  String city;
  String state;
  String pincode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 120,left: 30,right: 30),
            child: Form(
              key: _formkey,
              child: ListView(
                children: [

                  FormInputField(hinttext:'Name',onChanged: (value){
                    name = value;
                   },),
                  FormInputField(hinttext:'Mobile No.',onChanged: (value){
                    mobile_no = value;
                  },),
                  FormInputField(hinttext:'House No.,Building name',onChanged: (value){
                    houseno= value;
                  },),
                  FormInputField(hinttext:'Road name,Area,Colony',onChanged: (value){
                    roadname = value;
                  },),
                  FormInputField(hinttext:'Landmark',onChanged: (value){
                    landmark = value;
                  },),
                  FormInputField(hinttext:'City',onChanged: (value){
                    city = value;
                  },),
                  FormInputField(hinttext:'State',onChanged: (value){
                    state = value;
                  },),
                  FormInputField(hinttext:'Pincode',onChanged: (value){
                    pincode = value;
                  },),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 10),
                    child: GestureDetector(
                      onTap: (){
                        if(_formkey.currentState.validate()){
                          _firebaseServices.userref.doc(_firebaseServices.getuserid()).collection('Addresses').add({
                            'name': name,
                            'mobile_no': mobile_no,
                            'house_no': houseno,
                            'road_name':roadname,
                            'landmark':landmark,
                            'city':city,
                            'state': state,
                            'pincode':pincode
                          }).then((value){
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration:BoxDecoration(
                          color: Theme.of(context).accentColor,

                        ),
                        alignment: Alignment.center,
                        child: Text('Add',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600),),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
          CustomActionBar(hasbackarrow: true,hascartbutton: false,hasbackground: true,hastitle: true,title: 'Add Address',)
        ],
      ),
    );
  }

}



