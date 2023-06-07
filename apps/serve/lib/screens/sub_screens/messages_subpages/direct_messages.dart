import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DirectMessages extends StatefulWidget {
  const DirectMessages({super.key});

  @override
  State<DirectMessages> createState() => _DirectMessagesState();
}

class _DirectMessagesState extends State<DirectMessages> {
  /* 
  This needs to update state for the constant appearance of new messages on the
  screen I believe. I want to see if websockets are the way to go on this as well.
  So far I just want to make some sort of screen for this but I will 
  probably have to do some sort of flutter messages app tutorial so that
  I can understand how this will connect with client, server, database.
  */

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Direct messages between user and another person."),
    );
  }
}
