import 'package:flutter/material.dart';

class InviteALeader extends StatelessWidget {
  final String path;

  const InviteALeader({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Invite a leader'),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text("Invite a Leader",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Open Sans',
                            )),
                        SizedBox(width: 20),
                        Text("Optional",
                            style: TextStyle(
                                fontFamily: 'Open Sans', color: Colors.grey)),
                      ],
                    ),
                    SizedBox(
                        height: 12), // Add a small vertical space of 10 pixels
                    Text(
                        "[FPO] Every project needs a leader who can help move the project forward.",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Open Sans',
                        )),
                  ])),
            ],
          ),
        ));
  }
}
