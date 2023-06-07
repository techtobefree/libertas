import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_to_be_free/widgets/message_preview.dart';
import '../widgets/profile_picture.dart';

class MessagesPage extends StatefulWidget {
  // This makes sense because we need our page to keep a list to display to the user
  //final List<Widget> messagePreviews;

  const MessagesPage({Key? key /*, required this.messagePreviews*/})
      : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  // static List<Widget> MessagePreviews = <Widget>[
  //   MessagePreview(ProfilePicture(
  //       Colors.amberAccent, 55, "/assets/images/curious_lemur.jpeg")),
  //   MessagePreview()
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Messages Demo'),
        ),
        body: Column(children: [
          // can probably make this into a wigdet and resuse for the All groups and maybe even the friends one. Pass in a Color scheme and some dynamic text
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 155, 155, 155),
                  offset: const Offset(
                    1.0,
                    1.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.article_outlined),
                  SizedBox(width: 5),
                  Text("All Messages",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                ],
              ),
            ),
          ),
          // going to have to map this.
          MessagePreview(
              profilePicture: ProfilePicture(Colors.amberAccent, 55, '', '')),
          MessagePreview(
              profilePicture: ProfilePicture(
                  Colors.pinkAccent, 55, 'assets/images/dude_fake.jpeg', '')),
          MessagePreview(
              profilePicture: ProfilePicture(Colors.blueAccent, 55, '', '')),
          MessagePreview(
              profilePicture: ProfilePicture(Colors.greenAccent, 55, '', '')),
          MessagePreview(
              profilePicture: ProfilePicture(Colors.orangeAccent, 55, '', ''))
        ]));
  }
}
