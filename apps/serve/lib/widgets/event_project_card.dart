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

  const EventCard(
      {super.key,
      required this.dateString,
      required this.timeString,
      required this.name,
      required this.eventId,
      required this.memberStatus,
      required this.projId,
      this.checkInButon = false});

  static DateTime _parseDate(String dateString) {
    // Split the date string by '-' and convert to integers
    List<int> dateParts = dateString.split('-').map(int.parse).toList();
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
        print('x');
        context.pushNamed("eventdetails", queryParameters: {
          'id': eventId,
        }, pathParameters: {
          'id': eventId,
        });
      },
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 160.0,
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
                  ElevatedButton(
                    onPressed: () async {
                      await EventHandlers.checkInUEventFromIds(eventId,
                          BlocProvider.of<UserCubit>(context).state.id);
                      // ignore: use_build_context_synchronously
                      context.pushNamed("activeevents", queryParameters: {
                        'userId': BlocProvider.of<UserCubit>(context).state.id
                      }, pathParameters: {
                        'userId': BlocProvider.of<UserCubit>(context).state.id
                      });
                    },
                    child: const Text('Check In'),
                  ),
                if (memberStatus == 'UNDECIDED' && !checkInButon)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          await EventHandlers.addAttendee(eventId,
                              BlocProvider.of<UserCubit>(context).state.id);
                          context.pushNamed("projectevents", queryParameters: {
                            'projectId': projId,
                          }, pathParameters: {
                            'projectId': projId,
                          });
                        },
                        child: Text('Going'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await EventHandlers.addNonAttendee(eventId,
                              BlocProvider.of<UserCubit>(context).state.id);
                          context.pushNamed("projectevents", queryParameters: {
                            'projectId': projId,
                          }, pathParameters: {
                            'projectId': projId,
                          });
                        },
                        child: Text('Not Going'),
                      ),
                    ],
                  ),
                if (memberStatus == 'ATTENDING' && !checkInButon)
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
                if (memberStatus == 'NOTATTENDING' && !checkInButon)
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
