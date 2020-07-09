import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  MessageBubble({this.message,this.isMe});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style:TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            color: isMe ? Colors.lightBlueAccent:Colors.white,
              borderRadius: isMe ? BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft:  Radius.circular(20.0),
                bottomRight:  Radius.circular(20.0),
              ): BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomLeft:  Radius.circular(20.0),
                bottomRight:  Radius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }
}
