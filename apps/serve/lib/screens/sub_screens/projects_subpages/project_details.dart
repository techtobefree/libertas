import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/posts/post_handlers.dart';
import 'package:serve_to_be_free/data/sponsors/handlers/sponsor_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/utilities/helper.dart';
import 'package:serve_to_be_free/widgets/dashboard_user_display.dart';
import 'package:serve_to_be_free/widgets/ui/project_post.dart';
import 'package:serve_to_be_free/widgets/project_post_dialogue.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class ProjectDetails extends StatefulWidget {
  final String? id;

  const ProjectDetails({Key? key, required this.id}) : super(key: key);

  @override
  ProjectDetailsState createState() => ProjectDetailsState();
}

class ProjectDetailsState extends State<ProjectDetails> {
  Map<String, dynamic> projectData = {};
  UProject? uproject;
  List<dynamic> users = [];
  bool isLoading = true;

  // var sponsor = 0.0;

  Future<Map<String, dynamic>> getProject() async {
    // final queryPredicate = UProject.ID.eq(widget.id);
// ModelQueries.get(modelType, modelIdentifier)
    final request = ModelQueries.get<UProject>(
      UProject.classType,
      UProjectModelIdentifier(id: widget.id!),
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data != null) {
      UProject proj = response.data!;

      print(proj.events);
      // var url = Uri.parse('http://44.203.120.103:3000/projects/${widget.id}');
      // var response = await http.get(url);
      // if (response.statusCode == 200) {
      var jsonResponse = response.data!.toJson();
      jsonResponse['uproject'] = response.data!;

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
      var newPosts = await PostHandlers.getUPostsByProject(widget.id!);
      jsonResponse['posts'] = [];

      for (var post in newPosts!) {
        jsonResponse['posts'].add(post!.toJson());
      }
      // jsonResponse['posts'] = data.toJson();
      jsonResponse['posts'] = newPosts;
      print(jsonResponse['posts']);

      // if (jsonResponse.containsKey('posts') && jsonResponse['posts'] != null) {
      //   for (var post in jsonResponse['posts']) {
      //     // final queryPredicate = UPost.ID.eq(post);
      //     final request = ModelQueries.get<UPost>(
      //       UPost.classType,
      //       UPostModelIdentifier(id: post),
      //     );
      //     final response = await Amplify.API.query(request: request).response;

      //     if (response.data != null) {
      //       newPosts.add(response.data!.toJson());
      //       newPosts[newPosts.length - 1]['name'] =
      //           newPosts[newPosts.length - 1]['user']['firstName'] +
      //               newPosts[newPosts.length - 1]['user']['lastName'];
      //       newPosts[newPosts.length - 1]['text'] =
      //           newPosts[newPosts.length - 1]['content'];
      //       newPosts[newPosts.length - 1]['imageUrl'] =
      //           newPosts[newPosts.length - 1]['user']['profilePictureUrl'];

      //       // newPosts[newPosts.length - 1] =
      //       //     convertDate(newPosts[newPosts.length - 1]['date']);
      //     }
      //   }
      //   jsonResponse['posts'] = newPosts;
      // }
      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  Future<List> getMembers(idArr) async {
    var users = [];
    String? leaderId = projectData['leader'];
    if (leaderId != null && leaderId != "") {
      var user = await UserHandlers.getUUserById(projectData['leader']);
      users.add(user);
    }
    for (int i = 0; i < 5; i++) {
      if (idArr.length > i) {
        if (idArr[i] != projectData['leader']) {
          var user = await UserHandlers.getUUserById(idArr[i]);
          users.add(user);
        }
      }
    }
    return users;
  }

  // Future<Map<String, dynamic>> getSponsor(id) async {
  //   final response =
  //       await http.get(Uri.parse('http://44.203.120.103:3000/sponsors/$id'));
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     return jsonResponse as Map<String, dynamic>;
  //   } else {
  //     throw Exception('Failed to load sponsor');
  //   }
  // }

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
    if (users.isNotEmpty) {
      users.removeAt(0);
    }

    // Shuffle the remaining users
    users.shuffle(Random());

    for (var i = 0; i < 4 && i < users.length; i++) {
      userWidgets.add(
        DashboardUserDisplay(
          dimension: 55.0,
          name: users[i].firstName ?? "",
          url: users[i].profilePictureUrl ?? "",
          id: users[i].id ?? "",
        ),
      );
      userWidgets.add(const SizedBox(
        width: 5,
      ));
    }
    return userWidgets;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // try {
    var data = await getProject();
    setState(() {
      projectData = data;
    });

    var members = await getMembers(data['members']);
    // var members = await ProjectHandlers.getProjMembers(widget.id!);
    setState(() {
      users = members;
    });

    // var id = widget.id;
    // if (id != null) {
    //   var sponsorAmount = await SponsorHandlers.getUSponsorAmountByProject(id);
    //   setState(() {
    //     sponsor = sponsorAmount;
    //   });
    // }

    // Set isLoading to false to enable the screen
    setState(() {
      isLoading = false;
    });
    // } catch (e) {
    //   // Handle any errors that occur during data fetching
    //   print('Error: $e');
    //   // Optionally, you can also show an error message to the user
    // }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserID = BlocProvider.of<UserCubit>(context).state.id;

    // final members = projectData['members'] ?? [];

    // final hasJoined = members.contains(currentUserID);

    // final joinButtonText = hasJoined ? 'Post' : 'Join';
    if (isLoading) {
      // Return a loading indicator or a splash screen while data is being fetched
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
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
                padding: const EdgeInsets.symmetric(horizontal: 0),
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
                              context
                                  .pushNamed("showmembers", queryParameters: {
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
                        formatDate(projectData['date']),
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
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: generateUserWidgets(users),
                              ),
                            )),
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              context.pushNamed("projectabout",
                                  queryParameters: {'id': projectData['id']},
                                  pathParameters: {'id': projectData['id']});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 198, 198, 198), // Background color
                              foregroundColor: Colors.black, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Rounded corners
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: const Text(
                              'About',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              // Button action goes here
                              context
                                  .pushNamed("projectevents", queryParameters: {
                                'projectId': projectData['id'],
                              }, pathParameters: {
                                'projectId': projectData['id'],
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 198, 198, 198), // Background color
                              foregroundColor: Colors.black, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Rounded corners
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: Text(
                              "Events",
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 28, 72, 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Inkwell
                            Container(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {
                                    // _showDropdown(context);
                                    // Add your click action here
                                    // For example, you can show a dialog, navigate to a new screen, etc.
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.sort,
                                        color: Colors.white,
                                        size: 24, // Adjust the size as needed
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: const Text(
                                          "All Posts",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            //Inkewell
                            Container(
                              padding: const EdgeInsets.all(12),
                              color: const Color.fromRGBO(35, 107, 140, 1.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Container(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        onPostClick(currentUserID);
                                      },
                                      child: const Text(
                                        "Create a Post",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: -.5),
                                      )),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // navigate to about page
                    //     context.pushNamed("projectabout",
                    //         queryParameters: {'id': projectData['id']},
                    //         pathParameters: {'id': projectData['id']});
                    //   },
                    //   style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all<Color>(
                    //       const Color.fromARGB(255, 16, 34, 65),
                    //     ),
                    //   ),
                    //   child: const Text(
                    //     'About',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                    // Visibility(
                    //   visible: projectData
                    //       .isNotEmpty, // Show the button when hasJoined is not null
                    //   child: ElevatedButton(
                    //     onPressed: () => {
                    //       if (!projectData['members'].contains(currentUserID))
                    //         {addMember()}
                    //       else
                    //         {onPostClick(currentUserID)}
                    //     },
                    //     style: ButtonStyle(
                    //       backgroundColor: MaterialStateProperty.all<Color>(
                    //         const Color.fromARGB(255, 16, 34, 65),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       joinButtonText,
                    //       style: const TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    // ),
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
                  // final reversedIndex = projectData['posts'].length -
                  //     index -
                  //     1; // compute the index of the reversed list
                  final reversedIndex = index;
                  return Post(
                    id: '',
                    name:
                        '${projectData['posts'][reversedIndex].user.firstName} ${projectData['posts'][reversedIndex].user.lastName}',
                    postText: projectData['posts'][reversedIndex].content,
                    profURL: projectData['posts'][reversedIndex]
                            .user
                            .profilePictureUrl ??
                        '',
                    date: projectData['posts'][reversedIndex].date ?? '',
                    userId: projectData['posts'][reversedIndex].user.id ?? '',
                    photoUrl:
                        projectData['posts'][reversedIndex].postPicture ?? '',
                  );

                  // return Post(
                  //   id: '',
                  //   name:
                  //       '${projectData['posts'][reversedIndex]['user']['firstName']} ${projectData['posts'][reversedIndex]['user']['lastName']}',
                  //   postText: projectData['posts'][reversedIndex]['content'],
                  //   profURL: projectData['posts'][reversedIndex]['user']
                  //           ['profilePictureUrl'] ??
                  //       '',
                  //   date: projectData['posts'][reversedIndex]['date'] ?? '',
                  //   userId:
                  //       projectData['posts'][reversedIndex]['user']['id'] ?? '',
                  //   photoUrl: projectData['posts'][reversedIndex]
                  //           ['postPicture'] ??
                  //       '',
                  // );
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
  }

  void updatePosts(List<dynamic> newPosts) {}

  void onPostClick(currentUserID) async {
    if (!projectData['members'].contains(currentUserID)) {
      // addMember();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Join project to post',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Dismiss'),
                ),
              ],
            ),
          ); // Custom dialog widget
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProjectPostDialog(
            projectId: projectData['id'],
          );
        },
      ).then((value) => setState(() {
            getProject().then((data) {
              setState(() {
                projectData = data;
              });
            });
          }));
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
}
