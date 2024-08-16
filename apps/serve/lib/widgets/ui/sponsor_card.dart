import 'dart:math';
import 'package:flutter/material.dart';
import 'package:serve_to_be_free/utilities/helper.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';

class ProjectSponsorCard extends StatefulWidget {
  final String id;
  final String name;
  final double sponsorAmount;
  final String profURL;
  final String userId;

  const ProjectSponsorCard({
    Key? key,
    required this.id,
    required this.name,
    required this.sponsorAmount,
    required this.profURL,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProjectSponsorCard> createState() => _ProjectSponsorCardState();
}

class _ProjectSponsorCardState extends State<ProjectSponsorCard> {
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
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.profURL != "")
              Container(
                  margin: const EdgeInsets.only(right: 15),
                  padding: const EdgeInsets.only(),
                  child: ProfilePicture(
                      Colors.blueAccent, 60, widget.profURL, widget.userId)),

            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // Container(
                //     padding: const EdgeInsets.only(bottom: 10),
                //     child: Text(
                //       formatDateTime(widget.date),
                //       style: const TextStyle(color: Colors.grey),
                //     )),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    softWrap: true,
                    'Pledged: \$${widget.sponsorAmount.toStringAsFixed(2)}',
                    style: const TextStyle(),
                  ),
                ),
              ],
            )),
            // Container(
            //   child: Icon(Icons.more_horiz),
            // )
          ],
        ));
  }
}
