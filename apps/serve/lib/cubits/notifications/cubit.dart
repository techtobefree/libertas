import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/data/leader_requests/handlers/leader_request_handlers.dart';

part 'state.dart';

class NotificationsCubit extends Cubit<NotificationsCubitState> {
  NotificationsCubit() : super(const InitNotificationsState());

  void callPeriodically({
    required UserCubit userCubit,
    Duration period = const Duration(minutes: 5),
  }) {
    this.stream = Stream<int>.periodic(period, (_) {
      final userId = userCubit.state.id;
      if (userId != '') {
        load(userId);
      }
    });
  }

  void reset() => emit(const InitNotificationsState());

  void update({
    List<ULeaderRequest>? leaderRequests,
    String? selected,
    bool? busy,
  }) =>
      emit(NotificationsState(
        leaderRequests: leaderRequests ?? state.leaderRequests,
        selected: selected ?? state.selected,
        busy: busy ?? state.busy,
      ));

  Future<void> loadNotifications({
    required String userId,
  }) async {
    update(busy: true);
    update(leaderRequests: await _fetchNotifications(userId), busy: false);
  }

  Future<List<ULeaderRequest>> _fetchNotifications(String userId) async {
    // Call the LeaderRequestHandlers.getLeaderRequestsByOwner method
    // Replace 'yourOwnerId' with the actual owner ID you want to fetch notifications for
    // For example, you can get the owner ID from the currently logged-in user
    final List<ULeaderRequest?> leaderRequests =
        await LeaderRequestHandlers.getLeaderRequestsByOwnerID(userId);

    return leaderRequests.whereType<ULeaderRequest>().toList();
  }
}
