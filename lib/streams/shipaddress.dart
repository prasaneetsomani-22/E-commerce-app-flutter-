import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:e_commerce/streams/add_address.dart';
import 'package:e_commerce/streams/productpage.dart';
import 'package:e_commerce/streams/selectpaymentpage.dart';
import 'package:e_commerce/widgets/custom_actionbar.dart';
import 'package:e_commerce/widgets/custom_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants.dart';

class ShippingAddress extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}



class _ShippingAddressState extends State<ShippingAddress> {

  FirebaseServices _firebaseServices = FirebaseServices();
  String gvalue;

  @override
  void initState() {
    _firebaseServices.userref.doc(_firebaseServices.getuserid()).collection('Addresses').get().then((data){
      // setState(() {
      //   addresses = data.docs;
      // });
      // print(addresses);
      setState(() {
        gvalue = data.docs.first.id;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         // addresses == null?Center(child: CircularProgressIndicator()): ListView(
         //   padding: EdgeInsets.only(top: 150,bottom: 50,left: 30,right: 30),
         //    children: addresses.map((document){
         //      return Padding(
         //                        padding: const EdgeInsets.only(top: 30),
         //                        child: Container(
         //                          child: Row(
         //                            mainAxisAlignment: MainAxisAlignment.start,
         //                            children: [
         //                              Radio(
         //
         //                                groupValue: gvalue,
         //                                value: document.id,
         //                                onChanged: (value){
         //                                  setState(() {
         //                                    gvalue = value;
         //                                  });
         //                                },
         //                              ),
         //                              Padding(
         //                                padding: const EdgeInsets.only(left: 20),
         //                                child: Column(
         //                                  crossAxisAlignment: CrossAxisAlignment.start,
         //                                  children: [
         //                                    Text('${document.data()['name']}',style: Constants.textstyle,),
         //                                    Text('${document.data()['mobile_no']}\n'
         //                                        '${document.data()['house_no']}, ${document.data()['road_name']}\n'
         //                                        '${document.data()['city']}, ${document.data()['state']}\n'
         //                                        '${document.data()['pincode']}',style: Constants.textstyle,)
         //                                  ],
         //                                ),
         //                              )])));
         //    }).toList(),
         //  ),
          StreamBuilder(
            stream: _firebaseServices.userref.doc(_firebaseServices.getuserid()).collection('Addresses').snapshots(),
            builder: (context,snapshots){
              if(snapshots.hasError){
                return Container(
                  child: Center(
                    child: Text('${snapshots.error}'),
                  ),
                );
              }
              if(snapshots.connectionState == ConnectionState.active){

                return ListView(
                  padding: EdgeInsets.only(top: 150,bottom: 50,left: 30,right: 30),
                    children: snapshots.data.docs.map<Widget>((document){
                      return Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(

                                groupValue: gvalue,
                                value: document.id,
                                onChanged: (value){
                                  setState(() {
                                    gvalue = value;
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${document.data()['name']}',style: Constants.textstyle,),
                                    Text('${document.data()['mobile_no']}\n'
                                        '${document.data()['house_no']}, ${document.data()['road_name']}\n'
                                        '${document.data()['city']}, ${document.data()['state']}\n'
                                        '${document.data()['pincode']}',style: Constants.textstyle,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      );
                    }).toList(),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectPaymentPage(address_id: gvalue,)));
              },
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12.0),topLeft: Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 32
                    )
                  ]


                ),
                alignment: Alignment.center,
                child: Text(' Continue',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 22),)
              ),
            ),
          ),
          Positioned(
            top: 110,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAddress()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffDCDCDC)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle,color: Theme.of(context).accentColor,size: 30,),
                    SizedBox(width: 10,),
                    Text('Add New Address',style: Constants.boldheading,)
                  ],
                ),
              ),
            ),
          ),
          CustomActionBar(title: 'Select Address',hastitle: true,hasbackground: true,hasbackarrow: true,hascartbutton: false,)
        ],
      ),
    );
  }
}

