part of 'cubit.dart';

abstract class NotificationsCubitState extends Equatable {
  final List<ULeaderRequest> leaderRequests;
  final String selected;
  final bool busy;

  const NotificationsCubitState({
    required this.leaderRequests,
    required this.selected,
    required this.busy,
  });

  @override
  List<Object> get props => [
        leaderRequests,
        selected,
        busy,
      ];

  List<NotificationItem> get notificationDataList => leaderRequests
          .where((element) => element.status == "INCOMPLETE")
          .map((leaderRequest) {
        return NotificationItem(
            projName: leaderRequest.project.name,
            message: leaderRequest.message,
            date: leaderRequest.date,
            id: leaderRequest.id,
            projId: leaderRequest.project.id,
            appName: leaderRequest.applicant.name,
            appId: leaderRequest.applicant.id,
            profURL: leaderRequest.applicant.profilePictureUrl);
      }).toList();
}

class NotificationsState extends NotificationsCubitState {
  const NotificationsState({
    required super.leaderRequests,
    required super.selected,
    required super.busy,
  });
}

class InitNotificationsState extends NotificationsCubitState {
  const InitNotificationsState()
      : super(
          leaderRequests: const [],
          selected: 'All Notifications',
          busy: false,
        );
}

class NotificationItem {
  final String projName;
  final String message;
  final String date;
  final String id;
  final String projId;
  final String appName;
  final String appId;
  final String? profURL;

  const NotificationItem({
    required this.projName,
    required this.message,
    required this.date,
    required this.id,
    required this.projId,
    required this.appName,
    required this.appId,
    this.profURL,
  });
}
