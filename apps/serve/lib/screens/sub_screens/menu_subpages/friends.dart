import 'package:flutter/material.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/widgets/ui/member_card.dart'; // Import your project handlers

class Friends extends StatefulWidget {
  final String? userId;

  const Friends({super.key, required this.userId});

  @override
  FriendsState createState() => FriendsState();
}

class FriendsState extends State<Friends> {
  List<String>? friends;

  @override
  void initState() {
    super.initState();
    UserHandlers.getFriendsIds(widget.userId!).then((friendsIds) {
      setState(() {
        friends = friendsIds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Members',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 28, 72, 1.0),
                Color.fromRGBO(35, 107, 140, 1.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: friends == null
          ? const Center(
              child: CircularProgressIndicator(), // Show a loading indicator
            )
          : ListView.builder(
              itemCount: friends!.length,
              itemBuilder: (context, index) {
                return MemberCard(userId: friends![index]);
              },
            ),
    );
  }
}
