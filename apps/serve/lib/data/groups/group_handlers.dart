import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class GroupHandlers {
  static Future<UGroup?> createGroup(UGroup newGroup) async {
    try {
      final request = ModelMutations.create(newGroup);
      final response = await Amplify.API.mutate(request: request).response;

      final createdGroup = response.data;
      if (createdGroup == null) {
        safePrint('errors: ${response.errors}');
        return null;
      } else {
        return createdGroup;
      }
    } catch (exeption) {
      throw Exception('Failed to get events: $exeption');
    }
  }

  static Future<List<UGroup?>> getUGroups() async {
    try {
      final request = ModelQueries.list(UGroup.classType);
      final response = await Amplify.API.query(request: request).response;

      final ugroup = response.data?.items;
      if (ugroup == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return ugroup;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  static Future<List<UGroup>> getMyUGroups(String id) async {
    try {
      var groups = await GroupHandlers.getUGroups();
      var myUGroups = <UGroup>[];

      for (var group in groups) {
        if (group!.members!.contains(id)) {
          myUGroups.add(group);
        }
      }

      return myUGroups;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  static Future<List<UProject>> getGroupUProjects(String id) async {
    try {
      var group = await GroupHandlers.getUGroupById(id);

      return group?.projects ?? [];
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  static Future<List<UGroup>> getFindUGroups(String id) async {
    try {
      var groups = await GroupHandlers.getUGroups();
      var myUGroups = <UGroup>[];

      for (var group in groups) {
        if (!group!.members!.contains(id)) {
          myUGroups.add(group);
        }
      }

      return myUGroups;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  static Future<UGroup?> getUGroupById(String id) async {
    final queryPredicate = UGroup.ID.eq(id);

    final request = ModelQueries.list<UGroup>(
      UGroup.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      return response.data!.items[0];
    }

    return null;
  }
}
