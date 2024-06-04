import 'package:flutter/material.dart';
import 'package:serve_to_be_free/data/groups/group_handlers.dart';
import 'package:serve_to_be_free/widgets/ui/member_card.dart'; // Import your group handlers

class ShowGroupMembers extends StatefulWidget {
  final String? groupId;

  const ShowGroupMembers({super.key, required this.groupId});

  @override
  ShowGroupMembersState createState() => ShowGroupMembersState();
}

class ShowGroupMembersState extends State<ShowGroupMembers> {
  List<String>? groupMems;

  @override
  void initState() {
    super.initState();
    GroupHandlers.getUGroupById(widget.groupId!).then((proj) {
      setState(() {
        groupMems = proj?.members;
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
      body: groupMems == null
          ? const Center(
              child: CircularProgressIndicator(), // Show a loading indicator
            )
          : ListView.builder(
              itemCount: groupMems!.length,
              itemBuilder: (context, index) {
                return MemberCard(userId: groupMems![index]);
              },
            ),
    );
  }
}
