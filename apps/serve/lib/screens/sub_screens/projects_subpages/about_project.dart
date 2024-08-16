import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/points/points_handlers.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/sponsors/handlers/sponsor_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/repository/repository.dart';

class AboutProject extends StatefulWidget {
  final String? id;

  const AboutProject({Key? key, required this.id}) : super(key: key);

  @override
  AboutProjectState createState() => AboutProjectState();
}

class AboutProjectState extends State<AboutProject> {
  var sponsor = 0.0;
  bool needLeader = false;

  Map<String, dynamic> projectData = {};

  Future<Map<String, dynamic>> getProject() async {
    final queryPredicate = UProject.ID.eq(widget.id);

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
        if (projectData['leader'] == null || projectData['leader'].isEmpty) {
          needLeader = true;
        }
      });
    });
    var id = widget.id;
    if (id != null) {
      SponsorHandlers.getUSponsorAmountByProject(id).then(
        (value) {
          setState(() => sponsor = value);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // UserProvider or UserClass?
    final currentUserID = BlocProvider.of<UserCubit>(context).state.id;

    final members = projectData['members'] ?? [];
    final leader = projectData['leader'];

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
          'About Project',
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
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (needLeader == false) {
              context.pushNamed("projectdetails",
                  queryParameters: {'id': projectData['id']},
                  pathParameters: {'id': projectData['id']});
            }
            if (needLeader == true) {
              context.pushNamed("leadprojectdetails",
                  queryParameters: {'id': projectData['id']},
                  pathParameters: {'id': projectData['id']});
            }
          },
        ),
      ),
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
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 16, 34, 65),
                      ),
                    ),
                    onPressed: () {
                      // Handle the edit button press here
                      context.goNamed(
                        'projectdetailsform',
                        queryParameters: {
                          'id': projectData['id'],
                        },
                      );
                    },
                    child: const Text(
                      'Edit Project',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (projectData.containsKey('projectPicture') &&
                    projectData['projectPicture'].isNotEmpty)
                  repo.image(
                    projectData['projectPicture'],
                    fit: BoxFit.fill, // adjust the image to fit the widget
                    width: 300,
                    // height: 300,
                  ),
                const SizedBox(height: 20),
                Text(
                  projectData['name'] ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
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
                // if (projectData['members'] != null &&
                //     !projectData['members']
                //         .contains(BlocProvider.of<UserCubit>(context).state.id))
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      if (projectData['members'] != null &&
                          !projectData['members'].contains(
                              BlocProvider.of<UserCubit>(context).state.id)) {
                        addMember();
                      } else {
                        removeMember();
                      }
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
                    child: (projectData['members'] != null &&
                            !projectData['members'].contains(
                                BlocProvider.of<UserCubit>(context).state.id))
                        ? const Text(
                            'Join Project',
                            style: TextStyle(fontSize: 13),
                          )
                        : const Text(
                            'Leave Project',
                            style: TextStyle(fontSize: 13),
                          ),
                  ),
                ),
                const Divider(
                  indent: 0,
                  endIndent: 0,
                ),
                if (sponsor > 0)
                  GestureDetector(
                    onTap: () {
                      print("sproject sponsors");
                      context.pushNamed("projectsponsors", queryParameters: {
                        'projectId': projectData['id'],
                      });
                    },
                    child: Text(
                      'Money pledged to this project: \$${sponsor.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                if (projectData.containsKey('city') &&
                    projectData.containsKey('state') &&
                    projectData.containsKey('zipCode'))
                  Text(
                      '${projectData['city']}, ${projectData['state']}  ${projectData['zipCode']}'),
                const SizedBox(height: 10),
                if (projectData.containsKey('bio'))
                  Text('${projectData['bio']}'),
                const SizedBox(height: 10),
                if (projectData.containsKey('description'))
                  Text('${projectData['description']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addMember() async {
    UProject? uproject =
        await ProjectHandlers.getUProjectById(projectData['id']);
    var uprojectMems = uproject!.members;
    var memID = BlocProvider.of<UserCubit>(context).state.id;
    if (uprojectMems != null) {
      uprojectMems.add(memID);
    }
    uprojectMems = uprojectMems!.toSet().toList();

    final addedMemUProj = uproject.copyWith(members: uprojectMems);

    try {
      final request = ModelMutations.update(addedMemUProj);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
      if (response.data!.members!.isNotEmpty) {
        PointsHandlers.newPoints(
            BlocProvider.of<UserCubit>(context).state.id, "JOINPROJECT", 3);
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

  Future<void> removeMember() async {
    await ProjectHandlers.removeMember(
        projectData['id'], BlocProvider.of<UserCubit>(context).state.id);
    getProject().then((data) {
      setState(() {
        projectData = data;
      });
    });
  }
}
