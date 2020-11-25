import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:e_commerce/streams/productpage.dart';
import 'package:e_commerce/widgets/custom_actionbar.dart';
import 'package:flutter/material.dart';
class SavedTab extends StatelessWidget {

  FirebaseServices _firebaseServices =FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: _firebaseServices.userref.doc(_firebaseServices.getuserid())
                .collection('Saved').snapshots(),
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
                return ListView(
                    padding: EdgeInsets.only(top: 100.0,bottom: 24.0),
                    children: snapshot.data.docs.map((document){
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            _firebaseServices.userref.doc(_firebaseServices.getuserid()).collection('Saved').doc(document.id).delete();
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).accentColor,
                                              borderRadius: BorderRadius.circular(8.0)
                                            ),
                                            child: Icon(Icons.delete_outline,color: Colors.white,)
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
                );
              }
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
        ),
          CustomActionBar(title: 'Saved Items',hasbackarrow: false,hastitle: true,)
      ],

    );
  }
}