import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/points/points_handlers.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/repository/repository.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String numMembers;
  final Map<String, dynamic> project;
  final List<dynamic> sponsors;
  final bool lead;

  const ProjectCard({
    super.key,
    required this.title,
    required this.numMembers,
    required this.project,
    required this.sponsors,
    this.lead = false,
  });

  // Named constructor that accepts a JSON object
  factory ProjectCard.fromJson(
    Map<String, dynamic> json, {
    Key? key,
    bool lead = false,
  }) =>
      ProjectCard(
          key: key,
          title: json['name'],
          numMembers: json['members'].length.toString(),
          sponsors: json['sponsors'] ?? [],
          project: json,
          lead: lead);

  factory ProjectCard.fromUProject(
    UProject uProject, {
    Key? key,
    bool lead = false,
  }) =>
      ProjectCard(
          key: key,
          title: uProject.name,
          numMembers: (uProject.members?.length ?? 0).toString(),
          sponsors: uProject.sponsors ?? [],
          project: uProject.toJson(),
          lead: lead);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        // height: 140.0,
        child: GestureDetector(
          onTap: () {
            // Do something when the container is clicked
            if (lead == false) {
              if (project['members']
                  .contains(BlocProvider.of<UserCubit>(context).state.id)) {
                context.pushNamed("projectdetails",
                    queryParameters: {'id': project['id']},
                    pathParameters: {'id': project['id']});
              } else {
                context.pushNamed("projectabout",
                    queryParameters: {'id': project['id']},
                    pathParameters: {'id': project['id']});
              }
            }
            if (lead == true) {
              context.pushNamed("leadprojectdetails",
                  queryParameters: {'id': project['id']},
                  pathParameters: {'id': project['id']});
            }
          },
          child: Card(
            color: Colors.white,
            shadowColor: Colors.grey.withOpacity(0.4),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200, // set the desired width for the text
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        if (project.containsKey('city'))
                          Text('${project['city']}, ${project['state']}'),
                        if (project.containsKey('date'))
                          Text('${project['date']}'),
                        const SizedBox(height: 8.0),
                        Text('$numMembers Members'),
                        const SizedBox(height: 12.0),
                        Text(
                          (project['isCompleted'] == true ? 'Completed' : ''),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        if (!lead &&
                            !project['members'].contains(
                                BlocProvider.of<UserCubit>(context).state.id))
                          ElevatedButton(
                              onPressed: () async {
                                var success = await addMember(
                                    BlocProvider.of<UserCubit>(context)
                                        .state
                                        .id);

                                if (success) {
                                  var needLeader = (project['leader'] == null ||
                                      project['leader'].isEmpty);
                                  if (needLeader == false) {
                                    context.pushNamed("projectdetails",
                                        queryParameters: {'id': project['id']},
                                        pathParameters: {'id': project['id']});
                                  }
                                  if (needLeader == true) {
                                    context.pushNamed("leadprojectdetails",
                                        queryParameters: {'id': project['id']},
                                        pathParameters: {'id': project['id']});
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                    255, 16, 34, 65), // Background color
                                foregroundColor: Colors.white, // Text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Rounded corners
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                              child: const Text(
                                'Join Project',
                                style: TextStyle(fontSize: 13),
                              )),
                      ],
                    ),
                  ),
                  if (project.containsKey('projectPicture') &&
                      project['projectPicture'].isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: repo.image(
                        project['projectPicture'],
                        fit: BoxFit.cover,
                        height: 130,
                        width: 160,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox(
                              height: 130,
                              width: 160,
                              child: Padding(
                                padding: EdgeInsets.all(30),
                                child: CircularProgressIndicator(),
                              ));
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            child: const Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> addMember(userId) async {
    UProject? uproject = await ProjectHandlers.getUProjectById(project['id']);
    var uprojectMems = uproject!.members;
    if (uprojectMems != null) {
      uprojectMems.add(userId);
    }

    final addedMemUProj = uproject.copyWith(members: uprojectMems);

    try {
      final request = ModelMutations.update(addedMemUProj);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
      PointsHandlers.newPoints(userId, "JOINPROJECT", 3);
      return true;
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }
}
