import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';

class EventCard extends StatelessWidget {
  final String dateString;
  final String timeString;
  final String name;
  final String eventId;
  final String memberStatus;
  final String projId;
  final bool checkInButon;
  final String eventCode;
  final bool eventAuthorized;

  const EventCard(
      {super.key,
      required this.dateString,
      required this.timeString,
      required this.name,
      required this.eventId,
      required this.memberStatus,
      required this.projId,
      required this.eventCode,
      this.checkInButon = false,
      this.eventAuthorized = false});

  static DateTime _parseDate(String dateString) {
    List<int> dateParts = dateString.split('-').map(int.parse).toList();
    print(DateTime(dateParts[0], dateParts[1], dateParts[2]));
    print(DateTime.now());

    return DateTime(dateParts[0], dateParts[1], dateParts[2]);
  }

  static String _formatDate(String dateString) {
    DateTime dateTime = _parseDate(dateString);
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }

  static TimeOfDay _parseTime(String timeString) {
    // Split the time string by ':' and convert to integers
    List<int> timeParts = timeString.split(':').map(int.parse).toList();
    return TimeOfDay(hour: timeParts[0], minute: timeParts[1]);
  }

  static String _formatTime(String timeString) {
    TimeOfDay time = _parseTime(timeString);
    DateTime dateTime = DateTime(2024, 1, 1, time.hour, time.minute);
    return DateFormat.jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed("eventdetails", queryParameters: {
          'id': eventId,
        }, pathParameters: {
          'id': eventId,
        });
      },
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: (eventAuthorized &&
                  !DateTime.parse(dateString).isBefore(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day)))
              ? 200.0
              : 160,
          child: Card(
            elevation: 5,
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    softWrap: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(_formatDate(dateString)),
                      SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.access_time,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        _formatTime(timeString),
                      ),
                    ],
                  ),
                ),
                if (checkInButon)
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showCodeInputDialog(context, eventCode);
                        },
                        child: const Text('Check In'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.pushNamed("qrscan", queryParameters: {
                            'code': eventCode,
                            'eventId': eventId,
                          }, pathParameters: {
                            'code': eventCode,
                          });
                        },
                        child: const Text('Scan QR code'),
                      ),
                    ],
                  ),

                // if (_parseDate(dateString).isBefore(DateTime.now() ) &&
                //     !checkInButon)
                //   Center(
                //       child: Column(children: [
                //     SizedBox(
                //       height: 7,
                //     ),
                //     Text(
                //       'Completed',
                //       style:
                //           TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                //     ),
                //   ])),
                if (memberStatus == 'UNDECIDED' && !checkInButon
                    // &&
                    // DateTime(
                    //         _parseDate(dateString).year,
                    //         _parseDate(dateString).month,
                    //         _parseDate(dateString).day)
                    //     .isAfter(DateTime(DateTime.now().year,
                    //         DateTime.now().month, DateTime.now().day))

                    )
                  Center(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await EventHandlers.addAttendee(eventId,
                                BlocProvider.of<UserCubit>(context).state.id);
                            context
                                .pushNamed("projectevents", queryParameters: {
                              'projectId': projId,
                            }, pathParameters: {
                              'projectId': projId,
                            });
                          },
                          child: Text('Going'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await EventHandlers.addNonAttendee(eventId,
                                BlocProvider.of<UserCubit>(context).state.id);
                            context
                                .pushNamed("projectevents", queryParameters: {
                              'projectId': projId,
                            }, pathParameters: {
                              'projectId': projId,
                            });
                          },
                          child: Text('Not Going'),
                        ),
                      ],
                    ),
                  ),
                if (memberStatus == 'ATTENDING' &&
                    !checkInButon &&
                    !DateTime.parse(dateString).isBefore(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day)))
                  Center(
                      child: Column(children: [
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Attending',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ])),
                if (memberStatus == 'NOTATTENDING' &&
                    !checkInButon &&
                    _parseDate(dateString).isAfter(DateTime.now()))
                  Center(
                      child: Column(children: [
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Not Attending',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ])),
                if (eventAuthorized &&
                    !DateTime.parse(dateString).isBefore(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day)))
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          context.pushNamed("qrdisplay", queryParameters: {
                            'code': eventCode,
                          }, pathParameters: {
                            'code': eventCode,
                          });
                        },
                        child: Text('Generate QR code'),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCodeInputDialog(
      BuildContext context, String eventCode) async {
    String code = ''; // Initialize an empty string to hold the code

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
                    await EventHandlers.checkInUEventFromIds(
                        eventId, BlocProvider.of<UserCubit>(context).state.id);
                    context.pushNamed("checkedin", queryParameters: {
                      'eventId': eventId,
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
}
