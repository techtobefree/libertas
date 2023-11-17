import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class LeaderRequestHandlers {
  static Future<ULeaderRequest?> createLeaderRequest({
    required String ownerID,
    required String applicantID,
    required String date,
    required String message,
    required String status,
    required String projectID,
  }) async {
    try {
      UUser? owner = await UserHandlers.getUUserById(ownerID);
      UUser? applicant = await UserHandlers.getUUserById(ownerID);
      UProject? project = await ProjectHandlers.getUProjectById(projectID);

      final leaderRequest = ULeaderRequest(
        owner: owner!,
        applicant: applicant!,
        date: date,
        message: message,
        status: status,
        project: project!,
      );

      final request = ModelMutations.create(leaderRequest);
      final response = await Amplify.API.mutate(request: request).response;

      final createdLeaderRequest = response.data;
      if (createdLeaderRequest == null) {
        safePrint('errors: ${response.errors}');
        return null;
      }

      return createdLeaderRequest;
    } catch (e) {
      throw Exception('Failed to create leader request: $e');
    }
  }

  static Future<List<ULeaderRequest?>> getLeaderRequestsByOwnerID(
      String ownerID) async {
    try {
      // Fetching leader requests where the ownerID matches the provided ownerID
      final queryPredicate = ULeaderRequest.OWNER.eq(ownerID);
      final request = ModelQueries.list<ULeaderRequest>(
        ULeaderRequest.classType,
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

  static Future<ULeaderRequest?> updateLeaderRequestStatis(
      String id, Map<String, dynamic> updatedFields) async {
    ULeaderRequest? leaderRequest = await getLeaderRequestById(id);

    if (leaderRequest != null) {
      final updatedLeaderRequest =
          leaderRequest.copyWith(status: updatedFields['status']);

      try {
        final request = ModelMutations.update(updatedLeaderRequest);
        final response = await Amplify.API.mutate(request: request).response;

        safePrint('Response: $response');

        if (response.data != null) {
          ULeaderRequest? newLeaderRequest = response.data;
          return newLeaderRequest;
        } else {
          return null;
        }
      } catch (e) {
        throw Exception('Failed to update leader request: $e');
      }
    }

    return null;
  }

  static Future<ULeaderRequest?> getLeaderRequestById(String id) async {
    final queryPredicate = ULeaderRequest.ID.eq(id);

    final request = ModelQueries.list<ULeaderRequest>(
      ULeaderRequest.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      return response.data!.items[0];
    }

    return null;
  }
}
