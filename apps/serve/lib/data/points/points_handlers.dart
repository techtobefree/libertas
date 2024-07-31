import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class PointsHandlers {
  static Future<UPoints?> newPoints(
      String userId, String actionStr, int pointVal) async {
    UUser? uuser = await UserHandlers.getUUserById(userId);

    UPoints upoints = UPoints(
        user: uuser!,
        action: actionStr,
        points: pointVal,
        date: DateTime.now().toString());
    try {
      final request = ModelMutations.create(upoints);
      final response = await Amplify.API.mutate(request: request).response;

      final createdPoints = response.data;
      if (createdPoints == null) {
        safePrint('errors: ${response.errors}');
        return null;
      } else {
        List<UPoints> userActions = uuser.pointsactions ?? [];
        userActions.add(createdPoints);
        int userBalance = uuser.pointsBalance ?? 0;
        await UserHandlers.modifyUser(
          uuser.id,
          pointsActions: userActions,
          pointsBalance: userBalance + createdPoints.points,
        );
        return createdPoints;
      }
    } catch (exeption) {
      throw Exception('Failed to get events: $exeption');
    }
  }

  static Future<int> getTotalUserPoints(String userId) async {
    int totalPoints = 0;
    List<UPoints?> myPoints = await getMyUPoints(userId);
    for (var point in myPoints) {
      totalPoints += point!.points;
    }
    return totalPoints;
  }

  static Future<List<UPoints?>> getMyUPoints(String userId) async {
    final queryPredicate = UPoints.USER.eq(userId);

    final request = ModelQueries.list<UPoints>(
      UPoints.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      return response.data!.items;
    }

    return [];
  }
}
