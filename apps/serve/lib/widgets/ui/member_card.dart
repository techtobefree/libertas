import 'dart:math';
import 'package:flutter/material.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';

class MemberCard extends StatefulWidget {
  final String userId;

  const MemberCard({Key? key, required this.userId}) : super(key: key);

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  UUser? member;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      final user = await UserHandlers.getUUserById(widget.userId);
      setState(() {
        member = user;
        isLoading = false;
      });
    } catch (error) {
      // Handle errors, e.g., show an error message.
      print(error);
      setState(() {
        isLoading = false;
      });
    }
  }

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
      child: isLoading
          ? const Placeholder() // Display a placeholder while loading.
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (member != null && member!.profilePictureUrl != "")
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: ProfilePicture(
                      getRandomAccentColor(),
                      60,
                      member!.profilePictureUrl ?? "",
                      widget.userId,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${member?.firstName ?? ""} ${member?.lastName ?? ""}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      // Other content related to member data.
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
