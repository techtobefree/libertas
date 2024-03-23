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

class MyEvents extends StatefulWidget {
  final String? userId;

  const MyEvents({Key? key, required this.userId}) : super(key: key);

  @override
  _ProjectEventsState createState() => _ProjectEventsState();
}

class _ProjectEventsState extends State<MyEvents> {
  bool _isLoading = false;
  List<UEvent?> myevents = [];
  List<bool> areMyEventsActive = [];
  List<UEvent?> activeevents = [];
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
    List<UEvent?> uevents =
        await EventHandlers.getUUserRSVPEvents(widget.userId);

    List<UEvent?> checkedInActiveEvents =
        await EventCheckInHandlers.getCheckedInFromEvents(
            widget.userId!, uevents);

    setState(() {
      myevents.addAll(sortByDate(uevents));

      for (var event in myevents) {
        if (checkedInActiveEvents.contains(event)) {
          checkedInEventIds.add(event!.id);
        }
      }
      activeevents = sortByDate(activeevents);
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
        title: const Text('My Events'),
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
                : myevents.isNotEmpty
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: myevents.length,
                        itemBuilder: (context, index) {
                          // if (DateTime.now().isBefore(
                          //         _parseDate(events[index]!.date ?? '')) ||
                          //     DateTime.now()
                          //             .difference(
                          //                 _parseDate(events[index]!.date ?? ''))
                          //             .inHours <
                          //         24) {
                          return EventCard(
                            dateString: myevents[index]!.date ?? '',
                            timeString: myevents[index]!.time ?? '',
                            name: myevents[index]!.name,
                            eventId: myevents[index]!.id,
                            memberStatus: EventHandlers.getMemberStatusNotAsync(
                                myevents[index]!,
                                BlocProvider.of<UserCubit>(context).state.id),
                            projId: myevents[index]!.project.id,
                            checkInButon:
                                (EventHandlers.isEventActiveFromUEvent(
                                        myevents[index]!) &&
                                    !checkedInEventIds
                                        .contains(myevents[index]!.id)),
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
