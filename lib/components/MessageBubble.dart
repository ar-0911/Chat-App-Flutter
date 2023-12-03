import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';


class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key,required this.text, required this.sender, required this.isMe});
  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender, style: const TextStyle(color: Colors.grey,fontSize: 15),),
          Material(
            elevation: 6.0,
            borderRadius: isMe?kRightBorderRadius:kLeftBorderRadius,
            color: isMe?Colors.orange:Colors.grey.shade700,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              child: Text(text,style: const TextStyle(color: Colors.white,fontSize: 16.0),),
            ),
          ),
        ],
      ),
    );
  }
}