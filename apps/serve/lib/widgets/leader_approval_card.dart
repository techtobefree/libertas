import 'package:flutter/material.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';

class LeaderApprovalCard extends StatelessWidget {
  final String projName;
  final String message;
  final String date;
  final bool isRead; // Add a field to indicate whether the notification is read
  final void Function() onApprove;
  final void Function() onDeny;
  final String appName;
  final String profURL;
  final String appId;

  const LeaderApprovalCard({
    Key? key,
    required this.projName,
    required this.message,
    required this.date,
    this.isRead = false,
    required this.onApprove,
    required this.onDeny,
    required this.appName,
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
              'Leader Approval for $projName',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
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
                  appName,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onApprove,
                  child: Text('Approve'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreen),
                  ),
                ),
                ElevatedButton(
                  onPressed: onDeny,
                  child: Text('Deny'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
