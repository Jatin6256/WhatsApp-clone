import 'package:flutter/material.dart';
import 'package:whatsappclone/Screens/chat_screen.dart';

class FriendsTile extends StatefulWidget {
  final String peerName;
  final String lastMessage;
  final String lastMessageTime;
  final String peerProfilePhotoUrl;
  final String peerPhoneNumber;
  final String currUserPhoneNumber;
  FriendsTile({this.peerName,this.lastMessage,this.lastMessageTime,this.peerProfilePhotoUrl,this.peerPhoneNumber,this.currUserPhoneNumber});
  @override
  _FriendsTileState createState() => _FriendsTileState();
}

class _FriendsTileState extends State<FriendsTile> {
  NetworkImage image;
  void getProfileImage()
  {
    if(widget.peerProfilePhotoUrl != 'no profile photo added')
      image =  NetworkImage(widget.peerProfilePhotoUrl);
  }
  @override
  Widget build(BuildContext context) {
    getProfileImage();
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(
          peerPhoneNumber: widget.peerPhoneNumber ,
          peerName: widget.peerName,
          peerProfileDownloadUrl: widget.peerProfilePhotoUrl,
          currUserPhoneNumber: widget.currUserPhoneNumber,
        )),);
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child:Column(
          children: <Widget>[
            Row(
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
                Column(
                  children: <Widget>[
                    Text(
                      '${widget.peerName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.lastMessage,
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              height: 30.0,
              thickness: 1.0,
              color: Color(0xFFe0e0e0),
              indent: 70.0,
            ),

//          Row(
//            children: <Widget>[
//              SizedBox(
//                width: 80.0,
//              ),
//
//            ],
//          ),

          ],
        ),

      ),
    );
  }
}
