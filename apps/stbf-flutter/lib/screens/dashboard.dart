import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  Future<List<dynamic>> getPosts() async {

    //final userId = Provider.of<UserProvider>(context, listen: false).id;
    final url = Uri.parse(
        'http://44.203.120.103:3000/users/${Provider.of<UserProvider>(context, listen: false).id}/myPosts');
    //'http://10.0.2.2:3000/users/${userId}/myPosts');


    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  Future<List<dynamic>> getUsers() async {
    var url = Uri.parse('http://44.203.120.103:3000/users');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      jsonResponse.shuffle();

      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  List<dynamic> getProfPics(users) {
    var profPicsUrls = [];

    for (var user in users) {
      var url = user['profilePictureUrl'];
      if (url != null && url != "") {
        profPicsUrls.add(url);
      }
      if (profPicsUrls.length == 5) {
        return profPicsUrls;
      }
    }
    for (var i = profPicsUrls.length; i < 5; i++) {
      profPicsUrls.add("");
    }
    return profPicsUrls;
  }

  List<dynamic> setNames(users) {
    var namesStr = [];
    for (var user in users) {
      var url = user['profilePictureUrl'];
      if (url != null && url != "") {
        namesStr.add(user['firstName']);
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
        print("this is the new data $data");

        posts = data;
      });
    });
    getUsers().then((data) => {
          setState(() {
            profPics = getProfPics(data);
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
                        url: profPics[0] ?? ""),
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
                            url: profPics[1] ?? ""),
                        DashboardUserDisplay(
                            dimension: 60.0,
                            name: names[2] ?? "",
                            url: profPics[2] ?? ""),
                        DashboardUserDisplay(
                            dimension: 60.0,
                            name: names[3] ?? "",
                            url: profPics[3] ?? ""),
                        DashboardUserDisplay(
                            dimension: 60.0,
                            name: names[4] ?? "",
                            url: profPics[4] ?? ""),
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
                      id: posts[index]['_id'],
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
