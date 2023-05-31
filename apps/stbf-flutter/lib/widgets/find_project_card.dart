import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String numMembers;
  final Map<String, dynamic> project;
  final List<dynamic> sponsors;

  ProjectCard({
    required this.title,
    required this.numMembers,
    required this.project,
    required this.sponsors,
  });

  // Named constructor that accepts a JSON object
  ProjectCard.fromJson(Map<String, dynamic> json)
      : title = json['name'],
        numMembers = json['members'].length.toString(),
        sponsors = json['sponsors'],
        project = json;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        // height: 140.0,
        child: GestureDetector(
          onTap: () {
            print(project['projectPicture']);
            // Do something when the container is clicked
            context.pushNamed("projectdetails", params: {'id': project['_id']});
          },
          child: Card(
            color: Colors.white,
            shadowColor: Colors.grey.withOpacity(0.4),
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200, // set the desired width for the text
                          child: Text(
                            title,
                            style: TextStyle(
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
                        SizedBox(height: 8.0),
                        Text('$numMembers Members'),
                        SizedBox(height: 12.0),
                        Text(
                            (project['isCompleted'] == true ? 'Completed' : ''),
                            style: TextStyle(
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
                      child: Image.network(
                        project['projectPicture'],
                        fit: BoxFit.cover,
                        height: 130,
                        width: 160,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
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
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      // FadeInImage.assetNetwork(
                      //                 placeholder: 'assets/images/curious_lemur.jpeg',
                      //                 image: project['projectPicture'],
                      //                 fit: BoxFit.cover, // adjust the image to fit the widget
                      // height: 130,
                      // width: 160,

                      //               ),
                      // Image.network(
                      //   project['projectPicture'],
                      //   fit: BoxFit
                      //       .cover, // adjust the image to fit the widget
                      //   height: 130, // set the height of the widget
                      // ),
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
