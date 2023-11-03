import 'package:flutter/material.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';

class DashboardPost extends StatefulWidget {
  const DashboardPost({super.key});

  @override
  State<DashboardPost> createState() => _DashboardPostState();
}

class _DashboardPostState extends State<DashboardPost> {
  // How are we going to tie this to different users?
  bool isLiked = false;

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
            Container(
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.only(),
                child:
                    const ProfilePicture(Colors.deepOrangeAccent, 60, '', '')),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // FINISH
                Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      "date/time",
                      style: TextStyle(color: Colors.grey),
                    )),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    softWrap: true,
                    'aljhfalsjdhf aljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhfaljhfalsjdhf ',
                    style: TextStyle(),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      child: Icon(
                        Icons.thumb_up_rounded,
                        color: isLiked ? Colors.amberAccent : Colors.grey,
                        size: 20,
                      ),
                    ),
                    Container(
                      width: 20,
                    ),
                    const Icon(
                      Icons.chat_bubble_rounded,
                      color: Colors.grey,
                      size: 20,
                    )
                  ],
                )
              ],
            )),
            const Icon(Icons.more_horiz)
          ],
        ));
  }
}
