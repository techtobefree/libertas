import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/groups/group_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/repository/repository.dart';

class AboutGroup extends StatefulWidget {
  final String? id;

  const AboutGroup({Key? key, required this.id}) : super(key: key);

  @override
  AboutGroupState createState() => AboutGroupState();
}

class AboutGroupState extends State<AboutGroup> {
  Map<String, dynamic> groupData = {};

  Future<Map<String, dynamic>> getGroup() async {
    final queryPredicate = UGroup.ID.eq(widget.id);

    final request = ModelQueries.list<UGroup>(
      UGroup.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      var jsonResponse = response.data!.items[0]!.toJson();

      return jsonResponse;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  @override
  void initState() {
    super.initState();
    getGroup().then((data) {
      setState(() {
        groupData = data;
      });
    });
    var id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    // UserProvider or UserClass?
    final currentUserID = BlocProvider.of<UserCubit>(context).state.id;

    final members = groupData['members'] ?? [];
    final leader = groupData['leader'];

    // unused
    //final hasJoined = members.contains(currentUserID);
    //final joinButtonText = hasJoined ? 'Post' : 'Join';

    bool shouldDisplayEditButton = false;

    if (members.length > 0) {
      shouldDisplayEditButton =
          (((members[0] ?? '') == currentUserID) || leader == currentUserID);
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'About Group',
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
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: shouldDisplayEditButton,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 16, 34, 65),
                      ),
                    ),
                    onPressed: () {
                      // Handle the edit button press here
                      context.goNamed(
                        'groupsdetailsform',
                        queryParameters: {
                          'id': groupData['id'],
                        },
                      );
                    },
                    child: const Text(
                      'Edit Group',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (groupData.containsKey('groupPicture') &&
                    groupData['groupPicture'].isNotEmpty)
                  repo.image(
                    groupData['groupPicture'],
                    fit: BoxFit.fill, // adjust the image to fit the widget
                    width: 300,
                    // height: 300,
                  ),
                const SizedBox(height: 20),
                Text(
                  groupData['name'] ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${groupData['members']?.length ?? ''} Members',
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
                              .pushNamed("showgroupmembers", queryParameters: {
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
                if (groupData['members'] != null &&
                    !groupData['members']
                        .contains(BlocProvider.of<UserCubit>(context).state.id))
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        addMember();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 16, 34, 65), // Background color
                        foregroundColor: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text(
                        'Join Group',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                const Divider(
                  indent: 0,
                  endIndent: 0,
                ),
                const SizedBox(height: 10),
                if (groupData.containsKey('city') &&
                    groupData.containsKey('state') &&
                    groupData.containsKey('zipCode'))
                  Text(
                      '${groupData['city']}, ${groupData['state']}  ${groupData['zipCode']}'),
                const SizedBox(height: 10),
                if (groupData.containsKey('bio')) Text('${groupData['bio']}'),
                const SizedBox(height: 10),
                if (groupData.containsKey('description'))
                  Text('${groupData['description']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addMember() async {
    UGroup? ugroup = await GroupHandlers.getUGroupById(groupData['id']);
    var ugroupMems = ugroup!.members;
    var memID = BlocProvider.of<UserCubit>(context).state.id;
    if (ugroupMems != null) {
      ugroupMems.add(memID);
    }

    final addedMemUGroup = ugroup.copyWith(members: ugroupMems);

    try {
      final request = ModelMutations.update(addedMemUGroup);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
      if (response.data!.members!.isNotEmpty) {
        setState(() {
          groupData['members'] = groupData['members'] != null
              ? [...groupData['members'], memID]
              : [memID];
        });
      }
    } catch (e) {
      throw Exception('Failed to update group: $e');
    }
  }
}
