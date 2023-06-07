import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';

class MessagePreview extends StatefulWidget {
  // needs just an entire person object almost. Dynamic data is hardcoded below
  // Need to retrieve the most recent message data, with its time "7:18" or "Yesterday" or "8/13/2022". Something like that.
  // Also the name of the person the message is connected to, How do we get all that info in?

  // final String name
  // final String Date? Time?
  // final Date date?
  final ProfilePicture profilePicture;
  const MessagePreview({super.key, required this.profilePicture});

  @override
  State<MessagePreview> createState() => _MessagePreviewState();
}

class _MessagePreviewState extends State<MessagePreview> {
  /* 
  Im not sure if this needs state or not but I imagine that when someone
  recieves a message and needs to display the newly recieved message the 
  preview should show the most recently recieved message and make a change 
  to the eyes of the user... am I wrong?
  */

  // should have an object of type ProfilePicture?
  // posible use of Divider() at the bottom

  // Question: Depending on wh
  //final ProfilePicture _profilePicture = ProfilePicture(Colors.pinkAccent, 55, "assets/images/curious_lemur.jpeg");

  // constructor
  // Time of last message. or yesterday? or a date?
  // Text from the latest message.
  // First name of the person who sent the message.

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(
        children: [
          widget.profilePicture,
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: Text(
                        "Becky",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text("yesterday"),
                    )
                  ],
                ),
                Container(
                  //margin or padding
                  child: Text("I am the message"),
                )
              ],
            ),
          )
        ],
      ),
      Divider()
    ]));
  }
}
