import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/streams/productpage.dart';
import 'package:e_commerce/widgets/custom_actionbar.dart';
import 'package:e_commerce/widgets/home_product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class HomeTab extends StatelessWidget {
  final collectionref = FirebaseFirestore.instance.collection('products');



  @override
  Widget build(BuildContext context) {
     return Container(
       child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: collectionref.get(),
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
              if(snapshot.connectionState == ConnectionState.done){
                return ListView(
                  padding: EdgeInsets.only(top: 100.0,bottom: 24.0),
                  children: snapshot.data.docs.map((document){
                    Map details = document.data();
                    return HomeProductCard(productid: document.id,title: details['title'],price: details['price'].toString(),imageurl: details['images'][0],
                    );
                  }).toList()
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          ),

          CustomActionBar(title: 'Home',hasbackarrow: false,hastitle: true,),

        ],

    ),
     );
  }
}
