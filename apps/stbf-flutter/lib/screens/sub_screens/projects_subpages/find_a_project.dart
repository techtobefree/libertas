import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';

import '../../../widgets/find_project_card.dart';

class FindAProject extends StatefulWidget {
  const FindAProject({super.key});

  @override
  State<FindAProject> createState() => _FindAProjectState();
}

class _FindAProjectState extends State<FindAProject> {
  late Future<List<dynamic>> _futureProjects;
  String _searchQuery = ''; // <-- new

  @override
  void initState() {
    super.initState();
    _futureProjects = ProjectHandlers.getProjectsIncomplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text('Find a Project'),
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Column(
              children: [
                SizedBox(height: 5.0),
                TextField(
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by location',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: Colors.grey[700]!, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: Colors.grey[700]!, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureProjects,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic>? projects = snapshot.data;
            return ListView.builder(
              itemCount: projects!.length,
              itemBuilder: (context, index) {
                // print(_searchQuery.toLowerCase());
                print(projects[index]['city'].toLowerCase());
                if (_searchQuery.length < 2) {
                  return ProjectCard.fromJson(projects[index]);
                } else {
                  String projectCity = projects[index]['city'].toLowerCase();
                  String projectState = projects[index]['state'].toLowerCase();
                  String combined =
                      '${projects[index]['city'].toLowerCase()}, ${projects[index]['state'].toLowerCase()}';
                  String query = _searchQuery.toLowerCase();
                  if (projectCity.contains(query) ||
                      projectState.contains(query) ||
                      combined.contains(query)) {
                    return ProjectCard.fromJson(projects[index]);
                  }
                  return SizedBox.shrink(); // or return null; to hide the card
                }
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

  // Future<List<dynamic>> getProjects() async {
  //   var url = Uri.parse('http://44.203.120.103:3000/projects');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     // print(jsonResponse);
  //     return jsonResponse;
  //   } else {
  //     throw Exception('Failed to load projects');
  //   }
  // }
}
