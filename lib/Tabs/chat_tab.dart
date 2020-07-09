import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/components/user_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsappclone/components/user_list_tile.dart';

Firestore fireStore = Firestore.instance;

class ChatTab extends StatelessWidget {
  final FirebaseUser currentUser;
  ChatTab(this.currentUser);

  @override
  Widget build(BuildContext context) {
    String currUserName;
    String currUserProfileUrl;
//    Firestore.instance.collection('users').document('${currentUser.phoneNumber}').get().then((snap){
//    currUserName = snap.data['name'];
//    currUserProfileUrl = snap.data['url'];
//    }).catchError((error){
//      print(error.toString());
//    });
    return StreamBuilder<QuerySnapshot>(
          stream: fireStore.collection('users').snapshots(),
          builder: (context,snapshot) {
            if(!snapshot.hasData)
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }


            final users = snapshot.data.documents;
            String name;
            String profilePhotoDownloadUrl;

            List<UserListTile> usersTileList = [];
            for(var user in users)
            {
              if(user.documentID == currentUser.phoneNumber)
              {
                currUserName = user.data['name'];
                currUserProfileUrl = user.data['url'];
              }
            }
            for(var user in users)
            {
              name = user.data['name'];
              profilePhotoDownloadUrl = user.data['url'];
              UserListTile tile;

              if(user.documentID != currentUser.phoneNumber)
              {
                tile =  UserListTile(
                  currUserProfileUrl: currUserProfileUrl,
                  currUserName: currUserName,
                  name: name,
                  profilePhotoDownloadUrl: profilePhotoDownloadUrl,
                  peerPhoneNumber: user.documentID,
                  currUserPhoneNumber: currentUser.phoneNumber,
                );
                usersTileList.add(tile);
              }
            }
            return ListView(
              children: usersTileList,
            );
          }
    );
  }
}



