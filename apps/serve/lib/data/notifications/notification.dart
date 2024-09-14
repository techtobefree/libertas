import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class NotificationHandlers {
  static Future<UNotification?> createNotification({
    required String ownerID,
    required String applicantID,
    required String date,
    required String message,
    required String status,
    String? projectID,
  }) async {
    try {
      UUser? owner = await UserHandlers.getUUserById(ownerID);
      UUser? applicant = await UserHandlers.getUUserById(ownerID);
      UProject? project;
      final UNotification notification;
      if (projectID != null) {
        project = await ProjectHandlers.getUProjectById(projectID);

        notification = UNotification(
          sender: owner!,
          receiver: applicant!,
          date: date,
          message: message,
          status: status,
          project: project!,
        );
      } else {
        notification = UNotification(
            sender: owner!,
            receiver: applicant!,
            date: date,
            message: message,
            status: status,
            project: null);
      }

      final request = ModelMutations.create(notification);
      final response = await Amplify.API.mutate(request: request).response;

      final creatednotification = response.data;
      if (creatednotification == null) {
        safePrint('errors: ${response.errors}');
        return null;
      }

      return creatednotification;
    } catch (e) {
      throw Exception('Failed to create leader request: $e');
    }
  }

  static Future<List<UNotification?>> getNotificationsByReceiverID(
      String ownerID) async {
    try {
      // Fetching leader requests where the ownerID matches the provided ownerID
      final queryPredicate = UNotification.RECEIVER.eq(ownerID);
      final request = ModelQueries.list<UNotification>(
        UNotification.classType,
        where: queryPredicate,
      );

      final response = await Amplify.API.query(request: request).response;

      if (response.data != null) {
        return response.data!.items;
      } else {
        safePrint('errors: ${response.errors}');
        return [];
      }
    } catch (e) {
      throw Exception('Failed to get leader requests by owner: $e');
    }
  }

  static Future<List<UNotification?>> getNotificationsByReceiverIDandSenderId(
      String ownerID) async {
    try {
      final queryPredicate = UNotification.RECEIVER.eq(ownerID);
      final queryPredicate2 = UNotification.SENDER.eq(ownerID);
      final finalPredicate = queryPredicate.or(queryPredicate2);

      final request = ModelQueries.list<UNotification>(
        UNotification.classType,
        where: finalPredicate,
      );

      final response = await Amplify.API.query(request: request).response;

      if (response.data != null) {
        return response.data!.items;
      } else {
        safePrint('errors: ${response.errors}');
        return [];
      }
    } catch (e) {
      throw Exception('Failed to get leader requests by owner: $e');
    }
  }

  static Future<List<UNotification?>> getNotificationsByReceiverIDandIncomplete(
      String ownerID) async {
    try {
      // Fetching leader requests where the ownerID matches the provided ownerID
      final queryPredicate = UNotification.RECEIVER.eq(ownerID);
      final secondPredicate = UNotification.STATUS.eq("INCOMPLETE");
      final finalPredicate = queryPredicate.and(secondPredicate);
      final request = ModelQueries.list<UNotification>(
        UNotification.classType,
        where: finalPredicate,
      );

      final response = await Amplify.API.query(request: request).response;

      if (response.data != null) {
        return response.data!.items;
      } else {
        safePrint('errors: ${response.errors}');
        return [];
      }
    } catch (e) {
      throw Exception('Failed to get leader requests by owner: $e');
    }
  }

  static Future<void> deleteUNotification(UNotification notification) async {
    final request = ModelMutations.delete(notification);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Response: $response');
  }

  static Future<List<UNotification?>> getNotificationsBySenderIDandIncomplete(
      String userId) async {
    try {
      // Fetching leader requests where the ownerID matches the provided ownerID
      final queryPredicate = UNotification.SENDER.eq(userId);
      final secondPredicate = UNotification.STATUS.eq("INCOMPLETE");
      final finalPredicate = queryPredicate.and(secondPredicate);
      final request = ModelQueries.list<UNotification>(
        UNotification.classType,
        where: finalPredicate,
      );

      final response = await Amplify.API.query(request: request).response;

      if (response.data != null) {
        return response.data!.items;
      } else {
        safePrint('errors: ${response.errors}');
        return [];
      }
    } catch (e) {
      throw Exception('Failed to get leader requests by owner: $e');
    }
  }

  static Future<bool> isUserWaitingOnLeaderApproval(
      String userId, String projectId) async {
    var listOfIncompleteNotifs =
        await getNotificationsBySenderIDandIncomplete(userId);
    for (var notif in listOfIncompleteNotifs) {
      if (projectId == notif!.project!.id) {
        return true;
      }
    }
    return false;
  }

  static Future<UNotification?> updateNotificationStatus(
      String id, Map<String, dynamic> updatedFields) async {
    UNotification? notification = await getNotificationById(id);

    if (notification != null) {
      final updatednotification =
          notification.copyWith(status: updatedFields['status']);

      try {
        final request = ModelMutations.update(updatednotification);
        final response = await Amplify.API.mutate(request: request).response;

        safePrint('Response: $response');

        if (response.data != null) {
          UNotification? newnotification = response.data;
          return newnotification;
        } else {
          return null;
        }
      } catch (e) {
        throw Exception('Failed to update leader request: $e');
      }
    }

    return null;
  }

  static Future<UNotification?> getNotificationById(String id) async {
    final queryPredicate = UNotification.ID.eq(id);

    final request = ModelQueries.list<UNotification>(
      UNotification.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      return response.data!.items[0];
    }

    return null;
  }
}
