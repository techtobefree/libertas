import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/repository/repository.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventId;

  const EventDetailsPage({Key? key, required this.eventId, String? id})
      : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  Map<String, dynamic> eventData = {};
  String currentUserID = "";
  bool isGoing = false;
  bool isNotGoing = false;
  bool isEventActive = false;
  bool isCheckedIn = false;

  @override
  void initState() {
    super.initState();
    _fetchEventData();
  }

  Future<void> _fetchEventData() async {
    final queryPredicate = UEvent.ID.eq(widget.eventId);

    final request = ModelQueries.list<UEvent>(
      UEvent.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      String rsvpStatus = await EventHandlers.getMemberStatus(
          response.data!.items[0]!.id,
          BlocProvider.of<UserCubit>(context).state.id);
      if (rsvpStatus == "ATTENDING") {
        setState(() {
          isGoing = true;
        });
      }
      if (rsvpStatus == "NOTATTENDING") {
        setState(() {
          isNotGoing = true;
        });
      }
      bool activeStatus = false;
      bool isCheckedInEvent = false;
      if (isGoing) {
        activeStatus =
            await EventHandlers.isEventActive(response.data!.items[0]!.id);
        if (activeStatus) {
          isCheckedInEvent = await EventHandlers.isCheckedInEvent(
              BlocProvider.of<UserCubit>(context).state.id,
              response.data!.items[0]!.id);
        }
      }
      var jsonResponse = response.data!.items[0]!.toJson();

      setState(() {
        isEventActive = activeStatus;
        isCheckedIn = isCheckedInEvent;
        eventData = jsonResponse;
      });
    } else {
      throw Exception('Failed to load events');
    }
  }

  @override
  Widget build(BuildContext context) {
    currentUserID = BlocProvider.of<UserCubit>(context).state.id;

    bool shouldDisplayEditButton = false;

    if (eventData['members'] != null &&
        eventData['members'].contains(currentUserID)) {
      shouldDisplayEditButton = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Event',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 28, 72, 1.0),
                Color.fromRGBO(35, 107, 140, 1.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (shouldDisplayEditButton)
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 16, 34, 65),
                      ),
                    ),
                    onPressed: () {
                      // Handle the edit button press here
                      // Navigate to the edit event page
                    },
                    child: Text(
                      'Edit Event',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                // if (eventData.containsKey('eventPicture') &&
                //     eventData['eventPicture'].isNotEmpty)
                //   Image.network(
                //     eventData['eventPicture'],
                //     fit: BoxFit.fill, // adjust the image to fit the widget
                //     width: 300,
                //     // height: 300,
                //   ),
                SizedBox(height: 20),
                Text(
                  eventData['name'] ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add spacing between the "Members" text and the hyperlink
                      GestureDetector(
                        onTap: () {
                          print("view members");
                          context.pushNamed("showmembersattending",
                              queryParameters: {
                                'eventId': widget.eventId,
                              });
                          // Navigate to view members page
                        },
                        child: Text(
                          'View Members Attending',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                if (eventData['members'] != null &&
                    !eventData['members'].contains(currentUserID))
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement join event functionality
                        _joinEvent();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 16, 34, 65),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: Text(
                        'Join Event',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                Divider(
                  indent: 0,
                  endIndent: 0,
                ),
                if (eventData.containsKey('date'))
                  Text('${eventData['date']}, ${eventData['time']}'),
                SizedBox(height: 10),
                if (eventData.containsKey('bio')) Text('${eventData['bio']}'),
                SizedBox(height: 10),
                if (eventData.containsKey('description'))
                  Text('${eventData['description']}'),
                if (eventData.containsKey('city'))
                  Text('${eventData['city']}, ${eventData['state']}'),
                SizedBox(height: 10),
                if (eventData
                    .containsKey('details')) // Displaying details field
                  Text('${eventData['details']}'), // Displaying details field
                SizedBox(height: 10),
                if (eventData.containsKey('bio')) Text('${eventData['bio']}'),
                SizedBox(height: 10),
                if (eventData.containsKey('description'))
                  Text('${eventData['description']}'),
                (!isGoing && !isNotGoing)
                    ? Column(children: [
                        ElevatedButton(
                            onPressed: () async {
                              await EventHandlers.addAttendee(eventData['id'],
                                  BlocProvider.of<UserCubit>(context).state.id);
                              context
                                  .pushNamed("eventdetails", queryParameters: {
                                'id': eventData['id'],
                              }, pathParameters: {
                                'id': eventData['id'],
                              });
                            },
                            child: const Text('Going')),
                        ElevatedButton(
                            onPressed: () async {
                              await EventHandlers.addNonAttendee(
                                  eventData['id'],
                                  BlocProvider.of<UserCubit>(context).state.id);
                              context
                                  .pushNamed("eventdetails", queryParameters: {
                                'id': eventData['id'],
                              }, pathParameters: {
                                'id': eventData['id'],
                              });
                            },
                            child: const Text('Not Going'))
                      ])
                    : const SizedBox(),
                (isGoing && isEventActive && !isCheckedIn)
                    ? ElevatedButton(
                        onPressed: () {
                          EventHandlers.checkInUEventFromIds(eventData['id'],
                              BlocProvider.of<UserCubit>(context).state.id);
                          context.pushNamed("eventdetails", queryParameters: {
                            'id': eventData['id'],
                          }, pathParameters: {
                            'id': eventData['id'],
                          });
                        },
                        child: const Text('Check In'))
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _joinEvent() async {
    UEvent? uevent = await EventHandlers.getUEventById(eventData['id']);
    var ueventMems = uevent!.membersAttending;
    var memID = BlocProvider.of<UserCubit>(context).state.id;
    if (ueventMems != null) {
      ueventMems.add(memID);
    }

    final addedMemUProj = uevent.copyWith(membersAttending: ueventMems);

    try {
      final request = ModelMutations.update(addedMemUProj);
      final response = await Amplify.API.mutate(request: request).response;
      print('Response: $response');
      if (response.data!.membersAttending!.isNotEmpty) {
        setState(() {
          eventData['members'] = eventData['members'] != null
              ? [...eventData['members'], memID]
              : [memID];
        });
      }
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }
}
