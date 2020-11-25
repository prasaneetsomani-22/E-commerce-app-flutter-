import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:e_commerce/widgets/capacity_btns.dart';
import 'package:e_commerce/widgets/custom_actionbar.dart';
import 'package:e_commerce/widgets/imageswipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class ProductPage extends StatefulWidget {
  final String id;
  ProductPage({this.id});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  FirebaseServices _firebaseServices = FirebaseServices();

  List savedproducts;
  int productprice;


  int z = 0; //is saved flag variable


  String _selectedproductcapacity = '0.5';

  final SnackBar _snackBar = SnackBar(content: Text('Product added to the cart'),);
  final SnackBar _savedsnackBar = SnackBar(content: Text('Product saved'),);

  Future addtocart(){
    return _firebaseServices.userref
        .doc(_firebaseServices.getuserid())
        .collection('Cart')
        .doc(widget.id)
        .set(
      {
        'size': _selectedproductcapacity,
        'price': productprice
      }
    );
  }

  Future addtosaved(){
    return _firebaseServices.userref
        .doc(_firebaseServices.getuserid())
        .collection('Saved').doc(widget.id)
        .set({'id': widget.id});
  }

  bool issaved(){
    savedproducts.forEach((document) {
      if(document.id == widget.id){
        z=1;
        return ;
      }
    });
    return z==1?true:false;
  }

  @override
  void initState() {
    // TODO: implement initState
    _firebaseServices.userref.doc(_firebaseServices.getuserid()).collection('Saved').get().then((data){
      savedproducts = data.docs;
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productref.doc(widget.id).get(),
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
                Map<String,dynamic> documentdetails = snapshot.data.data();
                List imagelist = documentdetails['images'];
                List capacitylist = documentdetails['capacity'];
                productprice = documentdetails['price'];
                return ListView(
                  children: [
                    ImageSwipe(imagelist: imagelist,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 5.0),
                      child: Text('${documentdetails['title']}'??'Product Name',style: Constants.boldheading,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 5.0),
                      child: Text('Rs ${documentdetails['price']}'??'price',style: TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).accentColor,fontSize: 18.0),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 8.0),
                      child: Text('${documentdetails['description']}'??'Description',style: TextStyle(fontSize: 16.0),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 16.0),
                      child: Text('Select Capacity (in Litres)',style: Constants.textstyle,),
                    ),
                    CapacityButtons(capacitylist: capacitylist,selectedcapacity: (capacity){
                      _selectedproductcapacity = capacity;
                    },),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap:(){
                              addtosaved();
                              Scaffold.of(context).showSnackBar(_savedsnackBar);
                              setState(() {
                                z=1;
                              });
                            },
                            child: Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                color: Color(0xffDCDCDC),
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Icon(Icons.favorite,size: 40,color: issaved()?Theme.of(context).accentColor:Colors.black,)
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await addtocart();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 16.0),
                                height: 65.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0)
                                ),
                                alignment: Alignment.center,
                                child: Text('Add to Cart',
                                style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.w600),)
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },


          ),
          CustomActionBar(title:'detail',hasbackarrow: true,hastitle: false,hasbackground: false,)
        ],
      )
    );
  }
}
