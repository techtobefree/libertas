import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/leader_requests/handlers/leader_request_handlers.dart';
import 'package:serve_to_be_free/cubits/user/cubit.dart';
import 'package:serve_to_be_free/widgets/leader_approval_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  NotificationsPageState createState() => NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> {
  late Future<List<Map<String, dynamic>>> _notificationDataList;

  @override
  void initState() {
    super.initState();
    _notificationDataList = _fetchNotificationData();
  }

  Future<List<Map<String, dynamic>>> _fetchNotificationData() async {
    // Call the LeaderRequestHandlers.getLeaderRequestsByOwner method
    // Replace 'yourOwnerId' with the actual owner ID you want to fetch notifications for
    // For example, you can get the owner ID from the currently logged-in user
    final List<ULeaderRequest?> leaderRequests =
        await LeaderRequestHandlers.getLeaderRequestsByOwnerID(
            BlocProvider.of<UserCubit>(context).state.id);

    // Transform the leaderRequests into a list of notificationData
    // Adjust this logic based on your ULeaderRequest model structure
    var incompleteReqs = [];
    for (var req in leaderRequests) {
      if (req?.status == "INCOMPLETE") {
        incompleteReqs.add(req);
      }
    }
    final List<Map<String, dynamic>> notificationDataList =
        incompleteReqs.map((leaderRequest) {
              return {
                'projName': leaderRequest?.project.name,
                // // Replace with the actual attribute in your ULeaderRequest model
                'message': leaderRequest?.message,
                'date': leaderRequest?.date,
                'id': leaderRequest?.id,
                'projId': leaderRequest?.project.id,
                'appName': leaderRequest?.applicant.name,
                'appId': leaderRequest?.applicant.id,
                'profURL': leaderRequest?.applicant.profilePictureUrl
              };
            }).toList() ??
            [];

    return notificationDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
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
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10, right: 5, left: 5),
        child: FutureBuilder(
          future: _notificationDataList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>> notificationDataList =
                  snapshot.data as List<Map<String, dynamic>>;
              if (notificationDataList.isEmpty) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text('No new notifications'))
                  ],
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: notificationDataList.length,
                      itemBuilder: (context, index) {
                        final notificationData = notificationDataList[index];

                        return LeaderApprovalCard(
                          projName: notificationData['projName'],
                          message: notificationData['message'],
                          date: notificationData['date'],
                          profURL: notificationData['profURL'],
                          appId: notificationData['appId'],
                          appName: notificationData['appName'],
                          isRead: false,
                          onApprove: () {
                            try {
                              // Handle the "Approve" button action here
                              LeaderRequestHandlers.updateLeaderRequestStatis(
                                  notificationData['id'],
                                  {'status': "APPROVED"});
                              ProjectHandlers.addLeader(
                                  notificationData['projId'],
                                  notificationData['appId']);

                              print('Approved Notification ${index + 1}');
                            } catch (err) {
                              print('approval failed $err');
                            }
                          },
                          onDeny: () {
                            // Handle the "Deny" button action here
                            LeaderRequestHandlers.updateLeaderRequestStatis(
                                notificationData['id'], {'status': "DENIED"});
                            print('Denied Notification ${index + 1}');
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
