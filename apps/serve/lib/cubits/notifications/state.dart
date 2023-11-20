part of 'cubit.dart';

abstract class NotificationsCubitState extends Equatable {
  final List<UNotification> notifications;
  final String selected;
  final bool busy;

  const NotificationsCubitState({
    required this.notifications,
    required this.selected,
    required this.busy,
  });

  @override
  List<Object> get props => [
        notifications,
        selected,
        busy,
      ];

  List<NotificationItem> get notificationDataList => notifications
          .where((element) => element.status == "INCOMPLETE")
          .map((notification) {
        return NotificationItem(
            projName: notification.project!.name,
            message: notification.message,
            date: notification.date,
            id: notification.id,
            projId: notification.project!.id,
            senderName:
                '${notification.sender.firstName} ${notification.sender.lastName}',
            senderId: notification.sender.id,
            profURL: notification.sender.profilePictureUrl);
      }).toList();
}

class NotificationsState extends NotificationsCubitState {
  const NotificationsState({
    required super.notifications,
    required super.selected,
    required super.busy,
  });
}

class InitNotificationsState extends NotificationsCubitState {
  const InitNotificationsState()
      : super(
          notifications: const [],
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
  final String senderName;
  final String senderId;
  final String? profURL;

  const NotificationItem({
    required this.projName,
    required this.message,
    required this.date,
    required this.id,
    required this.projId,
    required this.senderId,
    required this.senderName,
    this.profURL,
  });
}
