import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';
import 'package:serve_to_be_free/widgets/finish_project_card.dart';

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

  void resetState() {
    setState(() {
      _futureProjects = getProjects();
    });
  }

  // Future<bool> _finishProject(String projId, context) async {
  //   // var url = Uri.parse('http://44.203.120.103:3000/projects/$projId/complete');
  //   // var response = await http.put(url);
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _futureProjects = getProjects();
  //     });
  //     return true;
  //   } else {
  //     throw Exception('Failed to load projects');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Finish a Project'),
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
          )),
      body: FutureBuilder<List<dynamic>>(
        future: _futureProjects,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic>? projects = snapshot.data;
            if (projects == null || projects.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
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
                  () => ProjectHandlers.finishProject(projects[index]['id']),
                  () => resetState(),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Failed to load projects."),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<dynamic>> getProjects() async {
    // var url = Uri.parse('http://44.203.120.103:3000/projects');
    // var response = await http.get(url);
    try {
      var userId = Provider.of<UserProvider>(context, listen: false).id;
      var projs = await ProjectHandlers.getMyProjects(userId);
      if (projs.isNotEmpty) {
        // var jsonResponse = jsonDecode(response.body);
        // // print(jsonResponse);
        var projects = [];
        for (var project in projs) {
          if ((userId == project['members'][0] ||
                  userId == project['leader']) &&
              !project['isCompleted']) {
            projects.add(project);
          }
        }
        return projects;
      } else {
        return [];
      }
    } catch (exp) {
      throw Exception('Failed to load projects');
    }
  }
}
