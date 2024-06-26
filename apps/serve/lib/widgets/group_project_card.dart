import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/groups/group_handlers.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/repository/repository.dart';

class GroupProjectCard extends StatefulWidget {
  final String title;
  final String numMembers;
  final Map<String, dynamic> project;
  final List<dynamic> sponsors;
  final bool lead;
  final String groupId;

  const GroupProjectCard({
    super.key,
    required this.title,
    required this.numMembers,
    required this.project,
    required this.sponsors,
    required this.groupId,
    this.lead = false,
  });

  @override
  _GroupProjectCardState createState() => _GroupProjectCardState();
}

class _GroupProjectCardState extends State<GroupProjectCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            if (widget.lead == false) {
              context.pushNamed("projectdetails",
                  queryParameters: {'id': widget.project['id']},
                  pathParameters: {'id': widget.project['id']});
            }
            if (widget.lead == true) {
              context.pushNamed("leadprojectdetails",
                  queryParameters: {'id': widget.project['id']},
                  pathParameters: {'id': widget.project['id']});
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
                          width: 200,
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        if (widget.project.containsKey('city'))
                          Text(
                              '${widget.project['city']}, ${widget.project['state']}'),
                        if (widget.project.containsKey('date'))
                          Text('${widget.project['date']}'),
                        const SizedBox(height: 8.0),
                        Text('${widget.numMembers} Members'),
                        const SizedBox(height: 12.0),
                        Text(
                          (widget.project['isCompleted'] == true
                              ? 'Completed'
                              : ''),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        if (!widget.lead &&
                            !widget.project['members'].contains(
                                BlocProvider.of<UserCubit>(context).state.id))
                          ElevatedButton(
                              onPressed: () async {
                                var success = await addMember(
                                    BlocProvider.of<UserCubit>(context)
                                        .state
                                        .id);

                                if (success) {
                                  var needLeader =
                                      (widget.project['leader'] == null ||
                                          widget.project['leader'].isEmpty);
                                  if (needLeader == false) {
                                    context.pushNamed("projectdetails",
                                        queryParameters: {
                                          'id': widget.project['id']
                                        },
                                        pathParameters: {
                                          'id': widget.project['id']
                                        });
                                  }
                                  if (needLeader == true) {
                                    context.pushNamed("leadprojectdetails",
                                        queryParameters: {
                                          'id': widget.project['id']
                                        },
                                        pathParameters: {
                                          'id': widget.project['id']
                                        });
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
                        _isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await GroupHandlers.removeProject(
                                      widget.groupId, widget.project['id']);
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    context.pushNamed("groupproject",
                                        queryParameters: {
                                          'id': widget.groupId,
                                        },
                                        pathParameters: {
                                          'id': widget.groupId,
                                        });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                      255, 223, 177, 171), // Background color
                                  foregroundColor: const Color.fromARGB(
                                      255, 128, 20, 20), // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Rounded corners
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                                child: const Text(
                                  'Remove from group',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                      ],
                    ),
                  ),
                  if (widget.project.containsKey('projectPicture') &&
                      widget.project['projectPicture'].isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: repo.image(
                        widget.project['projectPicture'],
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
    UProject? uproject =
        await ProjectHandlers.getUProjectById(widget.project['id']);
    var uprojectMems = uproject!.members;
    if (uprojectMems != null) {
      uprojectMems.add(userId);
    }

    final addedMemUProj = uproject.copyWith(members: uprojectMems);

    try {
      final request = ModelMutations.update(addedMemUProj);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
      return true;
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }
}
