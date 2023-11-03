import 'package:flutter/material.dart';
import 'package:serve_to_be_free/widgets/message_preview.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';

class MessagesPage extends StatefulWidget {
  // This makes sense because we need our page to keep a list to display to the user
  //final List<Widget> messagePreviews;

  const MessagesPage({Key? key /*, required this.messagePreviews*/})
      : super(key: key);

  @override
  MessagesPageState createState() => MessagesPageState();
}

class MessagesPageState extends State<MessagesPage> {
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
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 155, 155, 155),
                  offset: Offset(
                    1.0,
                    1.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.article_outlined),
                SizedBox(width: 5),
                Text("All Messages",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ],
            ),
          ),
          // going to have to map this.
          const MessagePreview(
              profilePicture: ProfilePicture(Colors.amberAccent, 55, '', '')),
          const MessagePreview(
              profilePicture: ProfilePicture(
                  Colors.pinkAccent, 55, 'assets/images/dude_fake.jpeg', '')),
          const MessagePreview(
              profilePicture: ProfilePicture(Colors.blueAccent, 55, '', '')),
          const MessagePreview(
              profilePicture: ProfilePicture(Colors.greenAccent, 55, '', '')),
          const MessagePreview(
              profilePicture: ProfilePicture(Colors.orangeAccent, 55, '', ''))
        ]));
  }
}
