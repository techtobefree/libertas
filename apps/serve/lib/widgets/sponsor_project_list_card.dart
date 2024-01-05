import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/repository/repository.dart';

class SponsorProjectListCard extends StatefulWidget {
  final String title;
  final String numMembers;
  final Map<String, dynamic> project;
  final List<dynamic> sponsors;

  const SponsorProjectListCard({
    super.key,
    required this.title,
    required this.numMembers,
    required this.project,
    required this.sponsors,
  });

  // Named constructor that accepts a JSON object
  SponsorProjectListCard.fromJson(Map<String, dynamic> json, {super.key})
      : title = json['name'],
        numMembers = json['members'].length.toString(),
        sponsors = json['sponsors'],
        project = json;

  factory SponsorProjectListCard.fromUProject(
    UProject uProject, {
    Key? key,
  }) =>
      SponsorProjectListCard(
          key: key,
          title: uProject.name,
          numMembers: (uProject.members?.length ?? 0).toString(),
          sponsors: uProject.sponsors ?? [],
          project: uProject.toJson());

  @override
  SponsorProjectListCardState createState() => SponsorProjectListCardState();
}

class SponsorProjectListCardState extends State<SponsorProjectListCard> {
  bool _isImageError = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 140.0,
        child: GestureDetector(
          onTap: () {
            print(widget.project);
            // Do something when the container is clicked
            context.pushNamed(
              "sponsorprojectform",
              queryParameters: {'id': widget.project['id']},
              pathParameters: {'id': widget.project['id']},
            );
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
                    // Wrap the title widget with Expanded
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Truncate the title if it overflows
                          maxLines: 2, // Limit the title to 2 lines
                        ),
                        if (widget.project.containsKey('city'))
                          Text(
                            '${widget.project['city']}, ${widget.project['state']}',
                          ),
                        if (widget.project.containsKey('date'))
                          Text('${widget.project['date']}'),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Sponsor!',
                          style: TextStyle(
                            fontSize: 20.0, // Adjust the font size as desired
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (_isImageError)
                    const SizedBox(
                      width: 120,
                      height: 120,
                      child: Placeholder(), // Display a placeholder image
                    ),
                  if (!_isImageError)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: repo.image(
                        widget.project['projectPicture'],
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) {
                          setState(() {
                            _isImageError = true; // Set the error flag
                          });
                          return const SizedBox(
                            width: 120,
                            height: 120,
                            child: Placeholder(), // Display a placeholder image
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
