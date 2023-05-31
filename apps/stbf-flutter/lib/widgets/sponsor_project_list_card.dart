import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SponsorProjectListCard extends StatefulWidget {
  final String title;
  final String numMembers;
  final Map<String, dynamic> project;
  final List<dynamic> sponsors;

  SponsorProjectListCard({
    required this.title,
    required this.numMembers,
    required this.project,
    required this.sponsors,
  });

  // Named constructor that accepts a JSON object
  SponsorProjectListCard.fromJson(Map<String, dynamic> json)
      : title = json['name'],
        numMembers = json['members'].length.toString(),
        sponsors = json['sponsors'],
        project = json;

  @override
  _SponsorProjectListCardState createState() => _SponsorProjectListCardState();
}

class _SponsorProjectListCardState extends State<SponsorProjectListCard> {
  bool _isImageError = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 140.0,
        child: GestureDetector(
          onTap: () {
            print(widget.project);
            // Do something when the container is clicked
            context.pushNamed(
              "sponsorprojectform",
              params: {'id': widget.project['_id']},
            );
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
                    // Wrap the title widget with Expanded
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
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
                        SizedBox(height: 8.0),
                        Text(
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
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Placeholder(), // Display a placeholder image
                    ),
                  if (!_isImageError)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        widget.project['projectPicture'],
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) {
                          setState(() {
                            _isImageError = true; // Set the error flag
                          });
                          return SizedBox(
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
