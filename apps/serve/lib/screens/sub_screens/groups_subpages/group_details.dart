import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/sponsors/handlers/sponsor_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/widgets/dashboard_user_display.dart';
import 'package:serve_to_be_free/widgets/group_post_dialogue.dart';
// import 'package:serve_to_be_free/widgets/ui/group_post.dart';
import 'package:serve_to_be_free/widgets/project_post_dialogue.dart';
import 'package:serve_to_be_free/data/groups/group_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/widgets/ui/project_post.dart';

class GroupDetails extends StatefulWidget {
  final String? id;

  const GroupDetails({Key? key, required this.id}) : super(key: key);

  @override
  GroupDetailsState createState() => GroupDetailsState();
}

class GroupDetailsState extends State<GroupDetails> {
  Map<String, dynamic> groupData = {};
  UGroup? ugroup;
  List<dynamic> users = [];
  bool isLoading = true;

  var sponsor = 0.0;

  Future<Map<String, dynamic>> getGroups() async {
    final queryPredicate = UGroup.ID.eq(widget.id);

    final request = ModelQueries.list<UGroup>(
      UGroup.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      // var url = Uri.parse('http://44.203.120.103:3000/groups/${widget.id}');
      // var response = await http.get(url);
      // if (response.statusCode == 200) {
      var jsonResponse = response.data!.items[0]!.toJson();
      jsonResponse['ugroup'] = response.data!.items[0];

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
          print(response);

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
        print(jsonResponse['ugroup']);
        jsonResponse['posts'] = newPosts;
      }
      return jsonResponse;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  Future<List> getMembers(idArr) async {
    var users = [];
    String? leaderId = groupData['leader'];
    if (leaderId != null && leaderId != "") {
      var user = await UserHandlers.getUUserById(groupData['leader']);
      users.add(user);
    }
    for (int i = 0; i < 5; i++) {
      if (idArr.length > i) {
        if (idArr[i] != groupData['leader']) {
          var user = await UserHandlers.getUUserById(idArr[i]);
          users.add(user);
        }
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
          dimension: 55.0,
          name: users[i].firstName ?? "",
          url: users[i].profilePictureUrl ?? "",
          id: users[i].id ?? "",
        ),
      );
      userWidgets.add(SizedBox(
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
    var data = await getGroups();
    setState(() {
      groupData = data;
    });

    var members = await getMembers(data['members']);
    setState(() {
      users = members;
    });

    var id = widget.id;
    // if (id != null) {
    //   var sponsorAmount = await SponsorHandlers.getUSponsorAmountByGroup(id);
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
    final bool isLeader = currentUserID == groupData['leader'];

    final members = groupData['members'] ?? [];

    final hasJoined = members.contains(currentUserID);

    final joinButtonText = hasJoined ? 'Post' : 'Join';
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
              'Group Dashboard',
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
                      groupData['name'] ?? '',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    if (isLeader)
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 16, 34, 65),
                            ),
                          ),
                          onPressed: () => context.goNamed('groupsdetailsform',
                                  queryParameters: {
                                    'id': groupData['id'],
                                  }),
                          child: const Text(
                            "Edit Group",
                            style: TextStyle(color: Colors.white),
                          )),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${groupData['members']?.length ?? ''} Members',
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 5),
                          const SizedBox(width: 5),
                          const Text(
                            '•', // Horizontal dot separator
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              print("view members");
                              context.pushNamed("showgroupmembers",
                                  queryParameters: {
                                    'groupId': groupData['id'],
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
                    // if (groupData.containsKey('date'))
                    //   Text(
                    //     '${groupData['date']}',
                    //     style: const TextStyle(
                    //       fontSize: 12,
                    //     ),
                    //   ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                              context.pushNamed("groupabout",
                                  queryParameters: {'id': groupData['id']},
                                  pathParameters: {'id': groupData['id']});
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
                                  .pushNamed("groupproject", queryParameters: {
                                'id': groupData['id'],
                              }, pathParameters: {
                                'id': groupData['id'],
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
                              "Projects",
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
                                        child: Text(
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
                    //     context.pushNamed("groupabout",
                    //         queryParameters: {'id': groupData['id']},
                    //         pathParameters: {'id': groupData['id']});
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
                    //   visible: groupData
                    //       .isNotEmpty, // Show the button when hasJoined is not null
                    //   child: ElevatedButton(
                    //     onPressed: () => {
                    //       if (!groupData['members'].contains(currentUserID))
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
                itemCount: groupData['posts']?.length ?? 0,
                itemBuilder: (context, index) {
                  final reversedIndex = groupData['posts'].length -
                      index -
                      1; // compute the index of the reversed list
                  return Post(
                    id: '',
                    name:
                        '${groupData['posts'][reversedIndex]['user']['firstName']} ${groupData['posts'][reversedIndex]['user']['lastName']}',
                    postText: groupData['posts'][reversedIndex]['text'],
                    profURL:
                        groupData['posts'][reversedIndex]['imageUrl'] ?? '',
                    date: groupData['posts'][reversedIndex]['date'] ?? '',
                    userId:
                        groupData['posts'][reversedIndex]['user']['id'] ?? '',
                  );
                  // return DashboardUserDisplay(
                  //     dimension: 60.0,
                  //     name: groupData['posts']?[index]['text']);
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
    if (!groupData['members'].contains(currentUserID)) {
      // addMember();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Join group to post',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
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
          return GroupPostDialog(
            groupId: groupData['id'],
          );
        },
      ).then((value) => setState(() {}));
      getGroups().then((data) {
        setState(() {
          groupData = data;
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
}
