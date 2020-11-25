import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  String getuserid(){
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference productref = FirebaseFirestore.instance.collection('products');

  final CollectionReference userref = FirebaseFirestore.instance.collection('users');
}