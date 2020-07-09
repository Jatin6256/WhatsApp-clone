import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/RegistrationScreens/profile_info.dart';
import 'package:whatsappclone/Screens/chat_screen.dart';

class UserListTile extends StatefulWidget {
  final String currUserProfileUrl;
  final String currUserName;
  final String name;
  final String profilePhotoDownloadUrl;
  final String peerPhoneNumber;
  final String currUserPhoneNumber;
  UserListTile({this.name,this.profilePhotoDownloadUrl,this.peerPhoneNumber,this.currUserPhoneNumber,this.currUserName,this.currUserProfileUrl});

  @override
  _UserListTileState createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  NetworkImage image ;
  void getProfileImage()
  {
    if(widget.profilePhotoDownloadUrl != 'no profile photo added')
        image =  NetworkImage(widget.profilePhotoDownloadUrl);
  }
  String getChatRoomId()
  {
    String chatRoomId;
    if(widget.peerPhoneNumber.hashCode <= widget.currUserPhoneNumber.hashCode)
      {
        chatRoomId = widget.peerPhoneNumber + widget.currUserPhoneNumber;
      }
    else
      {
        chatRoomId = widget.currUserPhoneNumber + widget.peerPhoneNumber;
      }
    return chatRoomId;
  }

  @override
  Widget build(BuildContext context) {
    getProfileImage();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        String chatRoomId = getChatRoomId();
        //var peerChatRoomRef =
//        Firestore.instance.collection('chat rooms').document(widget.peerPhoneNumber).collection('friends').document(chatRoomId).setData({
//          'peerName' : widget.currUserName,
//          'peerProfilePhotoUrl' : widget.currUserProfileUrl,
//          'peerPhoneNumber' : widget.currUserPhoneNumber,
//        });
//        //var currUserChatRoomRef =
//        Firestore.instance.collection('chat rooms').document(widget.currUserPhoneNumber).collection('friends').document(chatRoomId).setData(
//          {
//            'peerName': widget.name,
//            'peerProfilePhotoUrl' : widget.profilePhotoDownloadUrl,
//            'peerPhoneNumber' : widget.peerPhoneNumber,
//          }
//        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(
          peerPhoneNumber: widget.peerPhoneNumber ,
          peerName: widget.name,
          peerProfileDownloadUrl: widget.profilePhotoDownloadUrl,
          currUserPhoneNumber: widget.currUserPhoneNumber,
        )),);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
            child:image == null? Icon(
                Icons.account_circle ,
          size: 60.0,
            ):null,
              backgroundImage: image != null ? image : null,
//            child: Icon(
//              Icons.account_circle,
//              size: 60.0,

              radius: 30.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              '${widget.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
