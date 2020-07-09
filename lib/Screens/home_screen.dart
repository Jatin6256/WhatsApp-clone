import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsappclone/Screens/users_list.dart';
import 'package:whatsappclone/Tabs/call_tab.dart';
import 'package:whatsappclone/Tabs/camera_tab.dart';
import 'package:whatsappclone/Tabs/chat_tab.dart';
import 'package:whatsappclone/Tabs/status_tab.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser _user;
  HomeScreen(this._user);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  DefaultTabController(
        length: 4,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'WhatsAppClone',
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
              onPressed: (){

              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) async{
               await FirebaseAuth.instance.signOut();
                SystemNavigator.pop();
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>> [
                PopupMenuItem<String>(
                  value: '1',
                  child: Text('Sign Out'),

                ),
              ],
            ),
          ],
          bottom: TabBar(
           // labelPadding: EdgeInsets.all(0.0),
            //indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: [
              Container(
                width: 30.0,
                child: Icon(Icons.camera_alt),
              ),
              Container(
                width: 65.0,
                height: 20.0,
                child: Text(
                  'CHAT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
              Container(
                height: 20.0,
                width: 65.0,
                child: Text(
                  'STATUS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                   // color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 20.0,
                width: 65.0,
                child: Text(
                  'CALLS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
          body: TabBarView(
            children: [
              CameraTab(),
              ChatTab(_user),
              StatusTab(),
              CallTab(),
            ],
          ),

        ),
      ),
    );
  }
}
