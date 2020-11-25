import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:e_commerce/streams/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class CustomActionBar extends StatelessWidget {

  final String title;
  final bool hasbackarrow;
  final bool hastitle;
  final bool hasbackground;
  final bool hascartbutton;
  CustomActionBar({this.title,this.hasbackarrow,this.hastitle,this.hasbackground,this.hascartbutton});

  final userref = FirebaseFirestore.instance.collection('users');

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasbackarrow = hasbackarrow??false;
    bool _hastitle = hastitle??true;
    bool _hasbackground = hasbackground??true;
    bool _hascartbutton = hascartbutton??true;
    return Container(
      decoration: BoxDecoration(
        gradient: _hasbackground?LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.5)
          ],
          begin: Alignment(0,0),
          end: Alignment(0,1)
        ):null
      ),
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_hasbackarrow)
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Icon(Icons.arrow_back_ios,color: Colors.white,),
              ),
            ),
          if(_hastitle)
            Text(title,style: Constants.boldheading,),
          if(_hascartbutton)
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
              },
              child: Container(

                child: Stack(

                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 42.0,
                      height: 42.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0),

                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.shopping_cart,color: Colors.white),
                  ),

                    StreamBuilder(
                      stream: userref.doc(_firebaseServices.getuserid()).collection('Cart').snapshots(),
                      builder: (context,snapshot){

                        int _totalitems = 0;
                        if(snapshot.connectionState == ConnectionState.active){
                          List _documents = snapshot.data.docs;
                          _totalitems = _documents.length;
                        }

                        return _totalitems != 0?Positioned(
                            bottom: 35,
                            right: 35,
                            child: Container(
                              width: 25,
                              height: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(12.5)
                              ),
                              child: Text(_totalitems.toString()??'0',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17),),
                            )):Text('');
                      },
                    )
                ],
              ),
            ),
          ),
          if(!_hascartbutton)
            Container(
              width: 0,
              height: 0,
            )
        ],
      ),
    );
  }
}
