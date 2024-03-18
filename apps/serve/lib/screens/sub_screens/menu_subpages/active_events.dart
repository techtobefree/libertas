import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/eventcheckin/handlers/eventcheckin_handlers.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/widgets/event_project_card.dart';

import '../../../models/ModelProvider.dart';

class ActiveEvents extends StatefulWidget {
  final String? userId;

  const ActiveEvents({Key? key, required this.userId}) : super(key: key);

  @override
  _ProjectEventsState createState() => _ProjectEventsState();
}

class _ProjectEventsState extends State<ActiveEvents> {
  bool _isLoading = false;
  List<UEvent?> events = [];
  List<String> checkedInEventIds = [];

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
    List<UEvent?> ueventsactive =
        await EventHandlers.getUUserActiveEvents(widget.userId);
    List<UEvent?> checkedInActiveEvents =
        await EventCheckInHandlers.getCheckedInActiveEvents(widget.userId!);

    setState(() {
      events.addAll(ueventsactive);
      for (var event in ueventsactive) {
        if (checkedInActiveEvents.contains(event)) {
          checkedInEventIds.add(event!.id);
        }
      }
      events = sortByDate(events);
      _isLoading = false;
    });
  }

  static List<UEvent?> sortByDate(List<UEvent?> events) {
    // Remove null values from the list before sorting
    events.removeWhere((event) => event == null);

    // Sort the events by date
    events.sort((a, b) {
      DateTime dateA = _parseDate(a!.date!);
      DateTime dateB = _parseDate(b!.date!);
      return dateA.compareTo(dateB);
    });

    return events;
  }

  static DateTime _parseDate(String dateString) {
    // Split the date string by '-' and convert to integers
    List<int> dateParts = dateString.split('-').map(int.parse).toList();
    return DateTime(dateParts[0], dateParts[1], dateParts[2]);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Active Events'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Define the behavior when the back button is pressed
            // For example, navigate back to the previous screen
            context.push("/menu");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _isLoading
                ? const CircularProgressIndicator() // Display loading indicator while data is being fetched
                : events.isNotEmpty
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          // if (DateTime.now().isBefore(
                          //         _parseDate(events[index]!.date ?? '')) ||
                          //     DateTime.now()
                          //             .difference(
                          //                 _parseDate(events[index]!.date ?? ''))
                          //             .inHours <
                          //         24) {
                          return EventCard(
                            dateString: events[index]!.date ?? '',
                            timeString: events[index]!.time ?? '',
                            name: events[index]!.name,
                            eventId: events[index]!.id,
                            memberStatus: EventHandlers.getMemberStatusNotAsync(
                                events[index]!,
                                BlocProvider.of<UserCubit>(context).state.id),
                            projId: events[index]!.project.id,
                            checkInButon:
                                !checkedInEventIds.contains(events[index]!.id),
                          );
                          // }
                        }) // Display message if no events are found
                    : Text('No events found.'),
            // ElevatedButton(
            //   onPressed: () {
            //     context.pushNamed("eventdetailsform", queryParameters: {
            //       'projectId': widget.projectId,
            //     }, pathParameters: {
            //       'projectId': widget.projectId
            //     });
            //   },
            //   child: Text('Create New Event'),
            // ),
          ],
        ),
      ),
    );
  }
}
