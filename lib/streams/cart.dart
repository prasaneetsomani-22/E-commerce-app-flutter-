import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:e_commerce/streams/productpage.dart';
import 'package:e_commerce/streams/shipaddress.dart';
import 'package:e_commerce/widgets/custom_actionbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants.dart';
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  FirebaseServices _firebaseServices = FirebaseServices();

  int totalcartprice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _firebaseServices.userref.doc(_firebaseServices.getuserid())
                  .collection('Cart').snapshots(),
              builder: (context,snapshot){
                if (snapshot.hasError){
                  return Container(
                    child: Center(
                      child: Text(
                          snapshot.error.toString()
                      ),
                    ),
                  );
                }
                if(snapshot.connectionState == ConnectionState.active){
                  return Stack(
                    children: [
                      ListView(
                          padding: EdgeInsets.only(top: 100.0,bottom: 24.0),
                          children: snapshot.data.docs.map((document){
                            totalcartprice = totalcartprice + document.data()['price'];
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(id:document.id)));
                              },
                              child: FutureBuilder(
                                future: _firebaseServices.productref.doc(document.id).get(),
                                builder: (context,productsnap){


                                  if(productsnap.hasError){
                                    return Container(
                                      child: Center(
                                        child: Text('${productsnap.error}'),
                                      ),
                                    );
                                  }
                                  if(productsnap.connectionState == ConnectionState.done){
                                    Map _productmap = productsnap.data.data();
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                          vertical: 12.0
                                        ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width:90,
                                            height: 90,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8.0),
                                              child: Image.network('${_productmap['images'][0]}',fit: BoxFit.cover,),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 16.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${_productmap['title']}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600
                                                ),),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                  child: Text('Rs ${_productmap['price']}',
                                                    style: TextStyle(
                                                        color: Theme.of(context).accentColor,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                ),
                                                Text('Capacity: ${document.data()['size']} L',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight.w600
                                                  ),)
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              totalcartprice = totalcartprice - document.data()['price'];
                                              _firebaseServices.userref.doc(_firebaseServices.getuserid()).collection('Cart').doc(document.id).delete();
                                                totalcartprice = 0;
                                              },
                                            child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context).accentColor,
                                                    borderRadius: BorderRadius.circular(8.0)
                                                ),
                                                child: Icon(Icons.cancel,color: Colors.white,)
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  return Container(
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                }
                              )
                            );
                          }).toList()
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 65,
                          decoration: BoxDecoration(
                              color: Color(0xffDCDCDC)
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total: Rs ${totalcartprice}',style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600),),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ShippingAddress()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.circular(18)
                                     ),
                                    child: Text('Buy Cart',style: TextStyle(color: Colors.white,fontSize: 22.0,fontWeight: FontWeight.w600),)
                                  ),
                                )
                              ],
                            ),
                          )
                        ),
                      ),
                    ],
                  );
                }
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
          ),

          CustomActionBar(title: 'Cart',hastitle: true,hasbackground: true,hasbackarrow: true,hascartbutton: false,)
        ],
      ),
    );
  }
}
