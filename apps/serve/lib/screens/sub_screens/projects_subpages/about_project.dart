import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/widgets/dashboard_user_display.dart';

import 'package:serve_to_be_free/widgets/ui/dashboard_post.dart';
import 'package:serve_to_be_free/widgets/ui/project_post.dart';
import 'package:serve_to_be_free/widgets/post_dialogue.dart';

import '../../../models/ModelProvider.dart';

class AboutProject extends StatefulWidget {
  final String? id;

  const AboutProject({Key? key, required this.id}) : super(key: key);

  @override
  _AboutProjectState createState() => _AboutProjectState();
}

class _AboutProjectState extends State<AboutProject> {
  Map<String, dynamic> projectData = {};

  Future<Map<String, dynamic>> getProject() async {
    final queryPredicate = UProject.ID.eq(widget.id);
    print(widget.id);

    final request = ModelQueries.list<UProject>(
      UProject.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      var jsonResponse = response.data!.items[0]!.toJson();

      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  @override
  void initState() {
    super.initState();
    getProject().then((data) {
      setState(() {
        projectData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // UserProvider or UserClass?
    final currentUserID = Provider.of<UserProvider>(context, listen: false).id;
    final members = projectData['members'] ?? [];

    final hasJoined = members.contains(currentUserID);

    final joinButtonText = hasJoined ? 'Post' : 'Join';
    return Scaffold(
      appBar: AppBar(
          title: Text('Project Dashboard'),
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (projectData.containsKey('projectPicture') &&
                    projectData['projectPicture'].isNotEmpty)
                  Image.network(
                    projectData['projectPicture'],
                    fit: BoxFit.cover, // adjust the image to fit the widget
                    width: 300, // set the width of the widget
                    height: 300, // set the height of the widget
                  ),
                SizedBox(height: 20),
                Text(
                  projectData['name'] ?? '',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                if (projectData.containsKey('bio'))
                  Text('${projectData['bio']}'),
                SizedBox(height: 10),
                if (projectData.containsKey('description'))
                  Text('${projectData['description']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
