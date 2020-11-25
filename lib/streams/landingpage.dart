import 'package:e_commerce/streams/homepage.dart';
import 'package:e_commerce/streams/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_commerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends StatelessWidget{

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: _initialization,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Scaffold(
              body: Center(
                  child: Text('Something went wrong')
              ),
            );
          }
          if(snapshot.connectionState==ConnectionState.done){
            return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges()
                ,builder: (context, streamsnapshot){
                  if(streamsnapshot.hasError){
                    return Scaffold(
                      body: Center(
                          child: Text('Error: ${streamsnapshot.error}')
                      ),
                    );
                  }

                  if(streamsnapshot.connectionState == ConnectionState.active){
                    User _user = streamsnapshot.data;
                    if(_user == null){
                      return LoginPage();
                    }
                    else{
                      return HomePage();
                    }
                  }

                  return Scaffold(
                    body: Center(
                      child: Text('checking authentication.....'),
                    ),
                  );
                }
            );
          }

          return Scaffold(
            body: Center(
              child: Text('App initializing.....'),
            ),
          );

        }
    );
  }
}