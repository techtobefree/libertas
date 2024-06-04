import 'package:flutter/material.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/widgets/ui/member_card.dart'; // Import your project handlers

class ShowProjectMembers extends StatefulWidget {
  final String? projectId;

  const ShowProjectMembers({super.key, required this.projectId});

  @override
  ShowProjectMembersState createState() => ShowProjectMembersState();
}

class ShowProjectMembersState extends State<ShowProjectMembers> {
  List<String>? projectMems;

  @override
  void initState() {
    super.initState();
    ProjectHandlers.getUProjectById(widget.projectId!).then((proj) {
      setState(() {
        projectMems = proj?.members;
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
      body: projectMems == null
          ? const Center(
              child: CircularProgressIndicator(), // Show a loading indicator
            )
          : ListView.builder(
              itemCount: projectMems!.length,
              itemBuilder: (context, index) {
                return MemberCard(userId: projectMems![index]);
              },
            ),
    );
  }
}
