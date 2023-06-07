import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';

class ProjectPost extends StatefulWidget {
  final String id;
  final String name;
  final String postText;
  final String profURL;
  final String date;

  const ProjectPost({
    Key? key,
    required this.id,
    required this.name,
    required this.postText,
    required this.profURL,
    required this.date,
  }) : super(key: key);

  @override
  State<ProjectPost> createState() => _ProjectPostState();
}

class _ProjectPostState extends State<ProjectPost> {
  // How are we going to tie this to different users?
  bool isLiked = false;
  MaterialAccentColor getRandomAccentColor() {
    final colors = [
      Colors.redAccent,
      Colors.pinkAccent,
      Colors.purpleAccent,
      Colors.deepPurpleAccent,
      Colors.indigoAccent,
      Colors.blueAccent,
      Colors.lightBlueAccent,
      Colors.cyanAccent,
      Colors.tealAccent,
      Colors.greenAccent,
      Colors.lightGreenAccent,
      Colors.limeAccent,
      Colors.yellowAccent,
      Colors.amberAccent,
      Colors.orangeAccent,
      Colors.deepOrangeAccent,
    ];
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          //height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.profURL != "")
                Container(
                    margin: EdgeInsets.only(right: 15),
                    padding: EdgeInsets.only(),
                    child: ProfilePicture(
                        getRandomAccentColor(), 60, widget.profURL, widget.id)),

              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                      widget.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )),
                    // FINISH
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          widget.date,
                          style: TextStyle(color: Colors.grey),
                        )),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        softWrap: true,
                        widget.postText,
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
              )),
              // Container(
              //   child: Icon(Icons.more_horiz),
              // )
            ],
          ),
        ));
  }
}
