import 'package:flutter/material.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final String date;
  final bool isRead; // Add a field to indicate whether the notification is read
  final void Function() onDismiss;
  final String senderName;
  final String profURL;
  final String appId;

  const MessageCard({
    Key? key,
    required this.message,
    required this.date,
    this.isRead = false,
    required this.onDismiss,
    required this.senderName,
    required this.profURL,
    required this.appId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Message",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                ProfilePicture(Colors.indigoAccent, 50, profURL, appId),
                SizedBox(
                  width: 4,
                ),
                Text(
                  senderName,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              message,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              date,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            ElevatedButton(
              onPressed: onDismiss,
              child: Text('Dismiss'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
