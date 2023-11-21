import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/models/UPost.dart';

import '../../data/leader_requests/handlers/leader_request_handlers.dart';
import '../user/cubit.dart';

part 'state.dart';

class NotificationsCubit extends Cubit<NotificationsCubitState> {
  NotificationsCubit() : super(const InitNotificationsState());

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
