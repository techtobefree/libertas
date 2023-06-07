import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/users/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FinishProjectCard extends StatelessWidget {
  final String title;
  final String numMembers;
  final Map<String, dynamic> project;
  final void Function() onFinish;
  // final String thumbnailUrl;

  FinishProjectCard({
    required this.title,
    required this.numMembers,
    required this.project,
    required this.onFinish,
    // required this.thumbnailUrl,
  });

  // Named constructor that accepts a JSON object
  FinishProjectCard.fromJson(
      Map<String, dynamic> json, void Function() onFinishFun)
      : title = json['name'],
        numMembers = json['members'].length.toString(),
        project = json,
        onFinish = onFinishFun;

  Future<void> putHoursSpent(int hours) async {
    final url = Uri.parse(
        'http://44.203.120.103:3000/projects/${project['_id']}/hours-spent');
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
      child: Container(
        width: double.infinity,
        // height: 160.0,
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
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (project.containsKey('city'))
                            Text('${project['city']}, ${project['state']}'),
                          if (project.containsKey('date'))
                            Text('${project['date']}'),
                          SizedBox(height: 8.0),
                          Text('$numMembers Members'),
                          ElevatedButton(
                            onPressed: () async {
                              // Code to handle the "Finish" button click
                              onFinish();

                              final result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Approximate Number of Hours'),
                                    content: TextField(
                                      controller: textController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Enter the number of hours',
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text('Save'),
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
                                          putHoursSpent(hours);

                                          Navigator.of(context).pop();
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
                                Color.fromARGB(255, 16, 34, 65),
                              ),
                            ),
                            child: Text('Finish'),
                          ),
                        ],
                      ),
                    ),
                    if (project.containsKey('projectPicture') &&
                        project['projectPicture'].isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(project['projectPicture'],
                            fit: BoxFit
                                .cover, // adjust the image to fit the widget
                            height: 130, // set the height of the widget
                            width: 150),
                      ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
