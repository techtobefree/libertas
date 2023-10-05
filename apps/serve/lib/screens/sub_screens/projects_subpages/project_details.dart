import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
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

import '../../../data/projects/project_handlers.dart';
import '../../../models/ModelProvider.dart';

class ProjectDetails extends StatefulWidget {
  final String? id;

  const ProjectDetails({Key? key, required this.id}) : super(key: key);

  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  Map<String, dynamic> projectData = {};
  List<dynamic> users = [];

  var sponsor = 0.0;

  Future<Map<String, dynamic>> getProjects() async {
    final queryPredicate = UProject.ID.eq(widget.id);

    final request = ModelQueries.list<UProject>(
      UProject.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      // var url = Uri.parse('http://44.203.120.103:3000/projects/${widget.id}');
      // var response = await http.get(url);
      // if (response.statusCode == 200) {
      var jsonResponse = response.data!.items[0]!.toJson();

      // print(jsonResponse['sponsors']);
      // if (jsonResponse.containsKey('sponsors') &&
      //     jsonResponse['sponsors'] != null) {
      //   if (jsonResponse['sponsors'].length > 0) {
      //     for (var sponsorId in jsonResponse['sponsors']) {
      //       var sponsorObj = await getSponsor(sponsorId);

      //       sponsor += sponsorObj['amount'];
      //     }
      //   }
      // }
      if (jsonResponse.containsKey('posts') && jsonResponse['posts'] != null) {
        var newPosts = [];
        for (var post in jsonResponse['posts']) {
          final queryPredicate = UPost.ID.eq(post);
          final request = ModelQueries.list<UPost>(
            UPost.classType,
            where: queryPredicate,
          );
          final response = await Amplify.API.query(request: request).response;

          if (response.data!.items.isNotEmpty) {
            newPosts.add(response.data!.items[0]!.toJson());
            newPosts[newPosts.length - 1]['name'] =
                newPosts[newPosts.length - 1]['user']['firstName'] +
                    newPosts[newPosts.length - 1]['user']['lastName'];
            newPosts[newPosts.length - 1]['text'] =
                newPosts[newPosts.length - 1]['content'];
            newPosts[newPosts.length - 1]['imageUrl'] =
                newPosts[newPosts.length - 1]['user']['profilePictureUrl'];

            // newPosts[newPosts.length - 1] =
            //     convertDate(newPosts[newPosts.length - 1]['date']);
          }
        }
        jsonResponse['posts'] = newPosts;
      }
      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  Future<List> getMembers(idArr) async {
    var users = [];
    for (int i = 0; i < 5; i++) {
      if (idArr.length > i) {
        var user = await UserHandlers.getUUserById(idArr[i]);
        users.add(user);
      }
    }
    return users;
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

  List<Widget> generateUserWidgets(List<dynamic> users) {
    List<Widget> userWidgets = [];
    for (var i = 1; i < 4 && i < users.length; i++) {
      userWidgets.add(
        DashboardUserDisplay(
          dimension: 60.0,
          name: users[i].firstName ?? "",
          url: users[i].profilePictureUrl ?? "",
          id: users[i].id ?? "",
        ),
      );
    }
    return userWidgets;
  }

  @override
  void initState() {
    super.initState();
    getProjects().then((data) {
      getMembers(data['members']).then((value) {
        setState(() {
          users = value;
        });
      });
      setState(() {
        projectData = data;
        // print(projectData);
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
      body: SingleChildScrollView(
        // Wrap your Column with SingleChildScrollView

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Add horizontal margins
                  SizedBox(height: 20),
                  Text(
                    projectData['name'] ?? '',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 5),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${projectData['members']?.length ?? ''} Members',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 5),
                        SizedBox(
                            width:
                                5), // Add spacing between the members count and the dot
                        Text(
                          '•', // Horizontal dot separator
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                            width:
                                5), // Add spacing between the "Members" text and the hyperlink
                        GestureDetector(
                          onTap: () {
                            print("view members");
                            context.pushNamed("showmembers", queryParameters: {
                              'projectId': projectData['id'],
                            });
                          },
                          child: Text(
                            'View Members',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  if (projectData.containsKey('date'))
                    Text(
                      '${projectData['date']}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 3.0,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                            child: DashboardUserDisplay(
                              dimension: 80.0,
                              name: users.isNotEmpty
                                  ? users[0].firstName ?? ""
                                  : "",
                              url: users.isNotEmpty
                                  ? users[0].profilePictureUrl ?? ""
                                  : "",
                              id: users.isNotEmpty ? users[0].id ?? "" : "",
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(20),
                          //   width: 1, // Set the width of the divider
                          //   height: 90, // Set the height of the divider
                          //   color: Colors.grey,
                          // ),
                          Container(
                              child: Expanded(
                                  child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: generateUserWidgets(users),
                            ),
                          ))),
                        ]),
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

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // navigate to about page
                      context.pushNamed("projectabout",
                          queryParameters: {'id': projectData['id']},
                          pathParameters: {'id': projectData['id']});
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 16, 34, 65),
                      ),
                    ),
                    child: Text('About'),
                  ),
                  Visibility(
                    visible: projectData
                        .isNotEmpty, // Show the button when hasJoined is not null
                    child: ElevatedButton(
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
                  ),
                ],
              ),
            ),
            // Expanded(
            // child:
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: projectData['posts']?.length ?? 0,
              itemBuilder: (context, index) {
                final reversedIndex = projectData['posts'].length -
                    index -
                    1; // compute the index of the reversed list
                return ProjectPost(
                  id: '',
                  name:
                      '${projectData['posts'][reversedIndex]['user']['firstName']} ${projectData['posts'][reversedIndex]['user']['lastName']}',
                  postText: projectData['posts'][reversedIndex]['text'],
                  profURL:
                      projectData['posts'][reversedIndex]['imageUrl'] ?? '',
                  date: projectData['posts'][reversedIndex]['date'] ?? '',
                  userId:
                      projectData['posts'][reversedIndex]['user']['id'] ?? '',
                );
                // return DashboardUserDisplay(
                //     dimension: 60.0,
                //     name: projectData['posts']?[index]['text']);
              },
              // ),
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
            projectId: projectData['id'],
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
    UProject? uproject =
        await ProjectHandlers.getUProjectById(projectData['id']);
    var uprojectMems = uproject!.members;
    var memID = Provider.of<UserProvider>(context, listen: false).id;
    if (uprojectMems != null) {
      uprojectMems.add(memID);
    }

    final addedMemUProj = uproject.copyWith(members: uprojectMems);

    try {
      final request = ModelMutations.update(addedMemUProj);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
      if (response.data!.members!.isNotEmpty) {
        setState(() {
          projectData['members'] = projectData['members'] != null
              ? [...projectData['members'], memID]
              : [memID];
        });
      }
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }

    return null;
    // final url = Uri.parse(
    //     'http://44.203.120.103:3000/projects/${projectData['_id']}/member');
    // final Map<String, dynamic> data = {
    //   'memberId': Provider.of<UserProvider>(context, listen: false).id
    // };
    // final response = await http.put(
    //   url,
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(data),
    // );

    // if (response.statusCode == 200) {
    //   // API call successful\
    // setState(() {
    //   projectData['members'] = projectData['members'] != null
    //       ? [...projectData['members'], data['memberId']]
    //       : [data['memberId']];
    //   });
    // } else {
    //   // API call unsuccessful
    //   print('Failed to fetch data ${response.body}');
    // }
  }
}
