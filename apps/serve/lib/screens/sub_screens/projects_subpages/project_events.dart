import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/widgets/event_project_card.dart';

import '../../../models/ModelProvider.dart';

class ProjectEvents extends StatefulWidget {
  final String projectId;

  const ProjectEvents({Key? key, required this.projectId}) : super(key: key);

  @override
  _ProjectEventsState createState() => _ProjectEventsState();
}

class _ProjectEventsState extends State<ProjectEvents> {
  UProject _project = UProject(
      name: '',
      privacy: '',
      description: '',
      projectPicture: '',
      isCompleted: false);
  bool _isLoading = false;
  List<UEvent?> events = [];

  @override
  void initState() {
    super.initState();
    _fetchProjectData();
  }

  Future<void> _fetchProjectData() async {
    // Simulating asynchronous data fetching
    setState(() {
      _isLoading = true;
    });
    // Assume fetchData() is an asynchronous method in UProject class
    UProject? project = await ProjectHandlers.getUProjectById(widget.projectId);
    List<UEvent?> uevents =
        await EventHandlers.getUEventsByProject(widget.projectId);

    setState(() {
      events.addAll(uevents);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        title: const Text('Project Events'),
      ),
      body: Column(
        children: [
          _isLoading
              ? const CircularProgressIndicator() // Display loading indicator while data is being fetched
              : events.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        // return Text(
                        //     ' ${events[index]!.date ?? ''} ${events[index]!.time ?? ''},');
                        return EventCard(
                          dateString: events[index]!.date ?? '',
                          timeString: events[index]!.time ?? '',
                          name: events[index]!.name,
                        );
                      },
                    ) // Display message if no events are found
                  : Text('No events found.'),
          ElevatedButton(
            onPressed: () {
              context.pushNamed("eventdetailsform", queryParameters: {
                'projectId': widget.projectId,
              }, pathParameters: {
                'projectId': widget.projectId
              });
            },
            child: Text('Create New Event'),
          ),
        ],
      ),
    );
  }
}
