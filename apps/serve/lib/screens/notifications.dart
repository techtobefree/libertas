import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/notifications/cubit.dart';
import '../cubits/user/cubit.dart';
import '../data/notifications/notification.dart';
import '../widgets/leader_approval_card.dart';
import '../widgets/message_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/cubits/user/cubit.dart';
import 'package:serve_to_be_free/widgets/leader_approval_card.dart';
import 'package:serve_to_be_free/cubits/notifications/cubit.dart';
import 'package:serve_to_be_free/data/notifications/notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  NotificationsPageState createState() => NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> {
  // late Future<List<Map<String, dynamic>>> _notificationDataList;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotificationsCubit>(context).loadNotifications(
        userId: BlocProvider.of<UserCubit>(context).state.id);
    // _notificationDataList = _fetchNotificationData(BlocProvider.of<UserCubit>(context).state.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          title: const Text("Notifications"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(35, 107, 140, 1.0),
                  Color.fromRGBO(0, 28, 72, 1.0),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10, right: 5, left: 5),
        child: BlocBuilder<NotificationsCubit, NotificationsCubitState>(
          buildWhen: (previous, current) => previous.busy != current.busy,
          builder: (context, state) {
            final notificationDataList = state.notificationDataList;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: notificationDataList.length,
                    itemBuilder: (context, index) {
                      final notificationData = notificationDataList[index];
                      if (notificationData.projId == null) {
                        return MessageCard(
                            message: notificationData.message,
                            date: notificationData.date,
                            onDismiss: () {
                              NotificationHandlers.updateNotificationStatus(
                                  notificationData.id, {
                                'status': "COMPLETE"
                              }).then((value) =>
                                  BlocProvider.of<NotificationsCubit>(context)
                                      .loadNotifications(
                                          userId: BlocProvider.of<UserCubit>(
                                                  context)
                                              .state
                                              .id));
                            },
                            senderName: notificationData.senderName,
                            profURL: notificationData.profURL ?? '',
                            appId: notificationData.senderId);
                      }

                      return LeaderApprovalCard(
                        projName: notificationData.projName ?? "",
                        message: notificationData.message,
                        date: notificationData.date,
                        profURL: notificationData.profURL ?? '',
                        appId: notificationData.senderId,
                        appName: notificationData.senderName,
                        isRead: false,
                        onApprove: () {
                          try {
                            // Handle the "Approve" button action here

                            showPopUp(
                                notificationData.senderId,
                                BlocProvider.of<UserCubit>(context).state.id,
                                notificationData.id,
                                {'status': "APPROVED"});
                            ProjectHandlers.addLeader(
                              notificationData.projId,
                              notificationData.senderId,
                            );

                            print('Approved Notification ${index + 1}');
                          } catch (err) {
                            print('approval failed $err');
                          }
                        },
                        onDeny: () {
                          // Handle the "Deny" button action here
                          showPopUp(
                              notificationData.senderId,
                              BlocProvider.of<UserCubit>(context).state.id,
                              notificationData.id,
                              {'status': "DENIED"});
                          ;
                          print('Denied Notification ${index + 1}');
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  dynamic showPopUp(String recieverId, String senderId, String notificationId,
      dynamic statusObj) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController messageController = TextEditingController();

        return AlertDialog(
          title: Text('Enter your message to applicant'),
          content: TextField(
            controller: messageController,
            decoration: InputDecoration(
              hintText: 'Type your message...',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String userMessage = messageController.text;

                NotificationHandlers.createNotification(
                  ownerID: recieverId,
                  applicantID: senderId,
                  date: DateFormat('MMM d, yyyy').format(DateTime.now()),
                  message: userMessage,
                  status: "INCOMPLETE",
                );

                Navigator.of(context).pop(); // Close the dialog
                NotificationHandlers.updateNotificationStatus(
                        notificationId, statusObj)
                    .then((value) =>
                        BlocProvider.of<NotificationsCubit>(context)
                            .loadNotifications(
                                userId: BlocProvider.of<UserCubit>(context)
                                    .state
                                    .id));

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thank you'),
                      content: Text('Your message has been sent.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the second dialog
                            BlocProvider.of<NotificationsCubit>(context)
                                .loadNotifications(
                                    userId: BlocProvider.of<UserCubit>(context)
                                        .state
                                        .id);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
//         ),
//       ),
//     );
//   }
// }
