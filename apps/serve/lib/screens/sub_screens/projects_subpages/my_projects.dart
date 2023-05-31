import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';
import '../../../widgets/find_project_card.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({super.key});

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  late Future<List<dynamic>> _futureProjects;
  @override
  void initState() {
    super.initState();
    _futureProjects = getMyProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Projects'),
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
          )),
      body: FutureBuilder<List<dynamic>>(
        future: _futureProjects,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic>? projects = snapshot.data;
            return ListView.builder(
              itemCount: projects!.length,
              itemBuilder: (context, index) {
                return ProjectCard.fromJson(projects[index]);
                // print(projects[index]['members'].length.toString());
                // return ProjectCard(
                //   title: projects[index]['name'],
                //   num_members: projects[index]['members'].length.toString(),
                // );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Failed to load projects."),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<dynamic>> getMyProjects() async {
    var url = Uri.parse('http://44.203.120.103:3000/projects');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var myprojs = [];
      for (var proj in jsonResponse) {
        for (var member in proj['members']) {
          if (member == Provider.of<UserProvider>(context, listen: false).id) {
            myprojs.add(proj);
          }
        }
      }
      // Sort the list based on isCompleted
      myprojs.sort((a, b) {
        // If a.isCompleted is false or null and b.isCompleted is true, a comes first
        if (a['isCompleted'] == false || a['isCompleted'] == null) {
          return -1;
        }
        // If a.isCompleted is true and b.isCompleted is false or null, b comes first
        if (b['isCompleted'] == false || b['isCompleted'] == null) {
          return 1;
        }
        // Otherwise, use default comparison (b comes before a if they have the same isCompleted value)
        return b['date'].compareTo(a['date']);
      });
      return myprojs;
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
