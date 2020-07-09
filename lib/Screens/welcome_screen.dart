import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatelessWidget {

  final FirebaseUser _user;
  WelcomeScreen(this._user);

  static const Duration  _delay = Duration(seconds: 2);
  Future<void> pushToHomeScreen(BuildContext context)async {
    await Future.delayed(_delay,(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(_user),));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    pushToHomeScreen(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Image.asset('images/logo.jpeg'),
           SizedBox(
               height: 150.0
           ),
           Text(
               'from',
             style: TextStyle(
               color: Colors.grey,
             ),
           ),
           Text(
             'f a c e b o o k',
             style: TextStyle(
               color: Colors.blue,
               fontSize: 30.0,
             ),
           ),
         ],
       ),
      ),
    );
  }
}
