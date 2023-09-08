import 'dart:io';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/widgets/dashboard_user_display.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';
import 'package:serve_to_be_free/widgets/ui/dashboard_post.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:serve_to_be_free/data/users/providers/user_provider.dart';

import '../widgets/ui/my_scaffold.dart';
import '../widgets/ui/project_post.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

final List<Widget> myWidgets = [
  DashboardPost(),
  DashboardPost(),
  DashboardPost(),
  DashboardPost(),
  DashboardPost(),
  DashboardPost(),
];

class _DashboardPageState extends State<DashboardPage> {
  List<dynamic> posts = [];
  List<dynamic> profPics = ["", "", "", "", ""];
  List<dynamic> names = ["", "", "", "", ""];
  List<dynamic> ids = ["", "", "", "", ""];

  Future<List<dynamic>> getPosts() async {
    var posts = [];
    var projs = await ProjectHandlers.getMyProjects(
        Provider.of<UserProvider>(context, listen: false).id);
    for (var proj in projs) {
      if (proj.containsKey('posts') && proj['posts'] != null) {
        for (var post in proj['posts']) {
          final queryPredicate = UPost.ID.eq(post);

          final request = ModelQueries.list<UPost>(
            UPost.classType,
            where: queryPredicate,
          );
          final response = await Amplify.API.query(request: request).response;

          if (response.data!.items.isNotEmpty) {
            posts.add(response.data!.items[0]!.toJson());
            posts[posts.length - 1]['name'] = posts[posts.length - 1]['user']
                    ['firstName'] +
                ' ' +
                posts[posts.length - 1]['user']['lastName'];
            posts[posts.length - 1]['text'] =
                posts[posts.length - 1]['content'];
            posts[posts.length - 1]['imageUrl'] =
                posts[posts.length - 1]['user']['profilePictureUrl'];
          }
        }
      }
    }
    return posts;
    //final userId = Provider.of<UserProvider>(context, listen: false).id;
    // final url = Uri.parse(
    //     'http://44.203.120.103:3000/users/${Provider.of<UserProvider>(context, listen: false).id}/myPosts');
    // //'http://10.0.2.2:3000/users/${userId}/myPosts');

    // var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body);
    //   return jsonResponse;
    // } else {
    //   throw Exception('Failed to load projects');
    // }
  }

  Future<List<dynamic>> getUsers() async {
    try {
      final request = ModelQueries.list(UUser.classType);
      final response = await Amplify.API.query(request: request).response;

      final uusers = response.data?.items;
      if (uusers == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      uusers.shuffle();
      return uusers;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
    // var url = Uri.parse('http://44.203.120.103:3000/users');
    // var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body);
    //   jsonResponse.shuffle();

    //   return jsonResponse;
    // } else {
    //   throw Exception('Failed to load projects');
    // }
  }

  Map<String, List<dynamic>> getProfPics(users) {
    var profPicsAndIds = {"profPics": [], "ids": []};
    var profPicsUrls = [];
    var ids = [];

    for (var user in users) {
      var url = user.profilePictureUrl;
      if (url != null && url != "") {
        profPicsAndIds['profPics']?.add(url);
        profPicsAndIds['ids']?.add(user.id);
        profPicsUrls.add(url);
        ids.add(user.id);
      }
      if (profPicsUrls.length == 5) {
        return profPicsAndIds;
      }
    }
    for (var i = profPicsUrls.length; i < 5; i++) {
      profPicsAndIds['ids']?.add("");
      profPicsAndIds['profPics']?.add("");

      profPicsUrls.add("");
      ids.add("");
    }

    return profPicsAndIds;
  }

  List<dynamic> setNames(users) {
    var namesStr = [];
    for (var user in users) {
      var url = user.profilePictureUrl;
      if (url != null && url != "") {
        namesStr.add(user.firstName);
      }
      if (namesStr.length == 5) {
        return namesStr;
      }
    }
    for (var i = namesStr.length; i < 5; i++) {
      namesStr.add("");
    }
    return namesStr;
  }

  @override
  void initState() {
    super.initState();
    getPosts().then((data) {
      setState(() {
        posts = data;
      });
    });
    getUsers().then((data) => {
          setState(() {
            var idsAndPics = getProfPics(data);
            profPics = idsAndPics["profPics"]!;
            ids = idsAndPics["ids"]!;
            names = setNames(data);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Dashboard'),
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
      extendBody: false,
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      name: names[0] ?? "",
                      url: profPics[0] ?? "",
                      id: ids[0] ?? "",
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(20),
                  //   width: 2, // Set the width of the divider
                  //   height: 100, // Set the height of the divider
                  //   color: Colors.grey,
                  // ),
                  Container(
                      child: Expanded(
                          child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // LIST OF USERS
                        DashboardUserDisplay(
                          dimension: 60.0,
                          name: names[1] ?? "",
                          url: profPics[1] ?? "",
                          id: ids[1] ?? "",
                        ),
                        DashboardUserDisplay(
                          dimension: 60.0,
                          name: names[2] ?? "",
                          url: profPics[2] ?? "",
                          id: ids[2] ?? "",
                        ),
                        DashboardUserDisplay(
                          dimension: 60.0,
                          name: names[3] ?? "",
                          url: profPics[3] ?? "",
                          id: ids[3] ?? "",
                        ),
                        DashboardUserDisplay(
                          dimension: 60.0,
                          name: names[4] ?? "",
                          url: profPics[4] ?? "",
                          id: ids[4] ?? "",
                        ),
                      ],
                    ),
                  ))),
                ]),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 28, 72, 1.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Inkwell
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // Icon(Icons.menu_open_rounded, color: Colors.white),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "All Posts",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: -.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  //Inkewell
                  Container(
                    padding: EdgeInsets.all(12),
                    color: Color.fromRGBO(35, 107, 140, 1.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                        Container(
                          width: 5,
                        ),
                        InkWell(
                            onTap: () {
                              context.go('/dashboard/createapost');
                            },
                            child: Container(
                                child: Text(
                              "Create a Post",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: -.5),
                            ))),
                      ],
                    ),
                  ),
                ]),
          ),
          if (posts.isEmpty)
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "Join a project then view posts here",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  // compute the index of the reversed list
                  //print(posts[index]['_id']);
                  return ProjectPost(
                      id: posts[index]['id'],
                      name: posts[index]['name'],
                      postText: posts[index]['text'],
                      profURL: posts[index]['imageUrl'] ?? '',
                      date: posts[index]['date'] ?? '');
                  // return DashboardUserDisplay(
                  //     dimension: 60.0,
                  //     name: projectData['posts']?[index]['text']);
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
