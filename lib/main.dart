import 'package:flutter/material.dart';
import 'package:whatsappclone/RegistrationScreens/Rwelcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsappclone/RegistrationScreens/profile_info.dart';
import 'package:whatsappclone/Screens/chat_screen.dart';
import 'package:whatsappclone/Screens/welcome_screen.dart';
import 'Screens/home_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   //bool userSignedIn = false;
   var user;

 Future<bool> checkUserSignIn() async
  {
     user = await FirebaseAuth.instance.currentUser();
    if(user != null)
    {
        return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context)  {
  return FutureBuilder<bool>(
    future: checkUserSignIn(),
      builder: (context,AsyncSnapshot<bool> snapshot)
  {
    if(snapshot.hasData)
      return MaterialApp(
        //initialRoute: welcomeScreen;
        home: snapshot.data ? WelcomeScreen(user) :RwelcomeScreen(),
        //home: ProfileInfo(user),
        debugShowCheckedModeBanner: false,
      );
    else
      return MaterialApp(
        home: RwelcomeScreen(),
        debugShowCheckedModeBanner: false,
      );
  }
  );

  }
}