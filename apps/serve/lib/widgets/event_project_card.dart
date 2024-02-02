import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final String dateString;
  final String timeString;
  final String name;

  EventCard({
    required this.dateString,
    required this.timeString,
    required this.name,
  });

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
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 160.0,
        child: GestureDetector(
          onTap: () {},
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => {},
                      child: Text('Going'),
                    ),
                    ElevatedButton(
                      onPressed: () => {},
                      child: Text('Not Going'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
