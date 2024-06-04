import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/repository/repository.dart';

class GroupProjectCard extends StatelessWidget {
  final String title;
  final String numMembers;
  final Map<String, dynamic> project;
  final List<dynamic> sponsors;
  final bool lead;

  const GroupProjectCard({
    super.key,
    required this.title,
    required this.numMembers,
    required this.project,
    required this.sponsors,
    this.lead = false,
  });

  // Named constructor that accepts a JSON object
  factory GroupProjectCard.fromJson(
    Map<String, dynamic> json, {
    Key? key,
    bool lead = false,
  }) =>
      GroupProjectCard(
          key: key,
          title: json['name'],
          numMembers: json['members'].length.toString(),
          sponsors: json['sponsors'] ?? [],
          project: json,
          lead: lead);

  factory GroupProjectCard.fromUProject(
    UProject uProject, {
    Key? key,
    bool lead = false,
  }) =>
      GroupProjectCard(
          key: key,
          title: uProject.name,
          numMembers: (uProject.members?.length ?? 0).toString(),
          sponsors: uProject.sponsors ?? [],
          project: uProject.toJson(),
          lead: lead);

  // Named constructor that accepts a JSON object
  //ProjectCard.fromJson(
  //  Map<String, dynamic> json, {
  //  super.key,
  //  bool lead = false,
  //})  : title = json['name'],
  //      numMembers = json['members'].length.toString(),
  //      sponsors = json['sponsors'] ?? [],
  //      project = json,
  //      this.lead = lead; // Initialize 'lead' with the provided value

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
              context.pushNamed("projectdetails",
                  queryParameters: {'id': project['id']},
                  pathParameters: {'id': project['id']});
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
}
