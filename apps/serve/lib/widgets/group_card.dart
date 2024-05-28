import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/repository/repository.dart';

class GroupCard extends StatelessWidget {
  final String title;
  final Map<String, dynamic> group;

  const GroupCard({
    super.key,
    required this.title,
    required this.group,
  });

  // Named constructor that accepts a JSON object
  factory GroupCard.fromJson(
    Map<String, dynamic> json, {
    Key? key,
  }) =>
      GroupCard(
        key: key,
        title: json['name'],
        group: json,
      );

  factory GroupCard.fromUGroup(
    UGroup uGroup, {
    Key? key,
  }) =>
      GroupCard(
        key: key,
        title: uGroup.name,
        group: uGroup.toJson(),
      );

  // Named constructor that accepts a JSON object
  //ProjectCard.fromJson(
  //  Map<String, dynamic> json, {
  //  super.key,
  //  bool lead = false,
  //})  : title = json['name'],
  //      numMembers = json['members'].length.toString(),
  //      sponsors = json['sponsors'] ?? [],
  //      group = json,
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
            // if (lead == false) {
            //   context.pushNamed("groupdetails",
            //       queryParameters: {'id': group['id']},
            //       pathParameters: {'id': group['id']});
            // }
            // if (lead == true) {
            //   context.pushNamed("leadgroupdetails",
            //       queryParameters: {'id': group['id']},
            //       pathParameters: {'id': group['id']});
            // }
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
                        if (group.containsKey('city'))
                          Text('${group['city']}, ${group['state']}'),

                        // Text('$numMembers Members'),
                        // const SizedBox(height: 12.0),
                        // Text((group['isCompleted'] == true ? 'Completed' : ''),
                        //     style: const TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.redAccent,
                        //     )),
                      ],
                    ),
                  ),
                  if (group.containsKey('groupPicture') &&
                      group['groupPicture'].isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: repo.image(
                        group['groupPicture'],
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
                      // FadeInImage.assetNetwork(
                      //                 placeholder: 'assets/images/curious_lemur.jpeg',
                      //                 image: group['groupPicture'],
                      //                 fit: BoxFit.cover, // adjust the image to fit the widget
                      // height: 130,
                      // width: 160,

                      //               ),
                      // repo.image(
                      //   group['groupPicture'],
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
