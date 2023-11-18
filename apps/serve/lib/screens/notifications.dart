import 'package:flutter/material.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/notifications/cubit.dart';
import '../cubits/user/cubit.dart';
import '../data/leader_requests/handlers/leader_request_handlers.dart';
import '../widgets/leader_approval_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late Future<List<Map<String, dynamic>>> _notificationDataList;

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
        child: FutureBuilder(
          future: _notificationDataList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>> notificationDataList =
                  snapshot.data as List<Map<String, dynamic>>;
              if (notificationDataList.isEmpty) {
                return const Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text('No new notifications'))
                  ],
                );
              }

              return BlocBuilder<NotificationsCubit, NotificationsCubitState>(
                buildWhen: (previous, current) => previous.busy != current.busy,
                builder: (context, state) {
                  final notificationDataList = state.notificationDataList;
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: notificationDataList.length,
                          itemBuilder: (context, index) {
                            final notificationData =
                                notificationDataList[index];

                            return LeaderApprovalCard(
                              projName: notificationData.projName,
                              message: notificationData.message,
                              date: notificationData.date,
                              profURL: notificationData.profURL ?? '',
                              appId: notificationData.appId,
                              appName: notificationData.appName,
                              isRead: false,
                              onApprove: () {
                                try {
                                  // Handle the "Approve" button action here
                                  LeaderRequestHandlers
                                      .updateLeaderRequestStatis(
                                          notificationData.id,
                                          {'status': "APPROVED"});
                                  ProjectHandlers.addLeader(
                                    notificationData.projId,
                                    notificationData.appId,
                                  );

                                  print('Approved Notification ${index + 1}');
                                } catch (err) {
                                  print('approval failed $err');
                                }
                              },
                              onDeny: () {
                                // Handle the "Deny" button action here
                                LeaderRequestHandlers.updateLeaderRequestStatis(
                                    notificationData.id, {'status': "DENIED"});
                                print('Denied Notification ${index + 1}');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}