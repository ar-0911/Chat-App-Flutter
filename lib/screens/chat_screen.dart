import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import '../components/MessageStream.dart';


final _firestore = FirebaseFirestore.instance;


class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final fieldText = TextEditingController();
  late String messageText;
  late final loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user.email;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              //logout functionality
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(user: loggedInUser,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.orangeAccent,
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.normal),
                    onChanged: (value) {
                      messageText = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter message'),
                    controller: fieldText,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.orange.shade700,
                  ),
                  child: TextButton(
                      onPressed: () {
                        _firestore
                            .collection('messages')
                            .add({'sender': loggedInUser, 'text': messageText,'timestamp': FieldValue.serverTimestamp(),});
                        fieldText.clear();
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




// void getMessages() async {
//   final messages = await _firestore.collection('messages').get();
//   for (var message in messages.docs) {
//     print(message.data());
//   }
// }

// void messagesStream() async {
//   await for (var snapshot in _firestore.collection('messages').snapshots()) {
//     snapshot.docs;
//     for (var message in snapshot.docs) {
//       print(message.data());
//     }
//   }
// }

