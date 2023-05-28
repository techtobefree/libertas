import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../data/users/providers/user_provider.dart';
import '../../../widgets/finish_project_card.dart';
import 'package:serve_to_be_free/widgets/finish_project_card.dart';
import 'package:provider/provider.dart';

class FinishProject extends StatefulWidget {
  const FinishProject({super.key});

  @override
  State<FinishProject> createState() => _FinishProjectState();
}

class _FinishProjectState extends State<FinishProject> {
  late Future<List<dynamic>> _futureProjects;

  @override
  void initState() {
    super.initState();
    _futureProjects = getProjects();
  }

  Future<bool> _finishProject(String projId, context) async {
    var url = Uri.parse('http://44.203.120.103:3000/projects/$projId/complete');
    var response = await http.put(url);
    if (response.statusCode == 200) {
      setState(() {
        _futureProjects = getProjects();
      });
      return true;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Finish a Project'),
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
            if (projects == null || projects.length == 0) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Create a project to get started",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return FinishProjectCard.fromJson(
                  projects[index],
                  () => _finishProject(projects[index]['_id'], context),
                );
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

  Future<List<dynamic>> getProjects() async {
    var url = Uri.parse('http://44.203.120.103:3000/projects');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse);
      var projects = [];
      for (var project in jsonResponse) {
        if (Provider.of<UserProvider>(context, listen: false).id ==
                project['members'][0] &&
            project['isCompleted'] == false) {
          projects.add(project);
        }
      }
      return projects;
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
