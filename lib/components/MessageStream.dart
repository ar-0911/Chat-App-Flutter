import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'MessageBubble.dart';

final _firestore = FirebaseFirestore.instance;

class MessageStream extends StatelessWidget {
  const MessageStream({super.key, required this.user});
  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbleWidgets = [];
        //So, when you see snapshot.data, it refers to the most recent
        // QuerySnapshot emitted by the Firestore stream. Then, when you
        // access snapshot.data.docs, you are retrieving the list of documents within that QuerySnapshot.
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }
        final messages = snapshot.data;
        for (var message in messages!.docs.reversed) {
          final messageSender = message.get('sender');
          final messageText = message.get('text');
          messageBubbleWidgets.add(MessageBubble(text: messageText, sender: messageSender, isMe: messageSender==user,));
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            children: messageBubbleWidgets,
          ),
        );
      },
    );
  }
}