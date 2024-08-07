import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/notifications/notification.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/widgets/dashboard_user_display.dart';
import 'package:serve_to_be_free/widgets/ui/project_post.dart';
import 'package:serve_to_be_free/widgets/project_post_dialogue.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class LeadProjectDetails extends StatefulWidget {
  final String? id;

  const LeadProjectDetails({Key? key, required this.id}) : super(key: key);

  @override
  LeadProjectDetailsState createState() => LeadProjectDetailsState();
}

class LeadProjectDetailsState extends State<LeadProjectDetails> {
  Map<String, dynamic> projectData = {};
  List<dynamic> users = [];
  bool userApplied = false;

  var sponsor = 0.0;
  String buttonText = 'Apply to Lead Project';

  Future<Map<String, dynamic>> getProjects() async {
    final queryPredicate = UProject.ID.eq(widget.id);

    final request = ModelQueries.list<UProject>(
      UProject.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      var jsonResponse = response.data!.items[0]!.toJson();

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
      NotificationHandlers.isUserWaitingOnLeaderApproval(
              BlocProvider.of<UserCubit>(context).state.id, widget.id!)
          .then((bool) {
        setState(() {
          userApplied = bool;
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
    final currentUserID = BlocProvider.of<UserCubit>(context).state.id;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Project Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
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
      body: SingleChildScrollView(
        // Wrap your Column with SingleChildScrollView

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Add horizontal margins
                  const SizedBox(height: 20),
                  Text(
                    projectData['name'] ?? '',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 5),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${projectData['members']?.length ?? ''} Members',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 5),
                        const SizedBox(
                            width:
                                5), // Add spacing between the members count and the dot
                        const Text(
                          '•', // Horizontal dot separator
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(
                            width:
                                5), // Add spacing between the "Members" text and the hyperlink
                        GestureDetector(
                          onTap: () {
                            print("view members");
                            context.pushNamed("showmembers", queryParameters: {
                              'projectId': projectData['id'],
                            });
                          },
                          child: const Text(
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
                  const SizedBox(height: 10),
                  if (projectData.containsKey('date'))
                    Text(
                      '${projectData['date']}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 10, left: 10),
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
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: generateUserWidgets(users),
                            ),
                          )),
                        ]),
                  ),
                  const SizedBox(height: 10),
                  if (sponsor > 0)
                    Text(
                        'Money pledged to this project: \$${sponsor.toStringAsFixed(2)}'),
                  const SizedBox(height: 10),
                  if (projectData.containsKey('city'))
                    Text('${projectData['city']}, ${projectData['state']}'),
                  const SizedBox(height: 10),
                  if (projectData.containsKey('bio')) Text(projectData['bio']),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // navigate to about page
                      context.pushNamed("projectabout",
                          queryParameters: {'id': projectData['id']},
                          pathParameters: {'id': projectData['id']});
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(16, 34, 65, 1),
                      ),
                    ),
                    child: const Text(
                      'About',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Visibility(
                    visible: projectData.isNotEmpty,
                    child: !userApplied
                        ? ElevatedButton(
                            onPressed: () {
                              if (buttonText != "Post") {
                                showPopUp(
                                  projectData['members'][0],
                                  BlocProvider.of<UserCubit>(context).state.id,
                                );
                              } else {
                                onPostClick(currentUserID);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 16, 34, 65),
                              ),
                            ),
                            child: Text(
                              buttonText,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        : const Text("Waiting on leader approval"),
                  )
                ],
              ),
            ),
            // Expanded(
            // child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: projectData['posts']?.length ?? 0,
              itemBuilder: (context, index) {
                final reversedIndex = projectData['posts'].length -
                    index -
                    1; // compute the index of the reversed list
                return Post(
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

  dynamic showPopUp(String ownerID, String applicantID) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController messageController = TextEditingController();

        return AlertDialog(
          title: Text('Enter your message to project owner'),
          content: TextField(
            controller: messageController,
            decoration: InputDecoration(
              hintText: 'Type your message...',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String userMessage = messageController.text;

                NotificationHandlers.createNotification(
                    ownerID: ownerID,
                    applicantID: applicantID,
                    date: DateFormat('MMM d, yyyy').format(DateTime.now()),
                    message: userMessage,
                    status: "INCOMPLETE",
                    projectID: projectData['id']);

                Navigator.of(context).pop(); // Close the dialog

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thank you'),
                      content: Text('Your application is awaiting approval.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the second dialog
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
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
          return ProjectPostDialog(
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
    var memID = BlocProvider.of<UserCubit>(context).state.id;

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
  }
}
