import 'package:e_commerce/streams/productpage.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
class HomeProductCard extends StatelessWidget {
  final String productid;
  final String imageurl;
  final String title;
  final String price;
  HomeProductCard({this.productid,this.imageurl,this.title,this.price});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(id:productid)));
      },
      child: Container(
          height: 450,
          margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 12.0),
          child: Stack(
            children: [
              Container(
                height: 450,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(imageurl,fit: BoxFit.cover,)),
              ),

              Positioned(
                bottom:0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.white
                          ],
                          begin: Alignment(0,0),
                          end: Alignment(0,1)

                      )
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title??'Product Name',style: Constants.textstyle,),
                      Text('Rs ${price}',style: TextStyle(fontSize: 18.0,color: Theme.of(context).accentColor,fontWeight: FontWeight.w600),)
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );;
  }
}
