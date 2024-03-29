import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/repository/repository.dart';

class FinishProjectCard extends StatelessWidget {
  final String title;
  final String numMembers;
  final Map<String, dynamic> project;
  final void Function() onFinish;
  final void Function() resetState;

  // final String thumbnailUrl;

  const FinishProjectCard({
    super.key,
    required this.title,
    required this.numMembers,
    required this.project,
    required this.onFinish,
    required this.resetState,
    // required this.thumbnailUrl,
  });

  // Named constructor that accepts a JSON object
  FinishProjectCard.fromJson(
    Map<String, dynamic> json,
    void Function() onFinishFun,
    void Function() resState, {
    super.key,
  })  : title = json['name'],
        numMembers = json['members'].length.toString(),
        project = json,
        onFinish = onFinishFun,
        resetState = resState;
  // Named constructor that accepts a JSON object
  FinishProjectCard.fromUProject(
    UProject uProject, {
    required void Function() onFinishFun,
    required void Function() resState,
    super.key,
  })  : title = uProject.name,
        numMembers = (uProject.members?.length ?? 0).toString(),
        project = uProject.toJson(),
        onFinish = onFinishFun,
        resetState = resState;

  Future<void> putHoursSpent(int hours) async {
    final url = Uri.parse(
        'http://44.203.120.103:3000/projects/${project['id']}/hours-spent');
    final body = json.encode({'hoursSpent': hours});
    final headers = {'Content-Type': 'application/json'};
    final response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      // Request was successful, handle response here
      print('Hours spent updated');
    } else {
      // Request failed, handle error here
      print('Error updating hours spent: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Center(
      child: SizedBox(
        width: double.infinity,
        // height: 160.0,
        child: GestureDetector(
          onTap: () {
            print(project['projectPicture']);
            // Do something when the container is clicked
            context.pushNamed("projectdetails",
                queryParameters: {'id': project['id']},
                pathParameters: {'id': project['id']});
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
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (project.containsKey('city'))
                            Text('${project['city']}, ${project['state']}'),
                          if (project.containsKey('date'))
                            Text('${project['date']}'),
                          const SizedBox(height: 8.0),
                          Text('$numMembers Members'),
                          ElevatedButton(
                            onPressed: () async {
                              // Code to handle the "Finish" button click
                              onFinish();

                              final _ = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Approximate Number of Hours'),
                                    content: TextField(
                                      controller: textController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter the number of hours',
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('Save'),
                                        onPressed: () {
                                          // final hours = int.tryParse(
                                          //   (Navigator.of(context).pop()
                                          //           as String?) ??
                                          //       '',
                                          // );
                                          // print(hours);

                                          print(textController.text);
                                          int hours =
                                              int.parse(textController.text);
                                          ProjectHandlers.addHours(
                                              project['id'], hours);
                                          resetState();
                                          Navigator.of(context).pop();
                                          resetState();
                                          context.go("/menu/finishprojects");
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              // context.go('/menu/finishprojects');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 16, 34, 65),
                              ),
                            ),
                            child: const Text('Finish'),
                          ),
                        ],
                      ),
                    ),
                    if (project.containsKey('projectPicture') &&
                        project['projectPicture'].isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: repo.image(
                          project['projectPicture'],
                          fit: BoxFit
                              .cover, // adjust the image to fit the widget
                          height: 130, // set the height of the widget
                          width: 150,
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
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
