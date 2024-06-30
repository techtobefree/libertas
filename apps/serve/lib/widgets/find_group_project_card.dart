import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/data/groups/group_handlers.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/repository/repository.dart';

class FindGroupProjectCard extends StatefulWidget {
  final String title;
  final String numMembers;
  final Map<String, dynamic> project;
  final List<dynamic> sponsors;
  final bool lead;
  final String groupId;

  const FindGroupProjectCard({
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

class _GroupProjectCardState extends State<FindGroupProjectCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            if (!widget.lead) {
              context.pushNamed("projectdetails",
                  queryParameters: {'id': widget.project['id']},
                  pathParameters: {'id': widget.project['id']});
            } else {
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
                        const SizedBox(height: 12.0),
                        _isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await addProjectToGroup(
                                      widget.groupId, widget.project['id']);
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    context.pushNamed("findgroupproject",
                                        queryParameters: {
                                          'id': widget.groupId,
                                        },
                                        pathParameters: {
                                          'id': widget.groupId,
                                        });
                                  }
                                },
                                child: Text("Add Project to Group")),
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

  Future<void> addProjectToGroup(String groupId, String projId) async {
    await GroupHandlers.addProject(groupId, projId);
  }
}
