import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/leader_approval_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notificationDataList = [
      {
        'projName': 'Cleanup Beach',
        'message': 'You have a leadership request',
        'date': 'Oct 15, 2023',
      },
      {
        'projName': 'Notification 2',
        'message': 'You have a new message',
        'date': 'Oct 16, 2023',
      },
      // Add more notification data items here
    ];

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // Set the height of the AppBar
          child: AppBar(
            title: Text("Notifications"),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromRGBO(35, 107, 140, 1.0),
                      Color.fromRGBO(0, 28, 72, 1.0),
                    ]),
              ),
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 10, right: 5, left: 5),
            child: Column(children: [
              Expanded(
                child: ListView.builder(
                  itemCount: notificationDataList.length,
                  itemBuilder: (context, index) {
                    final notificationData = notificationDataList[index];

                    return LeaderApprovalCard(
                        projName: notificationData['projName'],
                        message: notificationData['message'],
                        date: notificationData['date'],
                        isRead: false,
                        onApprove: () {
                          // Handle the "Approve" button action here
                          print('Approved Notification ${index + 1}');
                        },
                        onDeny: () {
                          // Handle the "Deny" button action here
                          print('Denied Notification ${index + 1}');
                        });
                  },
                ),
              ),
            ])));
  }
}
