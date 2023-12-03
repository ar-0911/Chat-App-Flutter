import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 20),

  alignLabelWithHint: true,
  contentPadding:
   EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder:  OutlineInputBorder(
    borderSide:  BorderSide(color: Colors.orangeAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Color(0xFFFF6D00), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kRightBorderRadius = BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),);
const kLeftBorderRadius = BorderRadius.only(topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),);