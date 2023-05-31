import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/data/users/models/user_class.dart';
//import 'package:serve_to_be_free/utilities/user_model.dart';
import 'package:serve_to_be_free/widgets/dashboard_user_display.dart';
import 'package:intl/intl.dart';

import 'package:serve_to_be_free/widgets/ui/dashboard_post.dart';
import 'package:serve_to_be_free/widgets/ui/project_post.dart';
import 'package:serve_to_be_free/widgets/post_dialogue.dart';

class ProjectDetails extends StatefulWidget {
  final String? id;

  const ProjectDetails({Key? key, required this.id}) : super(key: key);

  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  Map<String, dynamic> projectData = {};
  var sponsor = 0.0;

  Future<Map<String, dynamic>> getProjects() async {
    var url = Uri.parse('http://44.203.120.103:3000/projects/${widget.id}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse['sponsors']);
      if (jsonResponse.containsKey('sponsors')) {
        if (jsonResponse['sponsors'].length > 0) {
          for (var sponsorId in jsonResponse['sponsors']) {
            var sponsorObj = await getSponsor(sponsorId);

            sponsor += sponsorObj['amount'];
          }
        }
      }

      for (var post in jsonResponse['posts']) {
        post['date'] = convertDate(post['date']);
      }
      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  Future<Map<String, dynamic>> getSponsor(id) async {
    final response =
        await http.get(Uri.parse('http://44.203.120.103:3000/sponsors/$id'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load sponsor');
    }
  }

  String convertDate(String dateString) {
    // parse the input string into a DateTime object
    String dateStr = dateString.split(' ').take(5).join(' ');
    DateFormat inputFormat = DateFormat("EEE MMM dd yyyy HH:mm:ss");
    DateTime date = inputFormat.parse(dateStr);

    // format the DateTime object into the desired format
    String formattedDate = DateFormat('MM/dd/yyyy hh:mm a').format(date);

    // return the formatted string
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    getProjects().then((data) {
      setState(() {
        projectData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              projectData['name'] ?? '',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            if (sponsor > 0)
              Text(
                  'Money pledged to this project: \$${sponsor.toStringAsFixed(2)}'),
            SizedBox(height: 10),
            if (projectData.containsKey('city'))
              Text('${projectData['city']}, ${projectData['state']}'),
            SizedBox(height: 10),
            if (projectData.containsKey('bio')) Text(projectData['bio']),
            SizedBox(height: 10),
            if (projectData.containsKey('date')) Text('${projectData['date']}'),
            Text(
              '${projectData['members']?.length ?? ''} Members',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // navigate to about page
                context.pushNamed("projectabout",
                    params: {'id': projectData['_id']});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 16, 34, 65),
                ),
              ),
              child: Text('About'),
            ),
            ElevatedButton(
              onPressed: () => {
                if (!projectData['members'].contains(currentUserID))
                  {addMember()}
                else
                  {onPostClick(currentUserID)}
              },
              child: Text(joinButtonText),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 16, 34, 65),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: projectData['posts']?.length ?? 0,
                itemBuilder: (context, index) {
                  final reversedIndex = projectData['posts'].length -
                      index -
                      1; // compute the index of the reversed list
                  return ProjectPost(
                    id: '',
                    name: projectData['posts'][reversedIndex]['name'],
                    postText: projectData['posts'][reversedIndex]['text'],
                    profURL:
                        projectData['posts'][reversedIndex]['imageUrl'] ?? '',
                    date: projectData['posts'][reversedIndex]['date'] ?? '',
                  );
                  // return DashboardUserDisplay(
                  //     dimension: 60.0,
                  //     name: projectData['posts']?[index]['text']);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updatePosts(List<dynamic> newPosts) {}

  void onPostClick(currentUserID) async {
    if (!projectData['members'].contains(currentUserID)) {
      addMember();
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return JoinProjectDialog(
            projectId: projectData['_id'],
          );
        },
      ).then((value) => setState(() {}));
      getProjects().then((data) {
        setState(() {
          projectData = data;
        });
      });
    }
  }

  Future<String> getName(id) async {
    final url = Uri.parse('http://44.203.120.103:3000/users/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // API call successful\

      final res = json.decode(response.body);
      var name = res['firstName'] + '' + res['lastName'];
      return name;
    }
    return '';
  }

  Future<void> addMember() async {
    final url = Uri.parse(
        'http://44.203.120.103:3000/projects/${projectData['_id']}/member');
    final Map<String, dynamic> data = {
      'memberId': Provider.of<UserProvider>(context, listen: false).id
    };
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // API call successful\
      setState(() {
        projectData['members'] = projectData['members'] != null
            ? [...projectData['members'], data['memberId']]
            : [data['memberId']];
      });
    } else {
      // API call unsuccessful
      print('Failed to fetch data ${response.body}');
    }
  }
}
