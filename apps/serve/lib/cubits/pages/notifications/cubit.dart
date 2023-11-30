import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/data/notifications/notification.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';

part 'state.dart';

class NotificationsCubit extends Cubit<NotificationsCubitState> {
  Stream<int>? periodic;
  NotificationsCubit() : super(const InitNotificationsState());

  void callPeriodically({
    required UserCubit userCubit,
    Duration period = const Duration(seconds: 5), //const Duration(minutes: 5),
  }) {
    periodic = Stream<int>.periodic(period, (_) {
      final userId = userCubit.state.id;
      if (userId != '') {
        print('calling loadNotifications $userId');
        loadNotifications(userId: userId);
      }
      return 0;
    });
  }

  void reset() => emit(const InitNotificationsState());

  void update({
    List<UNotification>? notifications,
    String? selected,
    bool? busy,
  }) =>
      emit(NotificationsState(
        notifications: notifications ?? state.notifications,
        selected: selected ?? state.selected,
        busy: busy ?? state.busy,
      ));

  Future<void> loadNotifications({
    required String userId,
  }) async {
    update(busy: true);
    update(notifications: await _fetchNotifications(userId), busy: false);
  }

  Future<List<UNotification>> _fetchNotifications(String userId) async {
    // Call the notificationHandlers.getnotificationsByOwner method
    // Replace 'yourOwnerId' with the actual owner ID you want to fetch notifications for
    // For example, you can get the owner ID from the currently logged-in user
    final List<UNotification?> notifications =
        await NotificationHandlers.getNotificationsByReceiverIDandIncomplete(
            userId);

    return notifications.whereType<UNotification>().toList();
  }
}
