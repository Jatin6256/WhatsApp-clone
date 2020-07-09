import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/components/message_bubble.dart';

class ChatScreen extends StatelessWidget {
  final String peerName;
  final String currUserPhoneNumber;
  final String peerPhoneNumber;
  final String peerProfileDownloadUrl;
  ChatScreen({this.peerName,this.currUserPhoneNumber,this.peerPhoneNumber,this.peerProfileDownloadUrl});

  String getChatRoomId()
  {
    String chatRoomId;
    if(peerPhoneNumber.hashCode <= currUserPhoneNumber.hashCode)
    {
      chatRoomId = peerPhoneNumber + currUserPhoneNumber;
    }
    else
    {
      chatRoomId = currUserPhoneNumber + peerPhoneNumber;
    }
    return chatRoomId;
  }

  @override
  Widget build(BuildContext context) {
    String typedMessage;
    NetworkImage image;
    TextEditingController chatScreenTextFieldController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title:Row(
            children: <Widget>[
              CircleAvatar(
                child:image == null? Icon(
                  Icons.account_circle ,
                  size: 30.0,
                ):null,
                backgroundImage: image != null ? image : null,
//            child: Icon(
//              Icons.account_circle,
//              size: 60.0,

                radius: 15.0,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                peerName,
              ),
            ],
          ),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                  Icons.videocam
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                  Icons.call,
              ),
            ),
//            Icon(
//              Icons.me
//            ),

          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage('images/chat_screen_background_image.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('chat rooms').document(getChatRoomId()).collection('messages').orderBy('timestamp').snapshots(),
                builder: (context,snapshot){
                  if(!snapshot.hasData)
                    {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  var messages = snapshot.data.documents.reversed;
                  List<MessageBubble> messageBubbles = [];
                  for(var message in messages){
                    bool isMe = false;
                    if(message.data['sender'] == currUserPhoneNumber)
                      {
                        isMe = true;
                      }

                    var bubble = MessageBubble(
                      message: message.data['message'],
                      isMe: isMe,
                    );
                    messageBubbles.add(bubble);
                  }
                  return   Expanded(
                    child: ListView(
                      reverse: true,
                      children: messageBubbles,
                    ),
                  );
//                return Expanded(
//                  child: ListView.builder(
//                    itemCount: length,
//                      itemBuilder:(context,index){
//                        return MessageBubble(
//                          message: messages[index].data['message'],
//                          isMe : messages[index].data['isMe'],
//                        );
//                  }),
//                );

                },
              ),


               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   children: <Widget>[
                     Expanded(
                       child: Container(
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.all(
                             Radius.circular(30.0),
                           ),
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Icon(
                                 Icons.insert_emoticon,
                                 size: 30.0,
                                 color: Colors.grey,
                               ),
                             ),
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.all(5.0),
                                 child: TextField(
                                   controller: chatScreenTextFieldController,
                                   onChanged: (newValue){
                                     typedMessage = newValue;
                                   },
                                   maxLines: null,
                                   decoration: InputDecoration(
                                     hintText: 'Type a message',
                                     border: InputBorder.none,
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Icon(
                                 Icons.attach_file,
                                 size: 30.0,
                                 color: Colors.grey,
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Icon(
                                 Icons.camera_alt,
                                 size: 30.0,
                                 color: Colors.grey,
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: GestureDetector(
                         onTap: (){
                       Firestore.instance.collection('chat rooms').document(getChatRoomId()).collection('messages').document().setData({
                             'message' :typedMessage,
                         'sender' : currUserPhoneNumber,
                          'timestamp' : Timestamp.now(),
                           });
                       chatScreenTextFieldController.clear();
                         },
                         child: CircleAvatar(
                           child: Icon(
                             Icons.send,
                             color: Colors.white,
                           ),
                           backgroundColor: Colors.blue,
                           radius: 25.0,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
