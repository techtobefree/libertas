import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
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
      List<UProject> groupprojs = [];
      for (var projId in group!.projects!) {
        var proj = await ProjectHandlers.getUProjectById(projId);
        groupprojs.add(proj!);
      }

      return groupprojs;
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

  static Future<void> addProject(String groupId, String projId) async {
    UGroup? group = await getUGroupById(groupId);

    if (group != null) {
      var groupprojects = group.projects ?? [];

      groupprojects.add(projId);

      final addedUProjUGroup = group.copyWith(projects: groupprojects);

      try {
        final request = ModelMutations.update(addedUProjUGroup);
        final response = await Amplify.API.mutate(request: request).response;
        safePrint('Response: $response');
      } catch (e) {
        throw Exception('Failed to update project: $e');
      }
    } else {
      print("failed");
    }
  }

  static Future<UGroup> updateUGroup(UGroup updatedGroup) async {
    try {
      final request = ModelMutations.update(updatedGroup);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
      return response.data!;
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }

  static Future<UGroup> modifyGroup(
    String id, {
    String? name,
    String? privacy,
    String? bio,
    String? description,
    String? city,
    String? state,
    String? leader,
    String? date,
    List<String>? projects,
    List<String>? members,
    List<String>? posts,
    String? groupPicture,
    String? zipCode,
  }) async {
    // Fetch the existing group by ID
    var group = await GroupHandlers.getUGroupById(id);

    // Ensure the group exists before attempting to modify
    if (group == null) {
      throw Exception('Group not found');
    }

    // Create a new group instance with the updated fields
    var newGroup = group.copyWith(
      name: name ?? group.name,
      privacy: privacy ?? group.privacy,
      bio: bio ?? group.bio,
      description: description ?? group.description,
      city: city ?? group.city,
      state: state ?? group.state,
      leader: leader ?? group.leader,
      date: date ?? group.date,
      projects: projects ?? group.projects,
      members: members ?? group.members,
      posts: posts ?? group.posts,
      groupPicture: groupPicture ?? group.groupPicture,
      zipCode: zipCode ?? group.zipCode,
    );

    try {
      // Update the group in the database
      final request = ModelMutations.update(newGroup);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } catch (e) {
      throw Exception('Failed to update group: $e');
    }

    return newGroup;
  }

  static Future<void> removeProject(String groupId, String projId) async {
    UGroup? group = await getUGroupById(groupId);

    if (group != null) {
      var groupprojects = group.projects ?? [];

      groupprojects.remove(projId);

      final removedUProjUGroup = group.copyWith(projects: groupprojects);

      try {
        final request = ModelMutations.update(removedUProjUGroup);
        final response = await Amplify.API.mutate(request: request).response;
        safePrint('Response: $response');
      } catch (e) {
        throw Exception('Failed to update project: $e');
      }
    } else {
      print("failed");
    }
  }
}
