import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/utilities/helper.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventId;

  const EventDetailsPage({Key? key, required this.eventId, String? id})
      : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  Map<String, dynamic> eventData = {};
  bool _isLoading = false;
  String currentUserID = "";
  bool isAuthorized = false;
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
      var ownerId = response.data!.items[0]!.uEventOwnerId;

      setState(() {
        if (ownerId == BlocProvider.of<UserCubit>(context).state.id) {
          isAuthorized = true;
        }
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
                  Text(
                      '${formatDate(eventData['date'])}, ${_formatTime(eventData['time'])}'),
                SizedBox(height: 10),
                if (eventData.containsKey('bio')) Text('${eventData['bio']}'),
                SizedBox(height: 10),
                if (eventData.containsKey('description'))
                  Text('${eventData['description']}'),
                if (eventData.containsKey('streetAddress'))
                  Text('${eventData['streetAddress']}'),
                if (eventData.containsKey('city'))
                  Text(
                      '${eventData['city']}, ${eventData['state']} ${eventData['zipCode']}'),
                SizedBox(height: 10),
                if (eventData.containsKey('eventPicture') &&
                    eventData['eventPicture'] != "")
                  Image.network(eventData['eventPicture']),
                const SizedBox(height: 10),

                if (eventData
                    .containsKey('details')) // Displaying details field
                  Text('${eventData['details']}'), // Displaying details field
                SizedBox(height: 10),
                if (eventData.containsKey('bio')) Text('${eventData['bio']}'),
                SizedBox(height: 10),
                if (eventData.containsKey('description'))
                  Text('${eventData['description']}'),
                if (eventData.containsKey('checkInCode') && isAuthorized)
                  Column(
                    children: [
                      Text('Event Check in Code: ${eventData['checkInCode']}'),
                      ElevatedButton(
                          onPressed: () async {
                            context.pushNamed("qrdisplay", queryParameters: {
                              'code': eventData['checkInCode'],
                            }, pathParameters: {
                              'code': eventData['checkInCode'],
                            });
                          },
                          child: const Text('Generate QR code')),
                    ],
                  ),
                if (isAuthorized)
                  ElevatedButton(
                      onPressed: () async {
                        context.pushNamed("eventdetailsform", queryParameters: {
                          'projectId': eventData['project']['id'],
                          'eventId': eventData['id'],
                        }, pathParameters: {
                          'projectId': eventData['project']['id'],
                        });
                        print(eventData['project']['id']);
                      },
                      child: const Text('Edit Event')),
                if (isAuthorized && isEventActive)
                  ElevatedButton(
                      onPressed: () async {
                        context.pushNamed("showmembersattending",
                            queryParameters: {
                              'eventId': widget.eventId,
                            });
                      },
                      child: const Text('Check In Members')),
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
                    ? Column(children: [
                        ElevatedButton(
                            onPressed: () {
                              _showCodeInputDialog(
                                  context, eventData['checkInCode'] ?? "0000");
                            },
                            child: const Text('Check In')),
                        ElevatedButton(
                            onPressed: () {
                              context.pushNamed("qrscan", queryParameters: {
                                'code': eventData['checkInCode'],
                                'eventId': eventData['id'],
                              }, pathParameters: {
                                'code': eventData['checkInCode'],
                              });
                            },
                            child: const Text('Scan QR Code'))
                      ])
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(String time) {
    // Splitting the time string into hours and minutes
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    // Formatting the time with AM/PM and leading zeros
    String formattedTime =
        DateFormat('hh:mm a').format(DateTime(0, 0, 0, hours, minutes));

    return formattedTime;
  }

  Future<void> _showCodeInputDialog(
      BuildContext context, String eventCode) async {
    String code = ''; // Initialize an empty string to hold the code
    if (isAuthorized) {
      await EventHandlers.checkInUEventFromIds(
          eventData['id'], BlocProvider.of<UserCubit>(context).state.id);
      context.pushNamed("checkedin", queryParameters: {
        'eventId': eventData['id'],
      });
      return;
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter 4-Digit Code'),
          content: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter 4-digit code',
            ),
            onChanged: (value) {
              code = value; // Update the code when the user enters text
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (code.length == 4) {
                  // Check if the entered code is 4 digits
                  print('Entered code: $code');
                  if (code == eventCode) {
                    await EventHandlers.checkInUEventFromIds(eventData['id'],
                        BlocProvider.of<UserCubit>(context).state.id);
                    context.pushNamed("checkedin", queryParameters: {
                      'eventId': eventData['id'],
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Code does not match'),
                      ),
                    );
                  }
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  // Show an error message if the code is not 4 digits
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a 4-digit code.'),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
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
