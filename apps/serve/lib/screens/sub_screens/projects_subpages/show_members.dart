import 'package:flutter/material.dart';
import 'package:serve_to_be_free/models/UProject.dart';

import '../../../data/projects/project_handlers.dart';
import '../../../widgets/ui/member_card.dart'; // Import your project handlers

class ShowMembers extends StatefulWidget {
  final String? projectId;

  ShowMembers({required this.projectId});

  @override
  _ShowMembersState createState() => _ShowMembersState();
}

class _ShowMembersState extends State<ShowMembers> {
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
        title: Text('Members'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
          ? Center(
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
